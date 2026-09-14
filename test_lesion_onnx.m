clc;
clear;

fprintf('\n');
fprintf('============================================\n');
fprintf('      EYEABETICS LESION ONNX IMPORT TEST\n');
fprintf('============================================\n');

%% Project path

projectDir = 'C:\Users\KIIT\Downloads\Eyeabetics';
modelPath = fullfile(projectDir,'models', ...
    'idrid_lesion_unet_exp5.onnx');

%% Check ONNX

fprintf('\nChecking model files...\n');

assert(exist(modelPath,'file') == 2, ...
    'ONNX file not found.');

dataPath = [modelPath '.data'];

fprintf('ONNX      : FOUND\n');
fprintf('Path      : %s\n',modelPath);

if exist(dataPath,'file')
    infoData = dir(dataPath);
    fprintf('ONNX DATA : FOUND\n');
    fprintf('Data size : %.2f MB\n',infoData.bytes/1024^2);
else
    fprintf('ONNX DATA : NOT FOUND\n');
end

info = dir(modelPath);
fprintf('ONNX size : %.2f MB\n',info.bytes/1024^2);

%% Import

fprintf('\nImporting ONNX network...\n');

lesionNet = importNetworkFromONNX(modelPath);

fprintf('\n============================================\n');
fprintf('       ✅ LESION ONNX IMPORT SUCCESS\n');
fprintf('============================================\n');

disp(lesionNet);

fprintf('\nInput names:\n');
disp(lesionNet.InputNames);

fprintf('\nOutput names:\n');
disp(lesionNet.OutputNames);

fprintf('\nNetwork summary:\n');
summary(lesionNet);