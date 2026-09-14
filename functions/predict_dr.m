function result = predict_dr(imagePath, patientLat, patientLon, ...
    hba1c, diabetesYears, systolicBP)
% PREDICT_DR
% Complete Eyeabetics inference pipeline using ONNX models.
%
% Models:
%   1. EfficientNet-B0 DR classifier
%   2. IDRiD lesion U-Net
%   3. Vessel U-Net
%
% The models must first be initialized using:
%
% [drParams, lesionParams, vesselParams] = initialize_eyeabetics();

    fprintf('\n');
    fprintf('============================================\n');
    fprintf('       EYEABETICS MASTER PIPELINE\n');
    fprintf('============================================\n');

    %% ============================================================
    % CHECK INPUT
    % ============================================================

    if nargin < 2 || isempty(patientLat)
        patientLat = 26.1445;
    end

    if nargin < 3 || isempty(patientLon)
        patientLon = 91.7362;
    end

    if nargin < 4
        hba1c = [];
    end

    if nargin < 5
        diabetesYears = [];
    end

    if nargin < 6
        systolicBP = [];
    end

    if ~isfile(imagePath)
        error('Image file not found: %s',imagePath);
    end

    %% ============================================================
    % LOAD MODELS
    % ============================================================

    persistent drParamsPersistent
persistent lesionNetPersistent
persistent vesselNetPersistent

if isempty(drParamsPersistent) || ...
   isempty(lesionNetPersistent) || ...
   isempty(vesselNetPersistent)

    fprintf('\nLoading models...\n');

    [drParamsPersistent, ...
     lesionNetPersistent, ...
     vesselNetPersistent] = initialize_eyeabetics();

end

    %% ============================================================
    % LOAD IMAGE
    % ============================================================

    fprintf('\nInput image:\n%s\n',imagePath);

    rawImg = imread(imagePath);

    fprintf('Original image size: %s\n', ...
        mat2str(size(rawImg)));

    %% ============================================================
    % 1. QUALITY ASSESSMENT
    % ============================================================

    fprintf('\n============================================\n');
    fprintf('[1/5] IMAGE QUALITY\n');
    fprintf('============================================\n');

    try

        [isGradeable, qualityScore, qualityMessage] = ...
            quality_assessment(rawImg);

    catch ME

        warning('Quality assessment failed: %s',ME.message);

        % For prototype operation, continue.
        isGradeable = true;
        qualityScore = 1.0;
        qualityMessage = 'Quality gate unavailable; image processed.';

    end

    fprintf('Gradeable    : %d\n',isGradeable);
    fprintf('Quality score: %.4f\n',double(qualityScore));
    fprintf('Message      : %s\n',qualityMessage);

    %% Stop if image is unusable

    if ~isGradeable

        result = struct();

        result.isGradeable = false;
        result.qualityScore = qualityScore;
        result.qualityMessage = qualityMessage;

        result.grade = -1;
        result.gradeLabel = 'UNGRADEABLE';
        result.confidence = 0;

        result.riskScoreAdjusted = -1;

        result.heatmapPath = '';
        result.structuralPath = '';

        result.referral = struct( ...
            'urgency','N/A', ...
            'timeframe','N/A', ...
            'message',qualityMessage, ...
            'nearestCenter','', ...
            'distanceKm',0);

        fprintf('\nIMAGE REJECTED BY QUALITY GATE.\n');

        return;

    end

    %% ============================================================
    % 2. DR CLASSIFICATION
    % ============================================================

    fprintf('\n============================================\n');
    fprintf('[2/5] DR CLASSIFICATION\n');
    fprintf('============================================\n');

    Xdr = imresize(rawImg,[224 224]);

    Xdr = single(Xdr);

    % Model expects:
    % [batch height width channels]
    Xdr = reshape(Xdr,[1 224 224 3]);

    normMean = single(reshape( ...
        [0.485 0.456 0.406], ...
        [1 1 1 3]));

    normStd = single(reshape( ...
        [0.229 0.224 0.225], ...
        [1 1 1 3]));

    fprintf('DR input size: %s\n', ...
        mat2str(size(Xdr)));

    Ydr = drClassifierFcn( ...
        Xdr, ...
        normMean, ...
        normStd, ...
        drParamsPersistent, ...
        'InputDataPermutation','none');

    Ydr = squeeze(Ydr);

    [drProb,drIdx] = max(Ydr);

    drGrade = double(drIdx) - 1;

    confidence = double(drProb);

    gradeLabels = { ...
        '0 - No DR', ...
        '1 - Mild', ...
        '2 - Moderate', ...
        '3 - Severe', ...
        '4 - Proliferative DR'};

    gradeLabel = gradeLabels{drGrade + 1};

    fprintf('DR Grade   : %d\n',drGrade);
    fprintf('DR Label   : %s\n',gradeLabel);
    fprintf('Confidence : %.2f%%\n',confidence * 100);

    %% ============================================================
    % 3. LESION + VESSEL SEGMENTATION
    % ============================================================

    fprintf('\n============================================\n');
    fprintf('[3/5] STRUCTURAL SEGMENTATION\n');
    fprintf('============================================\n');

   % Current lesion model has 4 output channels.
% Channel 1 = background.
lesionClassNames = { ...
    'background', ...
    'class2', ...
    'class3', ...
    'class4'};

