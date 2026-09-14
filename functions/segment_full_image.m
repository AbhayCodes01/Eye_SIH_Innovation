function [vesselMask, lesionMask, lesionClassNames] = segment_full_image(img, vesselNet, lesionNet, lesionClassNames_in)
% EYEABETICS - Combined Vessel + 4-Class Lesion Segmentation

originalSize = size(img);
H = originalSize(1);
W = originalSize(2);

%% VESSEL SEGMENTATION

fprintf('\n--- VESSEL SEGMENTATION ---\n');

vesselInput = imresize(img,[256 256]);
vesselInput = im2single(vesselInput);

fprintf('Vessel input: %s\n',mat2str(size(vesselInput)));

% Imported vessel dlnetwork expects H x W x C
vesselOutput = predict(vesselNet,vesselInput);

if isa(vesselOutput,'dlarray')
    vesselOutput = extractdata(vesselOutput);
end

fprintf('Vessel output: %s\n',mat2str(size(vesselOutput)));

vesselProb = squeeze(vesselOutput);
vesselProb = reshape(vesselProb,[256 256]);

vesselMaskSmall = vesselProb > 0.5;
vesselMask = imresize(vesselMaskSmall,[H W],'nearest');
vesselMask = logical(vesselMask);

vesselPercentage = 100*sum(vesselMask(:))/numel(vesselMask);

fprintf('Vessel probability: %.4f -> %.4f\n',min(vesselProb(:)),max(vesselProb(:)));
fprintf('Vessel percentage: %.2f%%\n',vesselPercentage);

%% LESION SEGMENTATION

fprintf('\n--- LESION SEGMENTATION ---\n');

lesionInput = imresize(img,[512 512]);
lesionInput = im2single(lesionInput);

fprintf('Lesion input: %s\n',mat2str(size(lesionInput)));

% Imported lesion dlnetwork expects H x W x C
lesionOutput = predict(lesionNet,lesionInput);

if isa(lesionOutput,'dlarray')
    lesionOutput = extractdata(lesionOutput);
end

fprintf('Lesion output: %s\n',mat2str(size(lesionOutput)));

%% SOFTMAX

mx = max(lesionOutput,[],3);
expOutput = exp(lesionOutput-mx);
prob = expOutput ./ sum(expOutput,3);

[lesionConfidence,lesionMaskSmall] = max(prob,[],3);

lesionMaskSmall = uint8(lesionMaskSmall);
lesionMask = imresize(lesionMaskSmall,[H W],'nearest');

fprintf('Lesion classes detected: ');
disp(unique(lesionMaskSmall(:))');

fprintf('Maximum lesion confidence: %.4f\n',max(lesionConfidence(:)));
fprintf('Mean lesion confidence: %.4f\n',mean(lesionConfidence(:)));

%% CLASS NAMES

if nargin >= 4 && ~isempty(lesionClassNames_in)
    lesionClassNames = lesionClassNames_in;
else
    lesionClassNames = {'background','class2','class3','class4'};
end

fprintf('\nCombined segmentation complete.\n');

end
