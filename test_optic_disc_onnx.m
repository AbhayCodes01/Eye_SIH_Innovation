%% ============================================================
% EYEABETICS - OPTIC DISC U-NET ONNX TEST
% Experiment 6
%
% Purpose:
%   Verify the trained Optic Disc U-Net inside MATLAB.
%
% IMPORTANT:
%   No training.
%   No threshold optimization.
%   No modification of the ONNX model.
%
% Frozen segmentation threshold:
%   0.775
%% ============================================================

clear;
clc;
close all;

fprintf('\n============================================================\n');
fprintf('       EYEABETICS - OPTIC DISC U-NET ONNX TEST\n');
fprintf('============================================================\n');


%% ============================================================
% 1. PATHS
%% ============================================================

modelPath = '/MATLAB Drive/models/optic_disc_unet_experiment6.onnx';

dataDir = '/MATLAB Drive/data/samples';


%% ============================================================
% 2. FROZEN THRESHOLD
%% ============================================================

OPTIC_DISC_THRESHOLD = 0.775;

fprintf('\n============================================================\n');
fprintf('FROZEN OPTIC DISC THRESHOLD\n');
fprintf('============================================================\n');

fprintf('Threshold: %.3f\n', OPTIC_DISC_THRESHOLD);
fprintf('✓ Threshold is frozen\n');
fprintf('✓ No threshold optimization will be performed\n');


%% ============================================================
% 3. CHECK MODEL
%% ============================================================

fprintf('\n============================================================\n');
fprintf('CHECKING OPTIC DISC ONNX MODEL\n');
fprintf('============================================================\n');

if ~isfile(modelPath)
    error(['Optic Disc ONNX model not found:\n' modelPath]);
end

fprintf('✓ Optic Disc ONNX model found\n');
fprintf('  %s\n', modelPath);


%% ============================================================
% 4. IMPORT ONNX MODEL
%% ============================================================

fprintf('\n============================================================\n');
fprintf('IMPORTING OPTIC DISC ONNX MODEL\n');
fprintf('============================================================\n');

try

    net = importNetworkFromONNX(modelPath);

    fprintf('✓ ONNX model imported successfully\n');

catch ME

    fprintf('\n✗ ONNX IMPORT FAILED\n');
    rethrow(ME);

end


%% ============================================================
% 5. NETWORK INFORMATION
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
% 6. FIND TEST IMAGE
%% ============================================================

fprintf('\n============================================================\n');
fprintf('TEST IMAGE\n');
fprintf('============================================================\n');

files = dir(fullfile(dataDir, '*.jpg'));

if isempty(files)
    error(['No JPG images found in:\n' dataDir]);
end

% Use the same first sample used by the previous test.
testImagePath = fullfile(dataDir, files(1).name);

fprintf('Using image:\n');
fprintf('%s\n', testImagePath);


%% ============================================================
% 7. READ IMAGE
%% ============================================================

I = imread(testImagePath);

fprintf('\nOriginal image size:\n');
disp(size(I));


%% ============================================================
% 8. ENSURE RGB
%% ============================================================

if size(I,3) == 1
    I = repmat(I,[1 1 3]);
end

if size(I,3) ~= 3
    error('Input image does not contain 3 RGB channels.');
end


%% ============================================================
% 9. DETERMINE NETWORK INPUT SIZE
%
% Try to obtain the expected spatial dimensions from the
% imported network rather than hard-coding them.
%% ============================================================

fprintf('\n============================================================\n');
fprintf('DETERMINING NETWORK INPUT SIZE\n');
fprintf('============================================================\n');

inputSize = [];

try

    firstLayer = net.Layers(1);

    if isprop(firstLayer,'InputSize')
        inputSize = firstLayer.InputSize;
    end

catch

    inputSize = [];

end


% If MATLAB does not expose the input size, use the standard
% U-Net working resolution used by this project.

if isempty(inputSize)

    fprintf('Network input size could not be read automatically.\n');
    fprintf('Using fallback size: 256 x 256\n');

    targetH = 256;
    targetW = 256;

else

    fprintf('Network input size reported as:\n');
    disp(inputSize);

    targetH = inputSize(1);
    targetW = inputSize(2);

end

fprintf('Target spatial size: %d x %d\n', targetH, targetW);


%% ============================================================
% 10. PREPROCESS IMAGE
%% ============================================================

Iresized = imresize(I,[targetH targetW]);

Iresized = im2single(Iresized);

fprintf('\nPrepared image size:\n');
disp(size(Iresized));

fprintf('Input type: %s\n',class(Iresized));


%% ============================================================
% 11. MATLAB BATCH FORMAT
%
% MATLAB image networks use:
%
%   H x W x C x N
%
% For one RGB image:
%
%   H x W x 3 x 1
%% ============================================================

inputMATLAB = reshape( ...
    Iresized, ...
    [targetH targetW 3 1] ...
    );

fprintf('\n============================================================\n');
fprintf('MATLAB INPUT FORMAT\n');
fprintf('============================================================\n');

fprintf('Input size:\n');
disp(size(inputMATLAB));

fprintf('Expected format:\n');
fprintf('H x W x C x N\n');


%% ============================================================
% 12. CREATE DLAARRAY
%% ============================================================

