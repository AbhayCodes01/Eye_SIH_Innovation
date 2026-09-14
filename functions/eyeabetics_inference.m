function result = eyeabetics_inference(imagePath)
% EYEABETICS_INFERENCE
% Master inference entry point for website integration.
%
% Input:
%   imagePath - path to fundus image
%
% Output:
%   result - MATLAB struct containing prediction results

fprintf('\n');
fprintf('============================================\n');
fprintf('       EYEABETICS WEB INFERENCE\n');
fprintf('============================================\n');

%% Paths

rootDir = '/MATLAB Drive';

addpath(genpath(fullfile(rootDir,'functions')));
addpath(genpath(fullfile(rootDir,'models')));

%% Check image

if ~exist(imagePath,'file')
    error('Image not found: %s',imagePath);
end

fprintf('Image: %s\n',imagePath);

Xoriginal = imread(imagePath);

fprintf('Original size: %s\n', ...
    mat2str(size(Xoriginal)));

%% =========================================================
% DR CLASSIFICATION
% ==========================================================

fprintf('\n[1/3] DR CLASSIFICATION\n');

% Load DR function

drFcn = @drClassifierFcn;

% Locate normalization/model files if available
% These are expected to already be loaded by the existing
% MATLAB model function environment.

if exist('norm1','var') && exist('norm2','var') && exist('drParams','var')

    Xdr = imresize(Xoriginal,[224 224]);
    Xdr = single(Xdr);
    Xdr = reshape(Xdr,[1 224 224 3]);

    Ydr = drFcn( ...
        Xdr, ...
        norm1, ...
        norm2, ...
        drParams, ...
        'InputDataPermutation','none');

    [drProb,drIdx] = max(Ydr);

    drGrade = drIdx - 1;

else

    warning('DR parameters not found in workspace.');

    drGrade = -1;
    drProb = 0;

end

fprintf('DR Grade: %d\n',drGrade);
fprintf('Confidence: %.2f%%\n',double(drProb)*100);

%% =========================================================
% LESION SEGMENTATION
% ==========================================================

fprintf('\n[2/3] LESION SEGMENTATION\n');

lesionModelPath = ...
    fullfile(rootDir,'models','idrid_lesion_unet_exp5.onnx');

if exist(lesionModelPath,'file')

    fprintf('Loading lesion ONNX...\n');

    lesionNet = importNetworkFromONNX( ...
        lesionModelPath, ...
        Namespace="EyeabeticsLesion");

    Xlesion = imresize(Xoriginal,[512 768]);
    Xlesion = single(Xlesion);

    % H W C -> C H W
    Xlesion = permute(Xlesion,[3 1 2]);

    % C H W -> 1 C H W
    Xlesion = reshape(Xlesion,[1 3 512 768]);

    % Convert to dlarray
    XlesionDL = dlarray(Xlesion,'SSCB');

    % Network inference
    Ylesion = predict(lesionNet,XlesionDL);

    Ylesion = extractdata(Ylesion);
    Ylesion = squeeze(Ylesion);

    % Handle possible dimension ordering
    dims = size(Ylesion);

    fprintf('Lesion output size: %s\n',mat2str(dims));

    % Convert logits to probabilities
    Ylesion = Ylesion - max(Ylesion,[],3);

    expY = exp(Ylesion);

    Yprob = expY ./ ...
        max(sum(expY,3),eps);

    [lesionConfidence,lesionMask] = ...
        max(Yprob,[],3);

else

    error('Lesion ONNX not found: %s',lesionModelPath);

end

fprintf('Lesion segmentation complete.\n');

%% =========================================================
% VESSEL SEGMENTATION
% ==========================================================

fprintf('\n[3/3] VESSEL SEGMENTATION\n');

if exist('vesselFcn','file')

    Xvessel = imresize(Xoriginal,[256 256]);
    Xvessel = single(Xvessel)/255;

    Yvessel = vesselFcn( ...
        Xvessel, ...
        vesselParams, ...
        'InputDataPermutation',[4 1 2 3]);

    vesselProb = squeeze(Yvessel);

    vesselMask = vesselProb > 0.5;

    vesselPercentage = ...
        100 * sum(vesselMask(:))/numel(vesselMask);

else

    warning('Vessel function unavailable.');

    vesselProb = [];
    vesselMask = [];
    vesselPercentage = 0;

end

fprintf('Vessel area: %.2f%%\n',vesselPercentage);

%% =========================================================
% RISK
% ==========================================================

if drGrade == 0

    riskLevel = "Low";

    recommendation = ...
        "No DR detected by AI screening.";

elseif drGrade == 1

    riskLevel = "Mild";

    recommendation = ...
        "Routine ophthalmic monitoring recommended.";

elseif drGrade == 2

    riskLevel = "Moderate";

    recommendation = ...
        "Ophthalmic evaluation recommended.";

else

    riskLevel = "High";

    recommendation = ...
        "Ophthalmologist referral recommended.";

end

%% =========================================================
% RESULT STRUCT
% ==========================================================

result = struct();

result.imageName = string(imagePath);

result.drGrade = double(drGrade);

result.drConfidence = double(drProb);

result.riskLevel = string(riskLevel);

result.recommendation = string(recommendation);

result.lesionMask = lesionMask;

result.lesionConfidence = lesionConfidence;

result.vesselMask = vesselMask;

result.vesselProbability = vesselProb;

result.vesselPercentage = double(vesselPercentage);

fprintf('\n============================================\n');
fprintf('       EYEABETICS INFERENCE COMPLETE\n');
fprintf('============================================\n');

end