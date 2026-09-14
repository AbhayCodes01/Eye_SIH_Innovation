%% ============================================================
% EYEABETICS - FINAL DR ONNX TEST
% Experiment 7 Champion
%
% Purpose:
%   Verify that the final DR classifier ONNX model can be
%   imported and executed correctly inside MATLAB.
%
% IMPORTANT:
%   This script DOES NOT train anything.
%   This script DOES NOT modify the model.
%   This script DOES NOT optimize thresholds.
%
% PyTorch/ONNX format:
%   N x C x H x W
%
% MATLAB image format:
%   H x W x C x N
%% ============================================================

clear;
clc;

fprintf('\n============================================================\n');
fprintf('       EYEABETICS - FINAL DR ONNX TEST\n');
fprintf('============================================================\n');


%% ============================================================
% 1. PATHS
%% ============================================================

modelPath = '/MATLAB Drive/models/dr_classifier_experiment7_ensemble.onnx';

dataDir = '/MATLAB Drive/data/samples';


%% ============================================================
% 2. CHECK MODEL
%% ============================================================

fprintf('\n============================================================\n');
fprintf('CHECKING DR ONNX MODEL\n');
fprintf('============================================================\n');

if ~isfile(modelPath)
    error(['DR ONNX model not found:\n' modelPath]);
end

fprintf('✓ DR ONNX model found\n');
fprintf('  %s\n', modelPath);


%% ============================================================
% 3. IMPORT ONNX MODEL
%% ============================================================

fprintf('\n============================================================\n');
fprintf('IMPORTING ONNX MODEL\n');
fprintf('============================================================\n');

try

    net = importNetworkFromONNX(modelPath);

    fprintf('✓ ONNX model imported successfully\n');

catch ME

    fprintf('\n✗ ONNX IMPORT FAILED\n');
    rethrow(ME);

end


%% ============================================================
% 4. NETWORK INFORMATION
%% ============================================================

fprintf('\n============================================================\n');
fprintf('NETWORK INFORMATION\n');
fprintf('============================================================\n');

disp(net);

fprintf('\nInput names:\n');
disp(net.InputNames);

fprintf('Output names:\n');
disp(net.OutputNames);


%% ============================================================
% 5. FIND TEST IMAGE
%% ============================================================

fprintf('\n============================================================\n');
fprintf('TEST IMAGE\n');
fprintf('============================================================\n');

files = dir(fullfile(dataDir, '*.jpg'));

if isempty(files)
    error(['No JPG images found in:\n' dataDir]);
end

% Use the first image in the samples folder.
testImagePath = fullfile(dataDir, files(1).name);

fprintf('Using image:\n');
fprintf('%s\n', testImagePath);


%% ============================================================
% 6. READ IMAGE
%% ============================================================

I = imread(testImagePath);

fprintf('\nOriginal image size: ');
disp(size(I));


%% ============================================================
% 7. IMAGE PREPROCESSING
%
% MUST MATCH TRAINING PIPELINE:
%
%   RGB
%   resize to 260 x 260
%   single precision
%
% NOTE:
%   We do NOT manually convert to NCHW here.
%   MATLAB inference will use HWC format.
%% ============================================================

if size(I,3) == 1
    I = repmat(I, [1 1 3]);
end

if size(I,3) ~= 3
    error('Input image does not have 3 color channels.');
end

I = imresize(I, [260 260]);

I = im2single(I);

fprintf('\nPrepared MATLAB image size: ');
disp(size(I));

fprintf('Input type: %s\n', class(I));


%% ============================================================
% 8. CREATE MATLAB BATCH
%
% MATLAB:
%   H x W x C x N
%
% For one image:
%   260 x 260 x 3 x 1
%% ============================================================

inputMATLAB = reshape(I, [260 260 3 1]);

fprintf('\n============================================================\n');
fprintf('MATLAB INPUT FORMAT\n');
fprintf('============================================================\n');

fprintf('Input size:\n');
disp(size(inputMATLAB));

fprintf('Expected:\n');
fprintf('260 x 260 x 3 x 1\n');


%% ============================================================
% 9. CREATE DLAARRAY
%
% SSCB:
%
% S = Spatial
% S = Spatial
% C = Channel
% B = Batch
%% ============================================================

dlInput = dlarray(inputMATLAB, 'SSCB');

fprintf('✓ dlarray created\n');
fprintf('Dimension labels: SSCB\n');


%% ============================================================
% 10. RUN DR INFERENCE
%% ============================================================

fprintf('\n============================================================\n');
fprintf('RUNNING DR INFERENCE\n');
fprintf('============================================================\n');

try

    output = predict(net, dlInput);

    fprintf('✓ MATLAB inference completed\n');

catch ME

    fprintf('\n✗ INFERENCE FAILED\n');
    fprintf('\nError message:\n%s\n', ME.message);

    fprintf('\nIMPORTANT:\n');
    fprintf('The ONNX model was imported successfully.\n');
    fprintf('The failure is occurring during MATLAB inference.\n');

    rethrow(ME);

