function outImg = preprocess_image(img, targetSize)
% PREPROCESS_IMAGE Enhances a fundus image for gradeability and prepares
% it for network input.
% Steps: crop to retina circle -> denoise -> CLAHE on L-channel (Lab
% space, avoids color distortion) -> resize -> normalize.
%
% Inputs:
%   img        - raw RGB fundus image (uint8)
%   targetSize - [H W] expected by the network, e.g. [224 224]
%
% Output:
%   outImg - preprocessed RGB image, uint8, size targetSize x 3

    if nargin < 2
        targetSize = [224 224];
    end

    % ---- 1. Crop to bounding box of the retina (remove black border) ----
    gray = rgb2gray(img);
    mask = gray > 15;
    stats = regionprops(mask, 'BoundingBox');
    if ~isempty(stats)
        % pick largest connected region (the retina disc)
        areas = arrayfun(@(s) s.BoundingBox(3)*s.BoundingBox(4), stats);
        [~, idx] = max(areas);
        bbox = round(stats(idx).BoundingBox);
        img = imcrop(img, bbox);
    end

    % ---- 2. Mild denoising (preserve vessel edges) ----
    img = imgaussfilt(img, 0.6);

    % ---- 3. CLAHE on luminance channel only (Lab color space) ----
    labImg = rgb2lab(img);
    L = labImg(:,:,1) / 100;               % normalize to [0,1] for adapthisteq
    L_eq = adapthisteq(L, 'ClipLimit', 0.01, 'NumTiles', [8 8]);
    labImg(:,:,1) = L_eq * 100;
    img = lab2rgb(labImg);
    img = im2uint8(rescale(img));

    % ---- 4. Resize to network input size ----
    outImg = imresize(img, targetSize);
end
