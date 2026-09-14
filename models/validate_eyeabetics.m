clc;
clear;

fprintf('\n');
fprintf('====================================================\n');
fprintf('          EYEABETICS FINAL VALIDATION\n');
fprintf('====================================================\n');

cd('/MATLAB Drive');

%% ====================================================
% PATHS
% ====================================================

modelsDir = '/MATLAB Drive/models';
functionsDir = '/MATLAB Drive/functions';
dataDir = '/MATLAB Drive/data/samples';

addpath(genpath(modelsDir));
addpath(genpath(functionsDir));

%% ====================================================
% 1. CHECK MODEL FILES
% ====================================================

fprintf('\n[1] MODEL FILE CHECK\n');
fprintf('----------------------------------------------------\n');

modelFiles = {
    'dr_classifier_experiment7_ensemble.onnx'
    'idrid_lesion_unet_exp5.onnx'
    'vessel_unet.onnx'
    'optic_disc_unet_experiment6.onnx'
};

for i = 1:numel(modelFiles)

    p = fullfile(modelsDir,modelFiles{i});

    if exist(p,'file') == 2

        info = dir(p);

        fprintf('PASS  %-45s %.2f MB\n', ...
            modelFiles{i}, ...
            info.bytes/1024^2);

    else

        fprintf('FAIL  %s\n',modelFiles{i});

    end
end

%% ====================================================
% 2. CHECK MATLAB FUNCTIONS
% ====================================================

fprintf('\n[2] MATLAB FUNCTION CHECK\n');
fprintf('----------------------------------------------------\n');

functionNames = {
    'drClassifierFcn'
    'idridLesionFcn'
    'vesselFcn'
    'optic_disc_fovea_detect'
    'gradcam_explain'
    'quality_assessment'
    'segment_full_image'
    'predict_dr'
};

for i = 1:numel(functionNames)

    result = which(functionNames{i},'-all');

    if ~isempty(result)

        fprintf('PASS  %-30s %s\n', ...
            functionNames{i},result(1,:));

    else

        fprintf('FAIL  %s\n',functionNames{i});

    end
end

%% ====================================================
% 3. CHECK SAMPLE IMAGE
% ====================================================

fprintf('\n[3] SAMPLE IMAGE CHECK\n');
fprintf('----------------------------------------------------\n');

sampleImage = fullfile(dataDir,'IDRiD_55.jpg');

if exist(sampleImage,'file') == 2

    img = imread(sampleImage);

    fprintf('PASS  Image found\n');
    fprintf('      Path : %s\n',sampleImage);
    fprintf('      Size : %s\n',mat2str(size(img)));

else

    fprintf('FAIL  Sample image not found\n');

end

%% ====================================================
% 4. TEST ONNX IMPORT
% ====================================================

fprintf('\n[4] ONNX IMPORT CHECK\n');
fprintf('----------------------------------------------------\n');

onnxFiles = {
    'dr_classifier_experiment7_ensemble.onnx'
    'idrid_lesion_unet_exp5.onnx'
    'vessel_unet.onnx'
    'optic_disc_unet_experiment6.onnx'
};

for i = 1:numel(onnxFiles)

    p = fullfile(modelsDir,onnxFiles{i});

    if exist(p,'file') ~= 2
        fprintf('SKIP  %s (file missing)\n',onnxFiles{i});
        continue;
    end

    fprintf('\nTesting: %s\n',onnxFiles{i});

    try

        net = importNetworkFromONNX(p);

        fprintf('PASS  ONNX imported successfully\n');

        clear net;

    catch ME

        fprintf('WARN  ONNX import failed\n');
        fprintf('      %s\n',ME.message);

    end
end

%% ====================================================
% 5. SUMMARY
% ====================================================

fprintf('\n');
fprintf('====================================================\n');
fprintf('             VALIDATION COMPLETE\n');
fprintf('====================================================\n');

fprintf('\nIf model files and functions show PASS,\n');
fprintf('we move directly to inference integration.\n');

fprintf('\nNEXT:\n');
fprintf('1. Test lesion inference\n');
fprintf('2. Fix predict_dr.m\n');
fprintf('3. Run complete MATLAB pipeline\n');
fprintf('4. Simulink integration\n');
fprintf('5. Connect website\n');

fprintf('\n====================================================\n');