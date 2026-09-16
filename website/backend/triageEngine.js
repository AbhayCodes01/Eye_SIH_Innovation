function calculateTriage(screening, progression = null) {
  const grade = Number(screening?.drGrade ?? 0);
  const risk = Number(screening?.riskScore ?? grade);
  const quality = Number(
    screening?.imageQuality?.qualityScore ?? 0
  );
  const gradeable = screening?.imageQuality?.isGradeable !== false;

  // Operational triage score for prototype queue prioritization.
  // This is NOT a clinical risk prediction or validated medical score.

  let score =
    (Math.max(0, Math.min(4, grade)) / 4) * 60;

  score +=
    (Math.max(0, Math.min(4, risk)) / 4) * 15;

  if (progression?.available) {
    if (progression.progression?.priority === "CRITICAL") {
      score += 20;
    } else if (progression.progression?.priority === "HIGH") {
      score += 12;
    } else if (progression.progression?.priority === "MODERATE") {
      score += 6;
    }
  }

  // Poor-quality images should trigger reacquisition rather
  // than simply being pushed down the clinical queue.
  if (!gradeable) {
    return {
      score: 100,
      priority: "IMAGE RECHECK",
      level: "recheck",
      action:
        "Repeat image acquisition before clinical review.",
      reason:
        "The current image did not pass gradeability checks.",
      queueEligible: false,
      prototypeNote:
        "Operational triage logic for this prototype; not a clinically validated medical score.",
    };
  }

  score = Math.max(
    0,
    Math.min(100, Number(score.toFixed(1)))
  );

  let priority;
  let level;
  let action;
  let reason;

  if (grade >= 4 || score >= 80) {
    priority = "CRITICAL";
    level = "critical";

    action =
      "Prioritize for ophthalmologist review.";

    reason =
      "High-severity DR and/or other high-priority screening signals are present.";

  } else if (grade >= 3 || score >= 60) {
    priority = "HIGH";
    level = "high";

    action =
      "Review before routine screening cases.";

    reason =
      "The screening indicates a higher-priority case for limited specialist capacity.";

  } else if (grade >= 2 || score >= 40) {
    priority = "MODERATE";
    level = "moderate";

    action =
      "Place in the ophthalmology review queue.";

    reason =
      "The screening indicates a case requiring specialist evaluation.";

  } else {
    priority = "ROUTINE";
    level = "low";

    action =
      "Routine follow-up / monitoring.";

    reason =
      "No high-priority signal was identified by the prototype triage rules.";
  }

  return {
    score,
    priority,
    level,
    action,
    reason,
    queueEligible: true,
    prototypeNote:
      "Operational triage logic for this prototype; not a clinically validated medical score.",
  };
}

export default calculateTriage;