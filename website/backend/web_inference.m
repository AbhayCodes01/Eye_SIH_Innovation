function web_inference(imagePath,jsonPath,patientJson)

fprintf('\n');
fprintf('============================================\n');
fprintf('       EYEABETICS WEB INFERENCE\n');
fprintf('============================================\n');

%% ============================================================
% PROJECT PATH
% ============================================================

% Resolve from this file so the innovation copy is self-contained.
projectRoot = fileparts(fileparts(fileparts(mfilename('fullpath'))));

addpath(genpath(fullfile(projectRoot,'functions')));
addpath(genpath(fullfile(projectRoot,'models')));

fprintf('Project: %s\n',projectRoot);
fprintf('Image  : %s\n',imagePath);

%% ============================================================
% CHECK INPUT
% ============================================================

if ~isfile(imagePath)
    error('Input image not found: %s',imagePath);
end

%% ============================================================
% RUN COMPLETE EYEABETICS PIPELINE
% ============================================================

fprintf('\nRunning complete Eyeabetics pipeline...\n');

patient = struct();

if nargin >= 3 && ~isempty(patientJson)
    try
        patient = jsondecode(patientJson);
    catch
        warning('Patient context could not be decoded. Continuing without it.');
    end
end

hba1c = getNumericField(patient,'hba1c');
diabetesYears = getNumericField(patient,'diabetesYears');
systolicBP = getNumericField(patient,'systolicBP');

pipelineResult = predict_dr( ...
    imagePath, [], [], hba1c, diabetesYears, systolicBP);

%% ============================================================
% STRUCTURAL OVERLAY
% ============================================================

overlayPath = '';

if isfield(pipelineResult,'structuralPath') && ...
        ~isempty(pipelineResult.structuralPath)

    if isfile(pipelineResult.structuralPath)

        [~,baseName,~] = fileparts(imagePath);

        overlayPath = fullfile( ...
            fileparts(jsonPath), ...
            [baseName '_structural.png']);

        copyfile( ...
            pipelineResult.structuralPath, ...
            overlayPath);

        fprintf('Structural overlay copied:\n%s\n', ...
            overlayPath);

    else

        warning( ...
            'Structural visualization not found: %s', ...
            pipelineResult.structuralPath);

    end

end

%% ============================================================
% BUILD WEB-SAFE RESULT
% ============================================================

result = struct();

result.status = 'success';

%% IMAGE QUALITY

result.isGradeable = logical( ...
    pipelineResult.isGradeable);

result.qualityScore = double( ...
    pipelineResult.qualityScore);

result.qualityMessage = char( ...
    pipelineResult.qualityMessage);

%% DR CLASSIFICATION

result.drGrade = double( ...
    pipelineResult.grade);

result.drLabel = char( ...
    pipelineResult.gradeLabel);

result.drConfidence = double( ...
    pipelineResult.confidence);

%% RISK

result.riskScore = double( ...
    pipelineResult.riskScoreAdjusted);

%% REFERRAL

result.referral = pipelineResult.referral;

%% STRUCTURAL ANALYSIS

result.vesselPercentage = double( ...
    pipelineResult.vesselPercentage);

result.lesionCounts = pipelineResult.lesionCounts;

%% VISUALIZATION

result.overlayPath = overlayPath;

%% ============================================================
% CONVERT OVERLAY TO BASE64
% ============================================================

if ~isempty(overlayPath) && isfile(overlayPath)

    fid = fopen(overlayPath,'rb');

    if fid == -1
        error('Unable to open overlay file.');
    end

    imageBytes = fread(fid,Inf,'*uint8');

    fclose(fid);

    result.overlay = matlab.net.base64encode(imageBytes);

else

    result.overlay = '';

end

%% ============================================================
% MESSAGE
% ============================================================

result.message = ...
    'Complete Eyeabetics retinal analysis finished.';

%% ============================================================
% WRITE JSON
% ============================================================

jsonText = jsonencode(result);

fid = fopen(jsonPath,'w');

if fid == -1
    error( ...
        'Unable to create result JSON: %s', ...
        jsonPath);
end

fprintf(fid,'%s',jsonText);

fclose(fid);

%% ============================================================
% FINAL LOG
% ============================================================

fprintf('\n');
fprintf('============================================\n');
fprintf('       WEB INFERENCE COMPLETE\n');
fprintf('============================================\n');

fprintf('DR Grade       : %d\n', ...
    result.drGrade);

fprintf('DR Label       : %s\n', ...
    result.drLabel);

fprintf('Confidence     : %.2f%%\n', ...
    result.drConfidence * 100);

fprintf('Vessel Area    : %.2f%%\n', ...
    result.vesselPercentage);

fprintf('Risk Score     : %.2f\n', ...
    result.riskScore);

fprintf('Overlay        : %s\n', ...
    result.overlayPath);

fprintf('JSON           : %s\n', ...
    jsonPath);

fprintf('============================================\n');

end

function value = getNumericField(data,fieldName)
value = [];
if isstruct(data) && isfield(data,fieldName) && ~isempty(data.(fieldName))
    candidate = double(data.(fieldName));
    if isfinite(candidate)
        value = candidate;
    end
end
end
