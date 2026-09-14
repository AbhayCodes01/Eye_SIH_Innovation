%% EYEABETICS - COMPLETE MATLAB INFERENCE PIPELINE
% DR Classification + Lesion Segmentation + Vessel Segmentation

clc;
close all;

fprintf('\n');
fprintf('============================================\n');
fprintf('          EYEABETICS AI PIPELINE\n');
fprintf('============================================\n');

%% ============================================================
% 1. PATHS AND INPUT
% =============================================================

cd('/MATLAB Drive');

addpath(genpath('/MATLAB Drive/models'));

dataDir = '/MATLAB Drive/data/samples';

imageName = 'IDRiD_01.jpg';
imagePath = fullfile(dataDir,imageName);

fprintf('\nInput image: %s\n',imageName);

%% Load original fundus image

Xoriginal = imread(imagePath);

fprintf('Original image size: %s\n', ...
    mat2str(size(Xoriginal)));

%% ============================================================
% 2. CHECK REQUIRED MODELS / PARAMETERS
% =============================================================

fprintf('\nChecking model functions...\n');

fprintf('DR       : %s\n',which('drClassifierFcn'));
fprintf('Lesion   : %s\n',which('idridLesionFcn'));
fprintf('Vessel   : %s\n',which('vesselFcn'));

fprintf('\nChecking parameters...\n');

if ~exist('drParams','var')
    error('drParams is not loaded.');
end

if ~exist('lesionParams','var')
    error('lesionParams is not loaded.');
end

if ~exist('vesselParams','var')
    error('vesselParams is not loaded.');
end

if ~exist('norm1','var') || ~exist('norm2','var')
    error('DR normalization variables norm1/norm2 are not loaded.');
end

fprintf('All model parameters found.\n');

%% ============================================================
% 3. DR CLASSIFICATION
% =============================================================

fprintf('\n[1/3] DR CLASSIFICATION...\n');

% Resize to classifier input
Xdr = imresize(Xoriginal,[224 224]);

% Convert to single
Xdr = single(Xdr);

% Add batch dimension
Xdr = reshape(Xdr,[1 224 224 3]);

fprintf('DR input size: %s\n',mat2str(size(Xdr)));

% Run DR classifier
Ydr = drClassifierFcn( ...
    Xdr, ...
    norm1, ...
    norm2, ...
    drParams, ...
    'InputDataPermutation','none');

% Get predicted class
[drProb,drIdx] = max(Ydr);

drGrade = drIdx - 1;

fprintf('Predicted DR Grade : %d\n',drGrade);
fprintf('DR Confidence      : %.2f%%\n', ...
    double(drProb)*100);

%% ============================================================
% 4. LESION SEGMENTATION
% =============================================================

fprintf('\n[2/3] LESION SEGMENTATION...\n');

% Resize to lesion model input
Xlesion = imresize(Xoriginal,[512 768]);

Xlesion = single(Xlesion);

% Model expects:
% [batch, channels, height, width]
Xlesion = reshape(Xlesion,[1 512 768 3]);

Xlesion = permute(Xlesion,[1 4 2 3]);

fprintf('Lesion input size: %s\n', ...
    mat2str(size(Xlesion)));

% Run lesion U-Net
Ylesion = idridLesionFcn( ...
    Xlesion, ...
    lesionParams, ...
    'InputDataPermutation','none');

% Remove batch dimension
Ylesion = squeeze(Ylesion);

fprintf('Lesion output size: %s\n', ...
    mat2str(size(Ylesion)));

%% Convert lesion logits to probabilities

% Numerical-stability trick for softmax
expY = exp(Ylesion - max(Ylesion,[],3));

YlesionProb = expY ./ sum(expY,3);

%% Predicted lesion class per pixel

[lesionConfidence,lesionMask] = ...
    max(YlesionProb,[],3);

% Convert MATLAB 1,2,3 -> model classes 0,1,2
lesionMask = lesionMask - 1;

fprintf('Lesion probability range: %.4f -> %.4f\n', ...
    min(YlesionProb(:)), ...
    max(YlesionProb(:)));