[vesselMask, lesionMask, lesionClassNames] = ...
    segment_full_image( ...
        rawImg, ...
        vesselNetPersistent, ...
        lesionNetPersistent, ...
        lesionClassNames);

    %% ============================================================
    % 4. STRUCTURAL STATISTICS
    % ============================================================

    fprintf('\n============================================\n');
    fprintf('[4/5] STRUCTURAL ANALYSIS\n');
    fprintf('============================================\n');

    vesselPercentage = ...
        100 * sum(vesselMask(:)) / numel(vesselMask);

    fprintf('Vessel area: %.2f%%\n',vesselPercentage);

    lesionCounts = struct();

    for k = 1:numel(lesionClassNames)

        mask = lesionMask == k;

        fieldName = lesionClassNames{k};

        % Make MATLAB-safe field name
        fieldName = matlab.lang.makeValidName(fieldName);

        lesionCounts.(fieldName) = sum(mask(:));

        fprintf('%s pixels: %d\n', ...
            fieldName, ...
            sum(mask(:)));

    end

    %% ============================================================
    % 5. MULTIMODAL RISK ADJUSTMENT
    % ============================================================

    fprintf('\n============================================\n');
    fprintf('[5/5] RISK FUSION\n');
    fprintf('============================================\n');

    riskScoreAdjusted = double(drGrade);

    if ~isempty(hba1c) && hba1c > 9.0

        riskScoreAdjusted = riskScoreAdjusted + 0.3;

    end

    if ~isempty(diabetesYears) && diabetesYears > 10

        riskScoreAdjusted = riskScoreAdjusted + 0.2;

    end

    if ~isempty(systolicBP) && systolicBP > 140

        riskScoreAdjusted = riskScoreAdjusted + 0.2;

    end

    riskScoreAdjusted = min(4,riskScoreAdjusted);

    fprintf('Adjusted risk score: %.2f\n', ...
        riskScoreAdjusted);

    %% ============================================================
    % VISUALIZATION OUTPUT
    % ============================================================

    outputDir = '/MATLAB Drive/output/heatmaps';

    if ~exist(outputDir,'dir')

        mkdir(outputDir);

    end

    [~,imageName,~] = fileparts(imagePath);

    %% Structural visualization

    structuralImg = imresize(rawImg,[size(lesionMask,1) ...
                                      size(lesionMask,2)]);

    structuralOverlay = structuralImg;

    % Vessel overlay
    vesselRGB = cat(3, ...
        zeros(size(vesselMask)), ...
        uint8(255 * vesselMask), ...
        uint8(255 * vesselMask));

    structuralOverlay = uint8( ...
        0.80 * double(structuralOverlay) + ...
        0.20 * double(vesselRGB));

    % Lesion overlays
    lesionColors = [ ...
        255 0 0;       % class 1
        255 165 0;     % class 2
        255 0 255];    % class 3
    

    for k = 1:min(3,numel(lesionClassNames))

        mask = lesionMask == k;

        for c = 1:3

            channel = structuralOverlay(:,:,c);

            channel(mask) = lesionColors(k,c);

            structuralOverlay(:,:,c) = channel;

        end

    end

    structuralPath = fullfile( ...
        outputDir, ...
        [imageName '_structural.png']);

    imwrite(structuralOverlay,structuralPath);

    %% ============================================================
    % REFERRAL
    % ============================================================

    try

        referral = referral_logistics( ...
            round(riskScoreAdjusted), ...
            confidence, ...
            patientLat, ...
            patientLon);

    catch

        % Prototype fallback
        if riskScoreAdjusted >= 3

            urgency = 'HIGH';
            timeframe = 'Urgent ophthalmology review';

        elseif riskScoreAdjusted >= 2

            urgency = 'MODERATE';
            timeframe = 'Ophthalmology evaluation recommended';

        else

            urgency = 'LOW';
            timeframe = 'Routine monitoring';

        end

        referral = struct( ...
            'urgency',urgency, ...
            'timeframe',timeframe, ...
            'message',timeframe, ...
            'nearestCenter','', ...
            'distanceKm',0);

    end

    %% ============================================================
    % RESULT STRUCT
    % ============================================================

    result = struct();

    result.isGradeable = isGradeable;
    result.qualityScore = qualityScore;
    result.qualityMessage = qualityMessage;

    result.grade = drGrade;
    result.gradeLabel = gradeLabel;
    result.confidence = confidence;

    result.riskScoreAdjusted = riskScoreAdjusted;

    result.heatmapPath = '';

    result.structuralPath = structuralPath;

    result.vesselPercentage = vesselPercentage;

    result.lesionCounts = lesionCounts;

    result.referral = referral;

    fprintf('\n');
    fprintf('============================================\n');
    fprintf('       EYEABETICS PIPELINE COMPLETE\n');
    fprintf('============================================\n');

    fprintf('DR Grade     : %d\n',drGrade);
    fprintf('Confidence   : %.2f%%\n',confidence*100);
    fprintf('Vessel Area  : %.2f%%\n',vesselPercentage);
    fprintf('Risk Score   : %.2f\n',riskScoreAdjusted);
    fprintf('Structural   : %s\n',structuralPath);

    fprintf('============================================\n');

end