dlInput = dlarray(inputMATLAB,'SSCB');

fprintf('✓ dlarray created\n');
fprintf('✓ Dimension labels: SSCB\n');


%% ============================================================
% 13. RUN U-NET INFERENCE
%% ============================================================

fprintf('\n============================================================\n');
fprintf('RUNNING OPTIC DISC U-NET INFERENCE\n');
fprintf('============================================================\n');

try

    output = predict(net,dlInput);

    fprintf('✓ MATLAB inference completed\n');

catch ME

    fprintf('\n✗ INFERENCE FAILED\n');
    fprintf('\nError message:\n%s\n',ME.message);

    fprintf('\nDo NOT modify the ONNX model.\n');

    rethrow(ME);

end


%% ============================================================
% 14. EXTRACT OUTPUT
%% ============================================================

fprintf('\n============================================================\n');
fprintf('PROCESSING SEGMENTATION OUTPUT\n');
fprintf('============================================================\n');

output = extractdata(output);

output = squeeze(output);

output = double(output);

fprintf('Output size:\n');
disp(size(output));

fprintf('Output minimum: %.6f\n',min(output(:)));
fprintf('Output maximum: %.6f\n',max(output(:)));


%% ============================================================
% 15. CHECK WHETHER OUTPUT LOOKS LIKE PROBABILITY
%% ============================================================

if min(output(:)) >= 0 && max(output(:)) <= 1

    fprintf('✓ Output is within probability range [0,1]\n');

else

    fprintf('⚠ Output is not within [0,1]\n');
    fprintf('Applying sigmoid before thresholding.\n');

    output = 1 ./ (1 + exp(-output));

end


%% ============================================================
% 16. CREATE OPTIC DISC MASK
%% ============================================================

fprintf('\n============================================================\n');
fprintf('CREATING OPTIC DISC MASK\n');
fprintf('============================================================\n');

opticDiscMask = output >= OPTIC_DISC_THRESHOLD;

fprintf('Threshold: %.3f\n',OPTIC_DISC_THRESHOLD);

fprintf('Foreground pixels: %d\n',nnz(opticDiscMask));

fprintf('Total pixels: %d\n',numel(opticDiscMask));

coverage = nnz(opticDiscMask) / numel(opticDiscMask);

fprintf('Mask coverage: %.4f %%\n',coverage*100);


%% ============================================================
% 17. RESIZE RESULTS BACK TO ORIGINAL IMAGE SIZE
%% ============================================================

originalH = size(I,1);
originalW = size(I,2);

probabilityOriginal = imresize( ...
    output, ...
    [originalH originalW], ...
    'bilinear' ...
    );

maskOriginal = probabilityOriginal >= OPTIC_DISC_THRESHOLD;


%% ============================================================
% 18. VISUALIZATION
%% ============================================================

fprintf('\n============================================================\n');
fprintf('GENERATING OPTIC DISC VISUALIZATION\n');
fprintf('============================================================\n');

figure('Name','EYEABETICS - Optic Disc U-Net Test');

subplot(1,3,1);

imshow(I);

title('Original Fundus Image');


subplot(1,3,2);

imagesc(probabilityOriginal);

axis image off;

title('Optic Disc Probability');


subplot(1,3,3);

imshow(I);

hold on;

visboundaries(maskOriginal,'Color','r','LineWidth',1);

title('Optic Disc Segmentation');

hold off;


%% ============================================================
% 19. SAVE RESULTS
%% ============================================================

resultDir = '/MATLAB Drive/results';

if ~isfolder(resultDir)
    mkdir(resultDir);
end

[~,imageName,~] = fileparts(testImagePath);

maskPath = fullfile( ...
    resultDir, ...
    [imageName '_optic_disc_mask.png'] ...
    );

probPath = fullfile( ...
    resultDir, ...
    [imageName '_optic_disc_probability.png'] ...
    );


imwrite(uint8(maskOriginal)*255,maskPath);

probabilityImage = uint8( ...
    max(0,min(1,probabilityOriginal))*255 ...
    );

imwrite(probabilityImage,probPath);


fprintf('\n✓ Mask saved:\n');
fprintf('%s\n',maskPath);

fprintf('\n✓ Probability map saved:\n');
fprintf('%s\n',probPath);


%% ============================================================
% 20. FINAL STATUS
%% ============================================================

fprintf('\n============================================================\n');
fprintf('OPTIC DISC U-NET TEST COMPLETE\n');
fprintf('============================================================\n');

fprintf('Model:\n');
fprintf('Optic Disc U-Net - Experiment 6\n\n');

fprintf('Threshold:\n');
fprintf('%.3f\n\n',OPTIC_DISC_THRESHOLD);

fprintf('Inference:\n');
fprintf('✓ ONNX imported\n');
fprintf('✓ MATLAB inference completed\n');
fprintf('✓ Segmentation probability generated\n');
fprintf('✓ Optic disc mask generated\n');
fprintf('✓ Visualization generated\n');

fprintf('\nNO TRAINING PERFORMED.\n');
fprintf('NO THRESHOLD OPTIMIZATION PERFORMED.\n');

fprintf('\nNEXT:\n');
fprintf('Test the Vessel U-Net ONNX model.\n');

fprintf('\n============================================================\n');