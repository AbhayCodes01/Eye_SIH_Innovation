function [heatmapOverlay, predictedGrade, confidence] = gradcam_explain(trainedNet, img)
% GRADCAM_EXPLAIN Runs the trained classifier and generates a Grad-CAM
% attention heatmap overlaid on the fundus image, showing which regions
% drove the DR grade prediction. Uses MATLAB's built-in gradCAM function
% (Deep Learning Toolbox, R2021a+).
%
% Inputs:
%   trainedNet - trained DAGNetwork/dlnetwork classifier
%   img        - preprocessed RGB fundus image, uint8
%
% Outputs:
%   heatmapOverlay - RGB image with Grad-CAM heatmap overlaid
%   predictedGrade - predicted DR grade (0-4)
%   confidence     - calibrated softmax confidence (0-1)

    imgResized = imresize(img, trainedNet.Layers(1).InputSize(1:2));

    [predLabel, scores] = classify(trainedNet, imgResized);
    predictedGrade = double(predLabel) - 1; % categorical 0..4 -> numeric
    rawConfidence = max(scores);

    % ---- Temperature-scaled calibration ----
    % T > 1 softens overconfident predictions (typical for CNNs).
    % T should be fit on a held-out validation set (see calibrate_confidence.m);
    % 1.8 used here as a reasonable default starting point.
    T = 1.8;
    calibratedScores = softmaxTemperature(scores, T);
    confidence = max(calibratedScores);

    % ---- Grad-CAM ----
    % Target the last conv block of ResNet50 ('activation_49_relu')
    scoreMap = gradCAM(trainedNet, imgResized, predLabel, ...
        'FeatureLayer', 'activation_49_relu', ...
        'ReductionLayer', 'fc_dr');

    % ---- Overlay heatmap on original image ----
    heatmapOverlay = overlayHeatmap(imgResized, scoreMap);
end

function calibrated = softmaxTemperature(scores, T)
    logits = log(scores + eps);
    scaledLogits = logits / T;
    calibrated = exp(scaledLogits) / sum(exp(scaledLogits));
end

function overlay = overlayHeatmap(img, scoreMap)
    scoreMap = rescale(scoreMap); % normalize 0-1
    cmap = jet(256);
    heatmapRGB = ind2rgb(gray2ind(mat2gray(scoreMap), 256), cmap);
    heatmapRGB = imresize(heatmapRGB, [size(img,1) size(img,2)]);

    alpha = 0.45;
    overlay = im2uint8(im2double(img) * (1-alpha) + heatmapRGB * alpha);
end
