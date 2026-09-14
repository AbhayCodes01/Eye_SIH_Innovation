function [isGradeable, qualityScore, reason] = quality_assessment(img)
% QUALITY_ASSESSMENT Evaluates a fundus image for gradeability.
% Checks focus (sharpness), illumination (brightness/contrast), and
% field-of-view coverage. Used both for the live traffic-light capture
% guidance and as a gate before the image reaches the DR classifier.
%
% Inputs:
%   img - RGB fundus image (uint8, HxWx3)
%
% Outputs:
%   isGradeable  - logical, true if image passes all checks
%   qualityScore - 0-100 composite score (for the traffic-light UI)
%   reason       - string explaining rejection, empty if gradeable

    if size(img, 3) ~= 3
        img = repmat(img, [1 1 3]);
    end

    gray = rgb2gray(img);

    % ---- 1. Focus / sharpness check (Laplacian variance) ----
    lap = fspecial('laplacian', 0.2);
    filtered = imfilter(double(gray), lap, 'replicate');
    sharpness = var(filtered(:));
    sharpnessScore = min(100, (sharpness / 150) * 100); % empirical scaling

    % ---- 2. Illumination check (mean brightness + std contrast) ----
    meanBrightness = mean(gray(:));
    stdContrast = std(double(gray(:)));

    % Ideal fundus brightness range ~ 60-190 (out of 255)
    if meanBrightness < 40 || meanBrightness > 220
        brightnessScore = 20;
    else
        brightnessScore = 100 - abs(meanBrightness - 130) / 130 * 60;
    end
    contrastScore = min(100, (stdContrast / 45) * 100);

    % ---- 3. Field-of-view check (fraction of frame that is retina, ----
    % ---- not black border/vignetting) ----
    mask = gray > 15; % non-black pixels
    fovFraction = sum(mask(:)) / numel(mask);
    fovScore = min(100, fovFraction / 0.55 * 100); % expect >=55% coverage

    % ---- Composite score ----
    qualityScore = round(0.35*sharpnessScore + 0.25*brightnessScore + ...
                          0.20*contrastScore + 0.20*fovScore);
    qualityScore = max(0, min(100, qualityScore));

    isGradeable = qualityScore >= 55; % threshold tuned for portable cams
    reason = '';
    if ~isGradeable
        if sharpnessScore < 40
            reason = 'Image too blurry - hold camera steady and refocus.';
        elseif brightnessScore < 40
            reason = 'Poor illumination - adjust lighting or flash.';
        elseif fovScore < 40
            reason = 'Retina not fully in frame - recenter the eye.';
        else
            reason = 'Overall image quality too low - please recapture.';
        end
    end
end
