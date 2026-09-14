function [discCenter, discRadius, foveaCenter] = optic_disc_fovea_detect(img)
% OPTIC_DISC_FOVEA_DETECT Locates the optic disc and fovea using
% classical computer vision (Hough Circle Transform + brightness/darkness
% heuristics). No training data required — the optic disc is reliably
% the brightest, most circular region in any fundus image, and the
% fovea is the darkest point roughly 2-3 disc-diameters temporal to it.
%
% Input:
%   img - preprocessed RGB fundus image
%
% Outputs:
%   discCenter  - [x y] pixel coordinates of optic disc center
%   discRadius  - estimated optic disc radius in pixels
%   foveaCenter - [x y] pixel coordinates of fovea

    % ---- Optic disc: brightest channel is typically green/red mix ----
    grayForDisc = 0.5*double(img(:,:,1)) + 0.5*double(img(:,:,2));
    grayForDisc = uint8(rescale(grayForDisc) * 255);

    % Suppress vessels (thin dark structures) so they don't interfere
    % with circle detection - morphological closing fills them in.
    se = strel('disk', 8);
    closed = imclose(grayForDisc, se);

    % Radius range: optic disc is typically ~8% of image width
    imgWidth = size(img, 2);
    minR = round(imgWidth * 0.05);
    maxR = round(imgWidth * 0.12);

    [centers, radii, metric] = imfindcircles(closed, [minR maxR], ...
        'ObjectPolarity', 'bright', 'Sensitivity', 0.92, 'EdgeThreshold', 0.1);

    if isempty(centers)
        % Fallback: brightest region centroid if Hough transform finds nothing
        bw = closed > prctile(double(closed(:)), 97);
        stats = regionprops(bw, 'Centroid', 'EquivDiameter');
        if ~isempty(stats)
            areas = [stats.EquivDiameter];
            [~, idx] = max(areas);
            discCenter = stats(idx).Centroid;
            discRadius = stats(idx).EquivDiameter / 2;
        else
            discCenter = [size(img,2)/2, size(img,1)/2];
            discRadius = maxR;
        end
    else
        % Take the strongest circle match
        [~, bestIdx] = max(metric);
        discCenter = centers(bestIdx, :);
        discRadius = radii(bestIdx);
    end

    % ---- Fovea: darkest point within a search window temporal to the
    % ---- optic disc (2-3 disc-diameters away, roughly same vertical level) ----
    gray = rgb2gray(img);
    searchDist = discRadius * 2.5;

    % Determine temporal direction: fovea is on the side AWAY from the
    % image edge the optic disc is closer to (rough heuristic; in a
    % properly centered fundus photo this is usually toward image center)
    if discCenter(1) > size(img,2)/2
        searchX = discCenter(1) - searchDist; % disc on right -> fovea to the left
    else
        searchX = discCenter(1) + searchDist; % disc on left -> fovea to the right
    end
    searchY = discCenter(2);

    winHalf = round(discRadius * 1.5);
    x1 = max(1, round(searchX - winHalf));
    x2 = min(size(img,2), round(searchX + winHalf));
    y1 = max(1, round(searchY - winHalf));
    y2 = min(size(img,1), round(searchY + winHalf));

    searchWindow = gray(y1:y2, x1:x2);
    smoothed = imgaussfilt(searchWindow, 5); % fovea is a smooth dark dip, not noise
    [~, minIdx] = min(smoothed(:));
    [minY, minX] = ind2sub(size(smoothed), minIdx);

    foveaCenter = [x1 + minX - 1, y1 + minY - 1];
end
