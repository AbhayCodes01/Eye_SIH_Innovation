%% EYEABETICS DISTRICT SCREENING SIMULATION
% Initialization parameters for district-level telemedicine workflow.
% These values are simulation assumptions for prototype evaluation.

numCameras = 5;

maxBandwidthImagesPerHour = 300;

gpuThroughputFactor = 1;

numOphthalmologists = 3;

casesPerHourPerReviewer = 30;

fprintf('\n============================================\n');
fprintf(' EYEABETICS DISTRICT SIMULATION INITIALIZED\n');
fprintf('============================================\n');

fprintf('Screening cameras       : %d\n', numCameras);
fprintf('Bandwidth capacity      : %d images/hour\n', ...
    maxBandwidthImagesPerHour);
fprintf('AI throughput factor    : %.2f\n', ...
    gpuThroughputFactor);
fprintf('Ophthalmologists        : %d\n', ...
    numOphthalmologists);
fprintf('Cases/reviewer/hour     : %d\n', ...
    casesPerHourPerReviewer);

fprintf('Total review capacity   : %d cases/hour\n', ...
    numOphthalmologists * casesPerHourPerReviewer);

fprintf('============================================\n');