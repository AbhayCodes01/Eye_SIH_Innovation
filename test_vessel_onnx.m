%% ============================================================
%  EYEABETICS - VESSEL U-NET ONNX TEST
%  Existing Vessel U-Net from MATLAB project
% =============================================================

clc;
clear;

fprintf('\n============================================================\n');
fprintf('       EYEABETICS - VESSEL U-NET ONNX TEST\n');
fprintf('============================================================\n\n');


%% ============================================================
%  PATHS
% =============================================================

modelPath = '/MATLAB Drive/models/vessel_unet.onnx';
dataDir   = '/MATLAB Drive/data/samples';
resultDir = '/MATLAB Drive/results';

if ~exist(resultDir, 'dir')
    mkdir(resultDir);
end


%% ============================================================
%  CHECK MODEL
% =============================================================

fprintf('============================================================\n');
fprintf('CHECKING VESSEL ONNX MODEL\n');
fprintf('============================================================\n');

if ~isfile(modelPath)
    error('Vessel ONNX model not found:\n%s', modelPath);
end

fprintf('✓ Vessel ONNX model found\n');
fprintf('  %s\n\n', modelPath);


%% ============================================================
%  IMPORT ONNX
% =============================================================

fprintf('============================================================\n');
fprintf('IMPORTING VESSEL U-NET ONNX MODEL\n');
fprintf('============================================================\n\n');

try

    net = importNetworkFromONNX(modelPath);

    fprintf('✓ ONNX model imported successfully\n\n');

catch ME

    fprintf('\n✗ ONNX IMPORT FAILED\n');
    rethrow(ME);

end


%% ============================================================
%  NETWORK INFORMATION
% =============================================================

fprintf('============================================================\n');
fprintf('NETWORK INFORMATION\n');
fprintf('============================================================\n');

disp(net);

fprintf('\nInput names:\n');
disp(net.InputNames);

fprintf('Output names:\n');
disp(net.OutputNames);


%% ============================================================
%  TEST IMAGE
% =============================================================

files = dir(fullfile(dataDir, '*.jpg'));

if isempty(files)
    error('No JPG images found in %s', dataDir);
end

% Use the same type of test image used for the other models
testImagePath = fullfile(dataDir, 'IDRiD_55.jpg');

if ~isfile(testImagePath)
    testImagePath = fullfile(dataDir, files(1).name);
end

fprintf('\n============================================================\n');
fprintf('TEST IMAGE\n');
fprintf('============================================================\n');

fprintf('Using image:\n%s\n\n', testImagePath);

I = imread(testImagePath);

fprintf('Original image size:\n');
disp(size(I));


%% ============================================================
%  DETERMINE NETWORK INPUT SIZE
% =============================================================

fprintf('\n============================================================\n');
fprintf('DETERMINING NETWORK INPUT SIZE\n');
fprintf('============================================================\n');

inputLayer = net.InputNames{1};

inputSize = [];

try

    % Search network layers for input dimensions
    layers = net.Layers;

    for k = 1:numel(layers)

        layer = layers(k);

        if isprop(layer, 'InputSize')

            s = layer.InputSize;

            if numel(s) >= 2
                inputSize = s;
                break;
            end

        end

    end

catch

    inputSize = [];

end


% Default if MATLAB cannot expose the input size
if isempty(inputSize)

    fprintf('⚠ Could not automatically determine input size.\n');
    fprintf('Using 512 x 512 x 3.\n');

    targetH = 512;
    targetW = 512;

else

    fprintf('Network input size reported as:\n');
    disp(inputSize);

    targetH = inputSize(1);
    targetW = inputSize(2);

end

fprintf('Target spatial size: %d x %d\n', targetH, targetW);


%% ============================================================
%  PREPARE IMAGE
% =============================================================

I = im2single(I);

I = imresize(I, [targetH targetW]);

if size(I,3) == 1
    I = repmat(I, [1 1 3]);
end

fprintf('\nPrepared image size:\n');
disp(size(I));

fprintf('Input type: %s\n', class(I));


%% ============================================================
%  MATLAB INPUT FORMAT
% =============================================================

fprintf('\n============================================================\n');
fprintf('MATLAB INPUT FORMAT\n');
fprintf('============================================================\n');

fprintf('Input size:\n');
disp(size(I));

fprintf('\nExpected format:\n');
fprintf('H x W x C x N\n');

dlInput = dlarray(I, 'SSC');

fprintf('✓ dlarray created\n');
fprintf('✓ Dimension labels: SSC\n');


%% ============================================================
%  RUN INFERENCE
% =============================================================

