%% BATCH_PREPROCESS_DATASET
% Run ONCE on the raw downloaded dataset (APTOS/IDRiD/EyePACS merged
% into data/raw/<grade>/*.png) to apply quality filtering + CLAHE
% enhancement, writing cleaned images into data/train and data/val.
%
% This keeps train_dr_classifier.m fast (no repeated CLAHE computation
% every epoch).

clear; clc;

rawDir = 'data/raw';
trainDir = 'data/train';
valDir = 'data/val';
targetSize = [224 224];
valSplit = 0.15;

grades = {'0','1','2','3','4'};
rng(42); % reproducible split

for g = 1:numel(grades)
    grade = grades{g};
    srcFolder = fullfile(rawDir, grade);
    files = dir(fullfile(srcFolder, '*.png'));
    if isempty(files)
        files = dir(fullfile(srcFolder, '*.jpg'));
    end

    n = numel(files);
    idx = randperm(n);
    nVal = round(n * valSplit);
    valIdx = idx(1:nVal);
    trainIdx = idx(nVal+1:end);

    trainOut = fullfile(trainDir, grade);
    valOut = fullfile(valDir, grade);
    if ~exist(trainOut, 'dir'); mkdir(trainOut); end
    if ~exist(valOut, 'dir'); mkdir(valOut); end

    rejectedCount = 0;
    for i = 1:n
        f = files(i);
        img = imread(fullfile(f.folder, f.name));

        [isGradeable, qScore, reason] = quality_assessment(img);
        if ~isGradeable
            rejectedCount = rejectedCount + 1;
            continue; % skip ungradeable training images
        end

        processed = preprocess_image(img, targetSize);

        if ismember(i, valIdx)
            outPath = fullfile(valOut, f.name);
        else
            outPath = fullfile(trainOut, f.name);
        end
        imwrite(processed, outPath);
    end

    fprintf('Grade %s: %d images processed, %d rejected (quality < threshold)\n', ...
        grade, n - rejectedCount, rejectedCount);
end

fprintf('\nPreprocessing complete. Ready for train_dr_classifier.m\n');
