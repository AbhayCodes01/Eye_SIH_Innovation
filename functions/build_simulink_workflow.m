%% BUILD_SIMULINK_WORKFLOW
% Programmatically constructs a Simulink model simulating the district-
% scale telemedicine DR screening pipeline: patient arrival rate ->
% image acquisition -> bandwidth-limited transfer -> AI processing
% throughput -> ophthalmologist review queue.
%
% Goal: find bottlenecks and recommend camera/reviewer staffing to hit
% a target of clearing 100,000+ patients/year within SLA.
%
% Run this once to generate district_screening_model.slx, then open it
% in Simulink to run/tune interactively.

modelName = 'district_screening_model';
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end
new_system(modelName);
open_system(modelName);

%% ---- Patient Arrival (Poisson process source) ----
add_block('simulink/Sources/Pulse Generator', [modelName '/PatientArrival'], ...
    'Position', [30 50 90 80]);
set_param([modelName '/PatientArrival'], 'Period', '1', 'PulseWidth', '10'); % tune to arrival rate

%% ---- Image Acquisition Rate (cameras available) ----
add_block('simulink/Math Operations/Gain', [modelName '/CameraThroughput'], ...
    'Position', [150 50 210 80], 'Gain', 'numCameras'); % patients/hour per camera bank

%% ---- Bandwidth-Limited Transfer (saturation block models network cap) ----
add_block('simulink/Discontinuities/Saturation', [modelName '/BandwidthCap'], ...
    'Position', [270 50 330 80], 'UpperLimit', 'maxBandwidthImagesPerHour', 'LowerLimit', '0');

%% ---- AI Processing Throughput ----
add_block('simulink/Math Operations/Gain', [modelName '/AIProcessingRate'], ...
    'Position', [390 50 450 80], 'Gain', 'gpuThroughputFactor'); % images/sec model can clear

%% ---- Ophthalmologist Review Queue ----
add_block('simulink/Continuous/Integrator', [modelName '/ReviewQueue'], ...
    'Position', [510 50 570 80]);

%% ---- Reviewer Capacity (subtract cleared cases) ----
add_block('simulink/Math Operations/Gain', [modelName '/ReviewerCapacity'], ...
    'Position', [510 150 570 180], 'Gain', '-numOphthalmologists*casesPerHourPerReviewer');

add_block('simulink/Math Operations/Sum', [modelName '/QueueBalance'], ...
    'Position', [610 90 640 140], 'Inputs', '++');

%% ---- Scope to visualize queue length over simulated time ----
add_block('simulink/Sinks/Scope', [modelName '/QueueLengthScope'], ...
    'Position', [700 50 740 80]);
add_block('simulink/Sinks/To Workspace', [modelName '/QueueLengthLog'], ...
    'Position', [700 150 780 180], 'VariableName', 'queueLength');

%% ---- Wire the blocks together ----
add_line(modelName, 'PatientArrival/1', 'CameraThroughput/1');
add_line(modelName, 'CameraThroughput/1', 'BandwidthCap/1');
add_line(modelName, 'BandwidthCap/1', 'AIProcessingRate/1');
add_line(modelName, 'AIProcessingRate/1', 'QueueBalance/1');
add_line(modelName, 'ReviewerCapacity/1', 'QueueBalance/2');
add_line(modelName, 'QueueBalance/1', 'ReviewQueue/1');
add_line(modelName, 'ReviewQueue/1', 'QueueLengthScope/1');
add_line(modelName, 'ReviewQueue/1', 'QueueLengthLog/1');

%% ---- Set district-scale parameters (workspace variables Simulink reads) ----
numCameras = 4;                       % district health center cameras
maxBandwidthImagesPerHour = 300;      % rural connectivity constraint
gpuThroughputFactor = 0.98;           % near-1: AI processing rarely the bottleneck
numOphthalmologists = 2;              % reviewers available for the district
casesPerHourPerReviewer = 15;         % avg review rate with <30s-per-case tool

assignin('base', 'numCameras', numCameras);
assignin('base', 'maxBandwidthImagesPerHour', maxBandwidthImagesPerHour);
assignin('base', 'gpuThroughputFactor', gpuThroughputFactor);
assignin('base', 'numOphthalmologists', numOphthalmologists);
assignin('base', 'casesPerHourPerReviewer', casesPerHourPerReviewer);

save_system(modelName, [modelName '.slx']);
fprintf('Simulink model built: %s.slx\n', modelName);
fprintf('Open it and hit Run to see queue buildup; adjust numCameras / numOphthalmologists\n');
fprintf('until QueueLengthScope stabilizes (no runaway backlog) -> that is your staffing recommendation.\n');

%% ---- Sweep staffing levels to auto-recommend a config (district digital twin) ----
fprintf('\n=== Auto-sweep: recommended staffing to clear 100,000 patients/year ===\n');
targetAnnualPatients = 100000;
targetHourlyRate = targetAnnualPatients / (365*8); % assume 8hr clinic days
fprintf('Required sustained throughput: %.1f patients/hour\n', targetHourlyRate);

for cams = 2:8
    for docs = 1:5
        sustainedRate = min([cams*20, maxBandwidthImagesPerHour, ...
            docs*casesPerHourPerReviewer]);
        if sustainedRate >= targetHourlyRate
            fprintf('Feasible config found: %d cameras, %d ophthalmologists -> %.1f patients/hr\n', ...
                cams, docs, sustainedRate);
            break
        end
    end
    if sustainedRate >= targetHourlyRate
        break
    end
end