end


%% ============================================================
% 11. EXTRACT OUTPUT
%% ============================================================

fprintf('\n============================================================\n');
fprintf('PROCESSING MODEL OUTPUT\n');
fprintf('============================================================\n');

output = extractdata(output);

output = squeeze(output);

output = double(output);

fprintf('Output size:\n');
disp(size(output));


%% ============================================================
% 12. DISPLAY RAW OUTPUT
%% ============================================================

fprintf('\nRaw model output:\n');
disp(output);


%% ============================================================
% 13. CHECK OUTPUT
%% ============================================================

if numel(output) ~= 5

    error(['Expected 5 class probabilities, but received ' ...
           num2str(numel(output)) ' outputs.']);

end

fprintf('\nNumber of classes: %d\n', numel(output));


%% ============================================================
% 14. CHECK PROBABILITY SUM
%% ============================================================

probabilitySum = sum(output);

fprintf('\nProbability sum: %.6f\n', probabilitySum);

if abs(probabilitySum - 1) < 1e-3
    fprintf('✓ Output behaves as probability distribution\n');
else
    fprintf('⚠ Output does not sum to 1\n');
    fprintf('  This may indicate that the imported ONNX output\n');
    fprintf('  is logits rather than probabilities.\n');
end


%% ============================================================
% 15. DISPLAY CLASS PROBABILITIES
%
% DR classes:
%
% 0 = No DR
% 1 = Mild
% 2 = Moderate
% 3 = Severe
% 4 = Proliferative
%% ============================================================

fprintf('\n============================================================\n');
fprintf('DR CLASS PROBABILITIES\n');
fprintf('============================================================\n');

classNames = {
    'Class 0 - No DR'
    'Class 1 - Mild'
    'Class 2 - Moderate'
    'Class 3 - Severe'
    'Class 4 - Proliferative'
};

for k = 1:5

    fprintf('%s : %.6f\n', ...
        classNames{k}, output(k));

end


%% ============================================================
% 16. BASIC PREDICTION
%% ============================================================

[~, predictedClass] = max(output);

% MATLAB indexing is 1-5.
% Project classes are 0-4.

predictedClass = predictedClass - 1;


%% ============================================================
% 17. EXPERIMENT 7 FROZEN THRESHOLDS
%
% These thresholds were determined BEFORE the final held-out
% evaluation and are now frozen.
%
% IMPORTANT:
%   We are NOT optimizing anything here.
%% ============================================================

thresholds = [
    1.00
    1.05
    0.65
    0.85
    0.95
];


%% ============================================================
% 18. THRESHOLD-ADJUSTED PREDICTION
%
% The Experiment 7 procedure scales each class probability
% by its frozen threshold factor and selects the largest score.
%
% This reproduces the frozen threshold logic used for the
% final champion.
%% ============================================================

adjustedScores = output ./ thresholds;

[~, thresholdClass] = max(adjustedScores);

thresholdClass = thresholdClass - 1;


%% ============================================================
% 19. DISPLAY FINAL PREDICTION
%% ============================================================

fprintf('\n============================================================\n');
fprintf('BASIC DR PREDICTION\n');
fprintf('============================================================\n');

fprintf('Predicted class: %d\n', predictedClass);

fprintf('\n============================================================\n');
fprintf('EXPERIMENT 7 THRESHOLD-ADJUSTED PREDICTION\n');
fprintf('============================================================\n');

fprintf('Predicted class: %d\n', thresholdClass);


%% ============================================================
% 20. FINAL SUMMARY
%% ============================================================

fprintf('\n============================================================\n');
fprintf('FINAL DR ONNX TEST RESULT\n');
fprintf('============================================================\n');

fprintf('Model:\n');
fprintf('Experiment 7 Champion - 3-Fold Ensemble\n\n');

fprintf('Input:\n');
fprintf('260 x 260 RGB image\n');

fprintf('\nOutput:\n');
fprintf('5-class DR probabilities\n\n');

fprintf('Basic prediction      : Class %d\n', predictedClass);
fprintf('Threshold prediction  : Class %d\n', thresholdClass);

fprintf('\nFrozen thresholds:\n');

for k = 1:5
    fprintf('Class %d: %.2f\n', k-1, thresholds(k));
end


%% ============================================================
% 21. COMPLETION
%% ============================================================

fprintf('\n============================================================\n');
fprintf('✓ DR ONNX TEST COMPLETE\n');
fprintf('============================================================\n');

fprintf('\nThe Experiment 7 DR classifier is now tested inside MATLAB.\n');
fprintf('No training was performed.\n');
fprintf('No threshold optimization was performed.\n');
fprintf('No model weights were changed.\n');

fprintf('\nNEXT:\n');
fprintf('Test the Optic Disc U-Net ONNX model.\n');

fprintf('\n============================================================\n');