// ============================================
// EYEABETICS AI EVIDENCE ENGINE
// ============================================
// Descriptive evidence summary for the screening UI.
// This does NOT claim to explain the internal neural-network decision.

function numberOrNull(value) {
  const n = Number(value)
  return Number.isFinite(n) ? n : null
}

function buildEvidenceSummary(result = {}) {
  const grade = numberOrNull(result.drGrade ?? result.grade)
  const risk = numberOrNull(result.riskScoreAdjusted ?? result.riskScore)
  const vessel = numberOrNull(result.vesselPercentage)
  const quality = numberOrNull(result.qualityScore)
  const gradeable = result.isGradeable !== false

  const lesionCounts =
    result.lesionCounts && typeof result.lesionCounts === 'object'
      ? result.lesionCounts
      : {}

  const lesionEntries = Object.entries(lesionCounts)
    .filter(([key, value]) => {
      const k = String(key).toLowerCase()

      return (
        k !== 'background' &&
        k !== 'class1' &&
        numberOrNull(value) !== null
      )
    })
    .map(([key, value]) => ({
      className: String(key),
      pixels: Number(value),
    }))
    .sort((a, b) => b.pixels - a.pixels)

  const findings = []

  // ============================================
  // DR CLASSIFICATION
  // ============================================

  if (grade !== null) {
    findings.push({
      type: 'classification',
      title: 'DR severity classification',
      value: grade >= 0 ? `Grade ${grade}` : 'Unavailable',
      detail:
        result.drLabel ||
        result.gradeLabel ||
        'Derived from the DR classifier output.',
    })
  }

  // ============================================
  // LESION SEGMENTATION
  // ============================================

  if (lesionEntries.length > 0) {
    findings.push({
      type: 'lesion',
      title: 'Lesion segmentation',
      value: `${lesionEntries.length} lesion class${
        lesionEntries.length === 1 ? '' : 'es'
      } detected`,
      detail:
        'Pixel-level abnormal-region classes were detected by the lesion segmentation model.',
      classes: lesionEntries,
    })
  } else {
    findings.push({
      type: 'lesion',
      title: 'Lesion segmentation',
      value: 'No non-background classes detected',
      detail:
        'No lesion class was returned by the segmentation output.',
      classes: [],
    })
  }

  // ============================================
  // VASCULAR STRUCTURE
  // ============================================

  if (vessel !== null) {
    findings.push({
      type: 'vascular',
      title: 'Vascular structure',
      value: `${vessel.toFixed(2)}% vessel area`,
      detail:
        'Percentage of analyzed pixels classified as retinal vessels.',
    })
  }

  // ============================================
  // IMAGE QUALITY
  // ============================================

  if (quality !== null) {
    findings.push({
      type: 'quality',
      title: 'Image quality',
      value: `${quality.toFixed(0)}/100`,
      detail: gradeable
        ? 'Image passed the prototype gradeability check.'
        : 'Image quality may limit reliable interpretation.',
    })
  }

  // ============================================
  // RISK / REFERRAL
  // ============================================

  if (risk !== null) {
    findings.push({
      type: 'risk',
      title: 'Risk / referral context',
      value: `Risk ${risk.toFixed(2)}`,
      detail:
        result.referral?.timeframe ||
        result.referral?.message ||
        'Prototype risk-fusion output.',
    })
  }

  // ============================================
  // ESCALATION SUMMARY
  // ============================================

  let escalation = 'Routine screening pathway.'

  if (grade !== null) {
    if (grade >= 3) {
      escalation =
        'The screening is in a high-severity grade and the prototype referral policy flags it for urgent ophthalmology review.'
    } else if (grade === 2) {
      escalation =
        'The screening is in a moderate-severity grade and the prototype referral policy flags it for ophthalmic evaluation.'
    } else if (grade === 1) {
      escalation =
        'The screening is in a mild-severity grade and the prototype referral policy places it in routine monitoring.'
    }
  }

  // ============================================
  // FINAL EVIDENCE OBJECT
  // ============================================

  return {
    title: 'AI Evidence Summary',

    disclaimer:
      'Descriptive evidence from the prototype pipeline; not a causal explanation of the neural-network decision.',

    escalation,

    findings,
  }
}

export default buildEvidenceSummary