fprintf('\n============================================================\n');
fprintf('RUNNING VESSEL U-NET INFERENCE\n');
fprintf('============================================================\n\n');

try

    output = predict(net, dlInput);

    fprintf('✓ MATLAB inference completed\n\n');

catch ME

    fprintf('\n✗ VESSEL INFERENCE FAILED\n\n');
    rethrow(ME);

end


%% ============================================================
%  PROCESS OUTPUT
% =============================================================

fprintf('============================================================\n');
fprintf('PROCESSING SEGMENTATION OUTPUT\n');
fprintf('============================================================\n');

output = extractdata(output);

output = squeeze(output);

fprintf('Output size:\n');
disp(size(output));

fprintf('Output minimum: %f\n', min(output(:)));
fprintf('Output maximum: %f\n', max(output(:)));


%% ============================================================
%  CONVERT OUTPUT TO PROBABILITY
% =============================================================

if min(output(:)) < 0 || max(output(:)) > 1

    fprintf('\n⚠ Output is not within [0,1]\n');
    fprintf('Applying sigmoid before thresholding.\n');

    probability = 1 ./ (1 + exp(-output));

else

    fprintf('\n✓ Output already appears to be probability values.\n');

    probability = output;

end


fprintf('\nProbability minimum: %f\n', min(probability(:)));
fprintf('Probability maximum: %f\n', max(probability(:)));


%% ============================================================
%  THRESHOLD
% ============================================================

% IMPORTANT:
% This is only a neutral testing threshold.
% We will replace it with the project's frozen vessel threshold
% if the existing vessel pipeline specifies a different value.

vesselThreshold = 0.50;

fprintf('\n============================================================\n');
fprintf('VESSEL SEGMENTATION\n');
fprintf('============================================================\n');

fprintf('Testing threshold: %.3f\n', vesselThreshold);

mask = probability >= vesselThreshold;

foregroundPixels = nnz(mask);
totalPixels = numel(mask);
coverage = 100 * foregroundPixels / totalPixels;

fprintf('Foreground pixels: %d\n', foregroundPixels);
fprintf('Total pixels: %d\n', totalPixels);
fprintf('Mask coverage: %.4f %%\n', coverage);


%% ============================================================
%  SAVE RESULTS
% =============================================================

fprintf('\n============================================================\n');
fprintf('SAVING VESSEL RESULTS\n');
fprintf('============================================================\n');

[~, imageName, ~] = fileparts(testImagePath);

maskPath = fullfile( ...
    resultDir, ...
    [imageName '_vessel_mask.png']);

probPath = fullfile( ...
    resultDir, ...
    [imageName '_vessel_probability.png']);

imwrite(uint8(mask) * 255, maskPath);

imwrite(probability, probPath);

fprintf('✓ Vessel mask saved:\n');
fprintf('%s\n\n', maskPath);

fprintf('✓ Vessel probability map saved:\n');
fprintf('%s\n\n', probPath);


%% ============================================================
%  VISUALIZATION
% =============================================================

fprintf('============================================================\n');
fprintf('GENERATING VESSEL VISUALIZATION\n');
fprintf('============================================================\n');

figure('Name', 'EYEABETICS - Vessel U-Net Test', ...
       'NumberTitle', 'off');

subplot(1,3,1);

imshow(I);

title('Original Fundus');


subplot(1,3,2);

imshow(probability, []);

title('Vessel Probability');


subplot(1,3,3);

imshow(mask);

title('Vessel Segmentation');


fprintf('\n✓ Visualization generated\n');


%% ============================================================
%  FINAL STATUS
% =============================================================

fprintf('\n============================================================\n');
fprintf('✓ VESSEL U-NET TEST COMPLETE\n');
fprintf('============================================================\n\n');

fprintf('Model:\n');
fprintf('Existing Vessel U-Net ONNX\n\n');

fprintf('Input:\n');
fprintf('%d x %d RGB image\n\n', targetH, targetW);

fprintf('Inference:\n');
fprintf('✓ ONNX imported\n');
fprintf('✓ MATLAB inference completed\n');
fprintf('✓ Probability map generated\n');
fprintf('✓ Vessel mask generated\n');
fprintf('✓ Visualization generated\n\n');

fprintf('NOTE:\n');
fprintf('This test did NOT train or modify the Vessel U-Net.\n');
fprintf('Threshold 0.50 is only a temporary test threshold.\n');
fprintf('The final project threshold will be taken from the existing\n');
fprintf('vessel pipeline if one is already defined.\n\n');

fprintf('NEXT:\n');
fprintf('Integrate the newly trained/retrained models into the\n');
fprintf('existing MATLAB pipeline.\n');

fprintf('\n============================================================\n\n');