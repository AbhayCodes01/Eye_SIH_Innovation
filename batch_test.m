%% EYEABETICS - BATCH TEST ON 20 IDRiD IMAGES
clc;

fprintf('\n========================================\n');
fprintf('     EYEABETICS BATCH MODEL TEST\n');
fprintf('========================================\n');

dataDir = '/MATLAB Drive/data/samples';

files = dir(fullfile(dataDir,'*.jpg'));

fprintf('Images found: %d\n\n',numel(files));

% Results table
results = table();

for i = 1:numel(files)

    fprintf('\n----------------------------------------\n');
    fprintf('IMAGE %d/%d: %s\n',i,numel(files),files(i).name);
    fprintf('----------------------------------------\n');

    imagePath = fullfile(dataDir,files(i).name);
    Xoriginal = imread(imagePath);

    %% ================================
    % 1. DR CLASSIFICATION
    % ================================

    Xdr = imresize(Xoriginal,[224 224]);
    Xdr = single(Xdr);
    Xdr = reshape(Xdr,[1 224 224 3]);

    Ydr = drClassifierFcn( ...
        Xdr, ...
        norm1, ...
        norm2, ...
        drParams, ...
        'InputDataPermutation','none');

    [drConfidence,drIdx] = max(Ydr);

    drGrade = drIdx - 1;

    fprintf('DR Grade      : %d\n',drGrade);
    fprintf('DR Confidence : %.2f%%\n',drConfidence*100);


    %% ================================
    % 2. LESION SEGMENTATION
    % ================================

    Xlesion = imresize(Xoriginal,[512 768]);
    Xlesion = single(Xlesion);
    Xlesion = reshape(Xlesion,[1 512 768 3]);

    % ONNX expects [batch channels height width]
    Xlesion = permute(Xlesion,[1 4 2 3]);

    Ylesion = idridLesionFcn( ...
        Xlesion, ...
        lesionParams, ...
        'InputDataPermutation','none');

    fprintf('Lesion output : [%s]\n', ...
        num2str(size(Ylesion)));

    % Convert 3-class output into predicted class
    [~,lesionClass] = max(Ylesion,[],3);

    lesionClass = squeeze(lesionClass);

    lesionPixels = sum(lesionClass(:) > 1);

    fprintf('Lesion pixels : %d\n',lesionPixels);


    %% ================================
    % 3. VESSEL SEGMENTATION
    % ================================

    Xv = imresize(Xoriginal,[256 256]);
    Xv = single(Xv)/255;

    Yvessel = vesselFcn( ...
        Xv, ...
        vesselParams, ...
        'InputDataPermutation',[4 1 2 3]);

    vesselProb = squeeze(Yvessel);

    vesselMask = vesselProb > 0.5;

    vesselPercentage = ...
        100 * sum(vesselMask(:)) / numel(vesselMask);

    fprintf('Vessel area   : %.2f%%\n',vesselPercentage);


    %% ================================
    % 4. SAVE RESULT
    % ================================

    newRow = table( ...
        string(files(i).name), ...
        drGrade, ...
        drConfidence, ...
        lesionPixels, ...
        vesselPercentage, ...
        'VariableNames',{ ...
        'Image', ...
        'DR_Grade', ...
        'DR_Confidence', ...
        'Lesion_Pixels', ...
        'Vessel_Percentage'});

    results = [results; newRow];

end


%% =====================================
% DISPLAY FINAL RESULTS
% =====================================

fprintf('\n\n========================================\n');
fprintf('          BATCH TEST COMPLETE\n');
fprintf('========================================\n');

disp(results);


%% =====================================
% SAVE RESULTS
% =====================================

if ~exist('/MATLAB Drive/results','dir')
    mkdir('/MATLAB Drive/results');
end

save('/MATLAB Drive/results/batch_results.mat','results');

writetable( ...
    results, ...
    '/MATLAB Drive/results/batch_results.csv');

fprintf('\nResults saved to:\n');
fprintf('/MATLAB Drive/results/batch_results.mat\n');
fprintf('/MATLAB Drive/results/batch_results.csv\n');

fprintf('\n========================================\n');