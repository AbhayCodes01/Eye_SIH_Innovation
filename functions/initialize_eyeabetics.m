function [drParams, lesionParams, vesselParams] = initialize_eyeabetics()
% INITIALIZE_EYEABETICS
% Eyeabetics model initialization
%
% DR       : ONNX imported function
% Lesion   : ONNX imported dlnetwork
% Vessel   : ONNX imported dlnetwork

fprintf('\n');
fprintf('============================================\n');
fprintf('       EYEABETICS MODEL INITIALIZATION\n');
fprintf('============================================\n');

%% PROJECT PATH

functionsDir = fileparts(mfilename('fullpath'));
projectDir = fileparts(functionsDir);
modelDir = fullfile(projectDir,'models');

fprintf('\nModel directory:\n%s\n',modelDir);

%% ============================================================
% 1. DR CLASSIFIER
% ============================================================

fprintf('\n[1/3] Loading DR classifier...\n');

drModelPath = fullfile( ...
    modelDir,'dr_classifier_efficientnetb0.onnx');

if ~isfile(drModelPath)
    error('DR model not found: %s',drModelPath);
end

drParams = importONNXFunction( ...
    drModelPath, ...
    'drClassifierFcn');

fprintf('DR classifier ready.\n');

%% ============================================================
% 2. LESION U-NET
% ============================================================

fprintf('\n[2/3] Loading NEW lesion U-Net...\n');

lesionModelPath = fullfile( ...
    modelDir,'idrid_lesion_unet_exp5_matlab.onnx');

if ~isfile(lesionModelPath)
    error('Lesion model not found: %s',lesionModelPath);
end

lesionParams = importNetworkFromONNX(lesionModelPath);

fprintf('Lesion U-Net ready.\n');
fprintf('Lesion network type: %s\n',class(lesionParams));

%% ============================================================
% 3. VESSEL U-NET
% ============================================================

fprintf('\n[3/3] Loading vessel U-Net...\n');

vesselModelPath = fullfile( ...
    modelDir,'vessel_unet.onnx');

if ~isfile(vesselModelPath)
    error('Vessel model not found: %s',vesselModelPath);
end

vesselParams = importNetworkFromONNX(vesselModelPath);

fprintf('Vessel U-Net ready.\n');
fprintf('Vessel network type: %s\n',class(vesselParams));

%% ============================================================
% FINAL CHECK
% ============================================================

fprintf('\n============================================\n');
fprintf('       ALL THREE MODELS READY\n');
fprintf('============================================\n');

fprintf('DR      : %s\n',class(drParams));
fprintf('Lesion  : %s\n',class(lesionParams));
fprintf('Vessel  : %s\n',class(vesselParams));

end