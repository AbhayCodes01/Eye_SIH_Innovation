// ============================================
// EYEABETICS - PROGRESSION ENGINE
// ============================================
// Compares the two most recent screenings
// for the same patient.
//
// This is a transparent prototype comparison
// engine, NOT a clinically validated predictor.
// ============================================

function calculateProgression(screenings) {
  if (!screenings || screenings.length < 2) {
    return {
      available: false,
      message: "At least two screenings are required for progression analysis.",
    };
  }

  // Screenings are expected newest first
  const current = screenings[0];
  const previous = screenings[1];

  const currentGrade = Number(current.drGrade);
  const previousGrade = Number(previous.drGrade);

  const currentRisk = Number(current.riskScore ?? currentGrade);
  const previousRisk = Number(previous.riskScore ?? previousGrade);

  const currentVessel =
    typeof current.vesselPercentage === "number"
      ? current.vesselPercentage
      : null;

  const previousVessel =
    typeof previous.vesselPercentage === "number"
      ? previous.vesselPercentage
      : null;

  const gradeChange = currentGrade - previousGrade;
  const riskChange = currentRisk - previousRisk;

  let vesselChange = null;

  if (currentVessel !== null && previousVessel !== null) {
    vesselChange = currentVessel - previousVessel;
  }

  // --------------------------------------------
  // TIME BETWEEN SCREENINGS
  // --------------------------------------------

  const currentDate = new Date(current.screenedAt);
  const previousDate = new Date(previous.screenedAt);

  const timeDifferenceMs =
    currentDate.getTime() - previousDate.getTime();

  const daysBetween =
    Math.abs(timeDifferenceMs) / (1000 * 60 * 60 * 24);

  // --------------------------------------------
  // DETERMINE PROGRESSION
  // --------------------------------------------

  let progressionStatus;
  let progressionLevel;
  let priority;
  let message;

  if (gradeChange >= 2) {
    progressionStatus = "SIGNIFICANT WORSENING";
    progressionLevel = "critical";
    priority = "CRITICAL";

    message =
      "DR grade increased by two or more levels between screenings. Specialist review should be prioritized.";
  } else if (gradeChange === 1) {
    progressionStatus = "WORSENING";
    progressionLevel = "high";
    priority = "HIGH";

    message =
      "DR grade increased by one level between screenings. Specialist review should be prioritized.";
  } else if (gradeChange === 0 && riskChange > 0) {
    progressionStatus = "RISK INCREASE";
    progressionLevel = "moderate";
    priority = "MODERATE";

    message =
      "DR grade is unchanged, but the overall risk score has increased.";
  } else if (gradeChange === 0 && riskChange === 0) {
    progressionStatus = "STABLE";
    progressionLevel = "low";
    priority = "ROUTINE";

    message =
      "No change in DR grade or risk score between the two latest screenings.";
  } else if (gradeChange < 0) {
    progressionStatus = "IMPROVING";
    progressionLevel = "low";
    priority = "ROUTINE";

    message =
      "DR grade decreased compared with the previous screening.";
  } else {
    progressionStatus = "NO SIGNIFICANT CHANGE";
    progressionLevel = "low";
    priority = "ROUTINE";

    message =
      "No significant worsening detected from the available screening data.";
  }

  // --------------------------------------------
  // STRUCTURAL SUPPORT
  // --------------------------------------------

  let structuralChange = null;

  if (vesselChange !== null) {
    structuralChange = {
      previous: Number(previousVessel.toFixed(2)),
      current: Number(currentVessel.toFixed(2)),
      change: Number(vesselChange.toFixed(2)),
      direction:
        vesselChange > 0
          ? "increased"
          : vesselChange < 0
            ? "decreased"
            : "unchanged",
    };
  }

  // --------------------------------------------
  // RETURN COMPLETE ANALYSIS
  // --------------------------------------------

  return {
    available: true,

    patientId: current.patientId,

    current: {
      screeningId: current._id,
      date: current.screenedAt,
      imageName: current.imageName,
      drGrade: currentGrade,
      drLabel: current.drLabel,
      riskScore: currentRisk,
      vesselPercentage:
        currentVessel !== null
          ? Number(currentVessel.toFixed(2))
          : null,
    },

    previous: {
      screeningId: previous._id,
      date: previous.screenedAt,
      imageName: previous.imageName,
      drGrade: previousGrade,
      drLabel: previous.drLabel,
      riskScore: previousRisk,
      vesselPercentage:
        previousVessel !== null
          ? Number(previousVessel.toFixed(2))
          : null,
    },

    changes: {
      drGrade: gradeChange,
      riskScore: riskChange,
      vesselPercentage:
        vesselChange !== null
          ? Number(vesselChange.toFixed(2))
          : null,
      daysBetween: Number(daysBetween.toFixed(2)),
    },

    structural: structuralChange,

    progression: {
      status: progressionStatus,
      level: progressionLevel,
      priority,
      message,
    },

    prototypeNote:
      "Progression is calculated from available longitudinal screening measurements. This prototype does not provide a clinically validated disease forecast.",
  };
}

export default calculateProgression;