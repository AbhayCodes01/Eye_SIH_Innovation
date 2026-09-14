function referral = referral_logistics(grade, confidence, patientLat, patientLon)
% REFERRAL_LOGISTICS Converts a DR grade + confidence into an actionable
% referral recommendation: urgency level, timeframe, and nearest
% available eye-care center. Directly addresses the "1 ophthalmologist
% per 100,000 rural population" access problem stated in the PS.
%
% Inputs:
%   grade      - predicted DR grade (0-4)
%   confidence - calibrated confidence (0-1)
%   patientLat, patientLon - patient/clinic GPS coordinates
%
% Output:
%   referral - struct with fields: urgency, timeframe, message,
%              nearestCenter, distanceKm

    % ---- Static demo database of eye-care centers ----
    % In production this would be a live, government-maintained registry.
    centers = struct( ...
        'name', {'District Hospital Eye Unit', 'Aravind Eye Hospital', ...
                  'Community Health Center Ophthalmology', 'Regional Referral Eye Center'}, ...
        'lat',  {26.1445, 11.0041, 25.5941, 22.5726}, ...
        'lon',  {91.7362, 76.9689, 85.1376, 88.3639} ...
    );

    % ---- Urgency logic ----
    if grade == 0
        urgency = 'Routine';
        timeframe = 'Re-screen in 12 months';
        message = 'No signs of DR detected. Continue routine annual screening.';
    elseif grade == 1
        urgency = 'Low';
        timeframe = 'Re-screen in 6 months';
        message = 'Mild DR detected. No immediate referral needed; monitor.';
    elseif grade == 2
        urgency = 'Moderate';
        timeframe = 'Refer within 4 weeks';
        message = 'Moderate DR (referable). Ophthalmologist evaluation recommended.';
    elseif grade == 3
        urgency = 'High';
        timeframe = 'Refer within 1 week';
        message = 'Severe DR detected. Prompt ophthalmologist referral required.';
    else % grade == 4
        urgency = 'Critical';
        timeframe = 'Refer within 48 hours';
        message = 'Proliferative DR detected - risk of vision loss. Urgent referral.';
    end

    % Low-confidence predictions get escalated to mandatory human review
    % regardless of predicted grade (uncertainty-aware abstain mechanism).
    if confidence < 0.60
        urgency = [urgency ' (LOW CONFIDENCE - Mandatory Human Review)'];
        message = [message ' Model confidence below threshold; ophthalmologist must verify before action.'];
    end

    % ---- Nearest center (haversine distance) ----
    R = 6371; % Earth radius km
    distances = zeros(1, numel(centers));
    for i = 1:numel(centers)
        dLat = deg2rad(centers(i).lat - patientLat);
        dLon = deg2rad(centers(i).lon - patientLon);
        a = sin(dLat/2)^2 + cos(deg2rad(patientLat)) * cos(deg2rad(centers(i).lat)) * sin(dLon/2)^2;
        c = 2 * atan2(sqrt(a), sqrt(1-a));
        distances(i) = R * c;
    end
    [minDist, idx] = min(distances);

    referral = struct( ...
        'urgency', urgency, ...
        'timeframe', timeframe, ...
        'message', message, ...
        'nearestCenter', centers(idx).name, ...
        'distanceKm', round(minDist, 1) ...
    );
end