fprintf('Lesion classes present:\n');
disp(unique(lesionMask)');

%% ============================================================
% 5. VESSEL SEGMENTATION
% =============================================================

fprintf('\n[3/3] VESSEL SEGMENTATION...\n');

% Resize to vessel model input
Xvessel = imresize(Xoriginal,[256 256]);

Xvessel = single(Xvessel) / 255;

fprintf('Vessel input size: %s\n', ...
    mat2str(size(Xvessel)));

% Run vessel U-Net
Yvessel = vesselFcn( ...
    Xvessel, ...
    vesselParams, ...
    'InputDataPermutation',[4 1 2 3]);

% Remove singleton dimension
vesselProb = squeeze(Yvessel);

fprintf('Vessel output size: %s\n', ...
    mat2str(size(vesselProb)));

%% Vessel binary mask

vesselMask = vesselProb > 0.5;

vesselPercentage = ...
    100 * sum(vesselMask(:)) / numel(vesselMask);

fprintf('Vessel pixels      : %d\n', ...
    sum(vesselMask(:)));

fprintf('Vessel percentage  : %.2f%%\n', ...
    vesselPercentage);

%% ============================================================
% 6. VISUALIZATION
% =============================================================

fprintf('\nGenerating visual results...\n');

figure( ...
    'Name','EYEABETICS - Complete AI Analysis', ...
    'Color','w');

tiledlayout(2,3,'Padding','compact');

%% Original

nexttile;

imshow(Xoriginal);

title('Original Fundus');

%% DR result

nexttile;

imshow(Xoriginal);

title(sprintf( ...
    'DR Grade %d | %.2f%%', ...
    drGrade, ...
    double(drProb)*100));

%% Lesion segmentation

nexttile;

imagesc(lesionMask);

axis image off;

colorbar;

title('Lesion Segmentation');

%% Vessel probability

nexttile;

imagesc(vesselProb);

axis image off;

colorbar;

title('Vessel Probability');

%% Vessel mask

nexttile;

imshow(vesselMask);

title(sprintf( ...
    'Vessel Mask | %.2f%%', ...
    vesselPercentage));

%% Vessel overlay

nexttile;

imshow(imresize(Xoriginal,[256 256]));

hold on;

h = imagesc(vesselMask);

set(h,'AlphaData',0.5*vesselMask);

axis image off;

title('Vessel Overlay');

hold off;

%% ============================================================
% 7. SCREENING RESULT
% =============================================================

fprintf('\n');
fprintf('============================================\n');
fprintf('             SCREENING RESULT\n');
fprintf('============================================\n');

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

elseif drGrade >= 3

    riskLevel = "High";
    recommendation = ...
        "Ophthalmologist referral recommended.";

end

fprintf('DR Grade       : %d\n',drGrade);
fprintf('Confidence     : %.2f%%\n', ...
    double(drProb)*100);

fprintf('Risk Level     : %s\n',riskLevel);

fprintf('Vessel Area    : %.2f%%\n', ...
    vesselPercentage);

fprintf('Recommendation : %s\n', ...
    recommendation);

fprintf('============================================\n');

%% ============================================================
% 8. STORE RESULTS
% =============================================================

results.imageName = imageName;

results.drGrade = drGrade;
results.drConfidence = double(drProb);

results.lesionMask = lesionMask;
results.lesionProbability = lesionConfidence;

results.vesselProbability = vesselProb;
results.vesselMask = vesselMask;
results.vesselPercentage = vesselPercentage;

results.riskLevel = riskLevel;
results.recommendation = recommendation;

%% Create results directory

if ~exist('/MATLAB Drive/results','dir')
    mkdir('/MATLAB Drive/results');
end

save( ...
    '/MATLAB Drive/results/results.mat', ...
    'results');

fprintf('\nResults saved to:\n');
fprintf('/MATLAB Drive/results/results.mat\n');

fprintf('\n============================================\n');
fprintf('       PIPELINE EXECUTION COMPLETE\n');
fprintf('============================================\n');