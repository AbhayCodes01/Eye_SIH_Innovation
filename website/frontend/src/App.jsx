
import { useEffect, useMemo, useState } from "react";
import "./App.css";
const API = "http://localhost:5000";


// ============================================================
// TRANSLATIONS
// ============================================================

const translations = {

  English: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-Assisted Diabetic Retinopathy Screening",

    patientInformation: "Patient Information",
    patientId: "Patient ID",
    patientName: "Patient Name",
    age: "Age",
    gender: "Gender",
    phone: "Phone",
    village: "Village",
    district: "District",

    createPatient: "Create Patient",
    patientCreated: "Patient created successfully",

    uploadTitle: "Upload Fundus Image",
    uploadDescription:
      "Upload a retinal fundus image for AI-assisted screening.",
    chooseImage: "Choose Fundus Image",
    analyzeImage: "Analyze Image",
    analyzing: "Analyzing...",
    selectedImage: "Selected Image",

    clinicalSummary: "5-Second Clinical Summary",
    drGrade: "DR Grade",
    severity: "Severity",
    imageQuality: "Image Quality",
    vesselArea: "Vessel Area",
    riskScore: "Risk Score",
    referral: "Referral",

    noDr: "No Diabetic Retinopathy",
    mild: "Mild",
    moderate: "Moderate",
    severe: "Severe",
    proliferative: "Proliferative",

    routine: "Routine",
    urgent: "Urgent",
    review: "Clinical Review",

    patientPassport: "Retina Passport",
    screeningHistory: "Screening History",
    screenings: "Screenings",
    currentScreening: "Current Screening",
    previousScreening: "Previous Screening",
    noHistory: "No previous screening available.",

    triageQueue: "Doctor Review Queue",
    triageDescription:
      "AI-assisted prioritization of screening cases for clinical review.",
    viewCase: "View Case",
    noTriageCases: "No cases currently in the review queue.",

    visualEvidence: "Visual Evidence",
    originalFundus: "Original Fundus",
    structuralOverlay: "Structural Analysis",

    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "Descriptive evidence from the prototype pipeline; not a causal explanation of the neural-network decision.",

    lesionSegmentation: "Lesion Segmentation",
    vascularStructure: "Vascular Structure",
    classification: "DR Severity Classification",

    progression: "Retinal Progression",
    progressionDescription:
      "Comparison of the patient's current and previous screening records.",
    previousGrade: "Previous Grade",
    currentGrade: "Current Grade",
    gradeChange: "Grade Change",
    progressionStatus: "Progression Status",
    progressionPriority: "Priority",

    furtherDetails: "Further Clinical Details",
    technicalDetails: "Technical Details",

    disclaimerTitle: "Medical Disclaimer",
    disclaimer:
      "Eyeabetics is an AI-assisted research prototype and is not a replacement for professional medical diagnosis. All screening results require appropriate clinical review.",

    routineMonitoring:
      "Routine ophthalmic monitoring recommended.",
    moderateReferral:
      "Ophthalmic evaluation recommended.",
    urgentReferral:
      "Urgent ophthalmology review recommended.",

    uploadRequired: "Please select a fundus image first.",
    patientRequired:
      "Please enter or create a Patient ID before analysis.",
  },

  Hindi: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-सहायित डायबिटिक रेटिनोपैथी स्क्रीनिंग",

    patientInformation: "रोगी की जानकारी",
    patientId: "रोगी ID",
    patientName: "रोगी का नाम",
    age: "आयु",
    gender: "लिंग",
    phone: "फोन",
    village: "गाँव",
    district: "जिला",

    createPatient: "रोगी बनाएँ",
    patientCreated: "रोगी सफलतापूर्वक बनाया गया",

    uploadTitle: "फंडस इमेज अपलोड करें",
    uploadDescription:
      "AI-सहायित स्क्रीनिंग के लिए रेटिनल फंडस इमेज अपलोड करें।",
    chooseImage: "फंडस इमेज चुनें",
    analyzeImage: "इमेज का विश्लेषण करें",
    analyzing: "विश्लेषण हो रहा है...",
    selectedImage: "चयनित इमेज",

    clinicalSummary: "5-सेकंड क्लिनिकल सारांश",
    drGrade: "DR ग्रेड",
    severity: "गंभीरता",
    imageQuality: "इमेज गुणवत्ता",
    vesselArea: "रक्त वाहिका क्षेत्र",
    riskScore: "जोखिम स्कोर",
    referral: "रेफरल",

    noDr: "डायबिटिक रेटिनोपैथी नहीं",
    mild: "हल्का",
    moderate: "मध्यम",
    severe: "गंभीर",
    proliferative: "प्रोलिफेरेटिव",

    routine: "रूटीन",
    urgent: "तत्काल",
    review: "क्लिनिकल समीक्षा",

    patientPassport: "रेटिना पासपोर्ट",
    screeningHistory: "स्क्रीनिंग इतिहास",
    screenings: "स्क्रीनिंग",
    currentScreening: "वर्तमान स्क्रीनिंग",
    previousScreening: "पिछली स्क्रीनिंग",
    noHistory: "कोई पिछली स्क्रीनिंग उपलब्ध नहीं है।",

    triageQueue: "डॉक्टर समीक्षा कतार",
    triageDescription:
      "क्लिनिकल समीक्षा के लिए स्क्रीनिंग मामलों की AI-सहायित प्राथमिकता।",
    viewCase: "केस देखें",
    noTriageCases: "वर्तमान में समीक्षा कतार में कोई केस नहीं है।",

    visualEvidence: "दृश्य प्रमाण",
    originalFundus: "मूल फंडस",
    structuralOverlay: "संरचनात्मक विश्लेषण",

    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "यह प्रोटोटाइप पाइपलाइन से प्राप्त वर्णनात्मक प्रमाण है; यह न्यूरल नेटवर्क के निर्णय की कारणात्मक व्याख्या नहीं है।",

    lesionSegmentation: "लेजन सेगमेंटेशन",
    vascularStructure: "रक्त वाहिका संरचना",
    classification: "DR गंभीरता वर्गीकरण",

    progression: "रेटिनल प्रगति",
    progressionDescription:
      "रोगी के वर्तमान और पिछले स्क्रीनिंग रिकॉर्ड की तुलना।",
    previousGrade: "पिछला ग्रेड",
    currentGrade: "वर्तमान ग्रेड",
    gradeChange: "ग्रेड परिवर्तन",
    progressionStatus: "प्रगति स्थिति",
    progressionPriority: "प्राथमिकता",

    furtherDetails: "अतिरिक्त क्लिनिकल विवरण",
    technicalDetails: "तकनीकी विवरण",

    disclaimerTitle: "चिकित्सीय अस्वीकरण",
    disclaimer:
      "Eyeabetics एक AI-सहायित रिसर्च प्रोटोटाइप है और पेशेवर चिकित्सा निदान का विकल्प नहीं है।",

    routineMonitoring:
      "नियमित नेत्र जांच की सिफारिश की जाती है।",
    moderateReferral:
      "नेत्र विशेषज्ञ द्वारा मूल्यांकन की सिफारिश की जाती है।",
    urgentReferral:
      "तत्काल नेत्र विशेषज्ञ समीक्षा की सिफारिश की जाती है।",

    uploadRequired: "कृपया पहले फंडस इमेज चुनें।",
    patientRequired:
      "कृपया विश्लेषण से पहले Patient ID दर्ज करें या रोगी बनाएँ।",
  },

  Odia: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-ସହାୟିତ ଡାଏବେଟିକ୍ ରେଟିନୋପାଥି ସ୍କ୍ରିନିଂ",
    patientInformation: "ରୋଗୀ ସୂଚନା",
    patientId: "ରୋଗୀ ID",
    patientName: "ରୋଗୀଙ୍କ ନାମ",
    age: "ବୟସ",
    gender: "ଲିଙ୍ଗ",
    phone: "ଫୋନ୍",
    village: "ଗାଁ",
    district: "ଜିଲ୍ଲା",
    createPatient: "ରୋଗୀ ସୃଷ୍ଟି କରନ୍ତୁ",
    patientCreated: "ରୋଗୀ ସଫଳତାର ସହ ସୃଷ୍ଟି ହୋଇଛି",
    uploadTitle: "ଫଣ୍ଡସ୍ ଇମେଜ୍ ଅପଲୋଡ୍ କରନ୍ତୁ",
    uploadDescription:
      "AI-ସହାୟିତ ସ୍କ୍ରିନିଂ ପାଇଁ ରେଟିନାଲ୍ ଫଣ୍ଡସ୍ ଇମେଜ୍ ଅପଲୋଡ୍ କରନ୍ତୁ।",
    chooseImage: "ଫଣ୍ଡସ୍ ଇମେଜ୍ ବାଛନ୍ତୁ",
    analyzeImage: "ଇମେଜ୍ ବିଶ୍ଳେଷଣ କରନ୍ତୁ",
    analyzing: "ବିଶ୍ଳେଷଣ ଚାଲିଛି...",
    selectedImage: "ବଛାଯାଇଥିବା ଇମେଜ୍",
    clinicalSummary: "5-ସେକେଣ୍ଡ୍ କ୍ଲିନିକାଲ୍ ସାରାଂଶ",
    drGrade: "DR ଗ୍ରେଡ୍",
    severity: "ଗମ୍ଭୀରତା",
    imageQuality: "ଇମେଜ୍ ଗୁଣବତ୍ତା",
    vesselArea: "ରକ୍ତନଳୀ କ୍ଷେତ୍ର",
    riskScore: "ଜୋଖିମ ସ୍କୋର୍",
    referral: "ରେଫରାଲ୍",
    noDr: "ଡାଏବେଟିକ୍ ରେଟିନୋପାଥି ନାହିଁ",
    mild: "ହାଲୁକା",
    moderate: "ମଧ୍ୟମ",
    severe: "ଗମ୍ଭୀର",
    proliferative: "ପ୍ରୋଲିଫେରେଟିଭ୍",
    routine: "ରୁଟିନ୍",
    urgent: "ତୁରନ୍ତ",
    review: "କ୍ଲିନିକାଲ୍ ସମୀକ୍ଷା",
    patientPassport: "ରେଟିନା ପାସପୋର୍ଟ",
    screeningHistory: "ସ୍କ୍ରିନିଂ ଇତିହାସ",
    screenings: "ସ୍କ୍ରିନିଂ",
    currentScreening: "ବର୍ତ୍ତମାନ ସ୍କ୍ରିନିଂ",
    previousScreening: "ପୂର୍ବ ସ୍କ୍ରିନିଂ",
    noHistory: "କୌଣସି ପୂର୍ବ ସ୍କ୍ରିନିଂ ଉପଲବ୍ଧ ନାହିଁ।",
    triageQueue: "ଡାକ୍ତର ସମୀକ୍ଷା କ୍ୟୁ",
    triageDescription:
      "କ୍ଲିନିକାଲ୍ ସମୀକ୍ଷା ପାଇଁ AI-ସହାୟିତ ସ୍କ୍ରିନିଂ ପ୍ରାଥମିକତା।",
    viewCase: "କେସ୍ ଦେଖନ୍ତୁ",
    noTriageCases: "ବର୍ତ୍ତମାନ ସମୀକ୍ଷା କ୍ୟୁରେ କୌଣସି କେସ୍ ନାହିଁ।",
    visualEvidence: "ଦୃଶ୍ୟ ପ୍ରମାଣ",
    originalFundus: "ମୂଳ ଫଣ୍ଡସ୍",
    structuralOverlay: "ସଂରଚନାତ୍ମକ ବିଶ୍ଳେଷଣ",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "ଏହା ପ୍ରୋଟୋଟାଇପ୍ ପାଇପଲାଇନ୍‌ରୁ ପ୍ରାପ୍ତ ବର୍ଣ୍ଣନାତ୍ମକ ପ୍ରମାଣ; ଏହା ନ୍ୟୁରାଲ୍ ନେଟୱର୍କ ନିଷ୍ପତ୍ତିର କାରଣାତ୍ମକ ବ୍ୟାଖ୍ୟା ନୁହେଁ।",
    lesionSegmentation: "ଲେଜନ୍ ସେଗମେଣ୍ଟେସନ୍",
    vascularStructure: "ରକ୍ତନଳୀ ସଂରଚନା",
    classification: "DR ଗମ୍ଭୀରତା ବର୍ଗୀକରଣ",
    progression: "ରେଟିନାଲ୍ ପ୍ରଗତି",
    progressionDescription:
      "ରୋଗୀଙ୍କ ବର୍ତ୍ତମାନ ଏବଂ ପୂର୍ବ ସ୍କ୍ରିନିଂ ରେକର୍ଡର ତୁଳନା।",
    previousGrade: "ପୂର୍ବ ଗ୍ରେଡ୍",
    currentGrade: "ବର୍ତ୍ତମାନ ଗ୍ରେଡ୍",
    gradeChange: "ଗ୍ରେଡ୍ ପରିବର୍ତ୍ତନ",
    progressionStatus: "ପ୍ରଗତି ସ୍ଥିତି",
    progressionPriority: "ପ୍ରାଥମିକତା",
    furtherDetails: "ଅଧିକ କ୍ଲିନିକାଲ୍ ବିବରଣୀ",
    technicalDetails: "ଟେକ୍ନିକାଲ୍ ବିବରଣୀ",
    disclaimerTitle: "ଚିକିତ୍ସା ଅସ୍ୱୀକାରୋକ୍ତି",
    disclaimer:
      "Eyeabetics ଏକ AI-ସହାୟିତ ଗବେଷଣା ପ୍ରୋଟୋଟାଇପ୍ ଏବଂ ପେଶାଦାର ଚିକିତ୍ସା ନିଦାନର ବିକଳ୍ପ ନୁହେଁ।",
    routineMonitoring:
      "ନିୟମିତ ଚକ୍ଷୁ ପରୀକ୍ଷାର ସୁପାରିଶ।",
    moderateReferral:
      "ଚକ୍ଷୁ ବିଶେଷଜ୍ଞଙ୍କ ମୂଲ୍ୟାୟନର ସୁପାରିଶ।",
    urgentReferral:
      "ତୁରନ୍ତ ଚକ୍ଷୁ ବିଶେଷଜ୍ଞ ସମୀକ୍ଷାର ସୁପାରିଶ।",
    uploadRequired: "ଦୟାକରି ପ୍ରଥମେ ଏକ ଫଣ୍ଡସ୍ ଇମେଜ୍ ବାଛନ୍ତୁ।",
    patientRequired:
      "ବିଶ୍ଳେଷଣ ପୂର୍ବରୁ Patient ID ଦିଅନ୍ତୁ କିମ୍ବା ରୋଗୀ ସୃଷ୍ଟି କରନ୍ତୁ।",
  },

  Bengali: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-সহায়িত ডায়াবেটিক রেটিনোপ্যাথি স্ক্রিনিং",
    patientInformation: "রোগীর তথ্য",
    patientId: "রোগী ID",
    patientName: "রোগীর নাম",
    age: "বয়স",
    gender: "লিঙ্গ",
    phone: "ফোন",
    village: "গ্রাম",
    district: "জেলা",
    createPatient: "রোগী তৈরি করুন",
    patientCreated: "রোগী সফলভাবে তৈরি হয়েছে",
    uploadTitle: "ফান্ডাস ইমেজ আপলোড করুন",
    uploadDescription:
      "AI-সহায়িত স্ক্রিনিংয়ের জন্য রেটিনাল ফান্ডাস ইমেজ আপলোড করুন।",
    chooseImage: "ফান্ডাস ইমেজ বাছুন",
    analyzeImage: "ইমেজ বিশ্লেষণ করুন",
    analyzing: "বিশ্লেষণ হচ্ছে...",
    selectedImage: "নির্বাচিত ইমেজ",
    clinicalSummary: "৫-সেকেন্ড ক্লিনিক্যাল সারাংশ",
    drGrade: "DR গ্রেড",
    severity: "তীব্রতা",
    imageQuality: "ইমেজের গুণমান",
    vesselArea: "রক্তনালীর ক্ষেত্র",
    riskScore: "ঝুঁকি স্কোর",
    referral: "রেফারাল",
    noDr: "ডায়াবেটিক রেটিনোপ্যাথি নেই",
    mild: "মৃদু",
    moderate: "মাঝারি",
    severe: "গুরুতর",
    proliferative: "প্রোলিফেরেটিভ",
    routine: "রুটিন",
    urgent: "জরুরি",
    review: "ক্লিনিক্যাল রিভিউ",
    patientPassport: "রেটিনা পাসপোর্ট",
    screeningHistory: "স্ক্রিনিং ইতিহাস",
    screenings: "স্ক্রিনিং",
    currentScreening: "বর্তমান স্ক্রিনিং",
    previousScreening: "পূর্ববর্তী স্ক্রিনিং",
    noHistory: "কোনও পূর্ববর্তী স্ক্রিনিং নেই।",
    triageQueue: "ডাক্তার রিভিউ কিউ",
    triageDescription:
      "ক্লিনিক্যাল রিভিউয়ের জন্য AI-সহায়িত স্ক্রিনিং অগ্রাধিকার।",
    viewCase: "কেস দেখুন",
    noTriageCases: "বর্তমানে রিভিউ কিউতে কোনও কেস নেই।",
    visualEvidence: "দৃশ্যমান প্রমাণ",
    originalFundus: "মূল ফান্ডাস",
    structuralOverlay: "স্ট্রাকচারাল অ্যানালাইসিস",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "এটি প্রোটোটাইপ পাইপলাইন থেকে পাওয়া বর্ণনামূলক প্রমাণ; এটি নিউরাল নেটওয়ার্কের সিদ্ধান্তের কারণগত ব্যাখ্যা নয়।",
    lesionSegmentation: "লেশন সেগমেন্টেশন",
    vascularStructure: "রক্তনালীর গঠন",
    classification: "DR তীব্রতা শ্রেণীবিভাগ",
    progression: "রেটিনাল প্রগ্রেশন",
    progressionDescription:
      "রোগীর বর্তমান এবং পূর্ববর্তী স্ক্রিনিং রেকর্ডের তুলনা।",
    previousGrade: "পূর্ববর্তী গ্রেড",
    currentGrade: "বর্তমান গ্রেড",
    gradeChange: "গ্রেড পরিবর্তন",
    progressionStatus: "প্রগ্রেশন স্ট্যাটাস",
    progressionPriority: "অগ্রাধিকার",
    furtherDetails: "অতিরিক্ত ক্লিনিক্যাল বিবরণ",
    technicalDetails: "টেকনিক্যাল বিবরণ",
    disclaimerTitle: "মেডিকেল ডিসক্লেমার",
    disclaimer:
      "Eyeabetics একটি AI-সহায়িত গবেষণা প্রোটোটাইপ এবং পেশাদার চিকিৎসা নির্ণয়ের বিকল্প নয়।",
    routineMonitoring:
      "নিয়মিত চক্ষু পর্যবেক্ষণের পরামর্শ দেওয়া হয়।",
    moderateReferral:
      "চক্ষু বিশেষজ্ঞের মূল্যায়নের পরামর্শ দেওয়া হয়।",
    urgentReferral:
      "জরুরি চক্ষু বিশেষজ্ঞ পর্যালোচনার পরামর্শ দেওয়া হয়।",
    uploadRequired: "দয়া করে প্রথমে একটি ফান্ডাস ইমেজ বাছুন।",
    patientRequired:
      "বিশ্লেষণের আগে Patient ID দিন অথবা রোগী তৈরি করুন।",
  },

  Kannada: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-ಸಹಾಯಿತ ಡಯಾಬಿಟಿಕ್ ರೆಟಿನೋಪಥಿ ಸ್ಕ್ರೀನಿಂಗ್",
    patientInformation: "ರೋಗಿಯ ಮಾಹಿತಿ",
    patientId: "ರೋಗಿ ID",
    patientName: "ರೋಗಿಯ ಹೆಸರು",
    age: "ವಯಸ್ಸು",
    gender: "ಲಿಂಗ",
    phone: "ಫೋನ್",
    village: "ಗ್ರಾಮ",
    district: "ಜಿಲ್ಲೆ",
    createPatient: "ರೋಗಿಯನ್ನು ರಚಿಸಿ",
    patientCreated: "ರೋಗಿಯನ್ನು ಯಶಸ್ವಿಯಾಗಿ ರಚಿಸಲಾಗಿದೆ",
    uploadTitle: "ಫಂಡಸ್ ಚಿತ್ರ ಅಪ್ಲೋಡ್ ಮಾಡಿ",
    uploadDescription:
      "AI-ಸಹಾಯಿತ ಸ್ಕ್ರೀನಿಂಗ್‌ಗಾಗಿ ರೆಟಿನಲ್ ಫಂಡಸ್ ಚಿತ್ರವನ್ನು ಅಪ್ಲೋಡ್ ಮಾಡಿ.",
    chooseImage: "ಫಂಡಸ್ ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಿ",
    analyzeImage: "ಚಿತ್ರವನ್ನು ವಿಶ್ಲೇಷಿಸಿ",
    analyzing: "ವಿಶ್ಲೇಷಿಸಲಾಗುತ್ತಿದೆ...",
    selectedImage: "ಆಯ್ಕೆ ಮಾಡಿದ ಚಿತ್ರ",
    clinicalSummary: "5-ಸೆಕೆಂಡ್ ಕ್ಲಿನಿಕಲ್ ಸಾರಾಂಶ",
    drGrade: "DR ಗ್ರೇಡ್",
    severity: "ತೀವ್ರತೆ",
    imageQuality: "ಚಿತ್ರ ಗುಣಮಟ್ಟ",
    vesselArea: "ರಕ್ತನಾಳ ಪ್ರದೇಶ",
    riskScore: "ಅಪಾಯ ಸ್ಕೋರ್",
    referral: "ರೆಫರಲ್",
    noDr: "ಡಯಾಬಿಟಿಕ್ ರೆಟಿನೋಪಥಿ ಇಲ್ಲ",
    mild: "ಸೌಮ್ಯ",
    moderate: "ಮಧ್ಯಮ",
    severe: "ತೀವ್ರ",
    proliferative: "ಪ್ರೊಲಿಫೆರೇಟಿವ್",
    routine: "ರೂಟಿನ್",
    urgent: "ತುರ್ತು",
    review: "ಕ್ಲಿನಿಕಲ್ ವಿಮರ್ಶೆ",
    patientPassport: "ರೆಟಿನಾ ಪಾಸ್‌ಪೋರ್ಟ್",
    screeningHistory: "ಸ್ಕ್ರೀನಿಂಗ್ ಇತಿಹಾಸ",
    screenings: "ಸ್ಕ್ರೀನಿಂಗ್‌ಗಳು",
    currentScreening: "ಪ್ರಸ್ತುತ ಸ್ಕ್ರೀನಿಂಗ್",
    previousScreening: "ಹಿಂದಿನ ಸ್ಕ್ರೀನಿಂಗ್",
    noHistory: "ಹಿಂದಿನ ಸ್ಕ್ರೀನಿಂಗ್ ಲಭ್ಯವಿಲ್ಲ.",
    triageQueue: "ವೈದ್ಯರ ವಿಮರ್ಶೆ ಕ್ಯೂ",
    triageDescription:
      "ಕ್ಲಿನಿಕಲ್ ವಿಮರ್ಶೆಗಾಗಿ AI-ಸಹಾಯಿತ ಸ್ಕ್ರೀನಿಂಗ್ ಆದ್ಯತೆ.",
    viewCase: "ಕೇಸ್ ವೀಕ್ಷಿಸಿ",
    noTriageCases: "ಪ್ರಸ್ತುತ ವಿಮರ್ಶೆ ಕ್ಯೂನಲ್ಲಿ ಯಾವುದೇ ಕೇಸ್ ಇಲ್ಲ.",
    visualEvidence: "ದೃಶ್ಯ ಸಾಕ್ಷ್ಯ",
    originalFundus: "ಮೂಲ ಫಂಡಸ್",
    structuralOverlay: "ರಚನಾತ್ಮಕ ವಿಶ್ಲೇಷಣೆ",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "ಇದು ಪ್ರೋಟೋಟೈಪ್ ಪೈಪ್‌ಲೈನ್‌ನ ವಿವರಣಾತ್ಮಕ ಸಾಕ್ಷ್ಯ; ಇದು ನ್ಯೂರಲ್ ನೆಟ್‌ವರ್ಕ್ ನಿರ್ಧಾರದ ಕಾರಣಾತ್ಮಕ ವಿವರಣೆಯಲ್ಲ.",
    lesionSegmentation: "ಲೆಷನ್ ಸೆಗ್ಮೆಂಟೇಶನ್",
    vascularStructure: "ರಕ್ತನಾಳ ರಚನೆ",
    classification: "DR ತೀವ್ರತೆ ವರ್ಗೀಕರಣ",
    progression: "ರೆಟಿನಲ್ ಪ್ರಗತಿ",
    progressionDescription:
      "ರೋಗಿಯ ಪ್ರಸ್ತುತ ಮತ್ತು ಹಿಂದಿನ ಸ್ಕ್ರೀನಿಂಗ್ ದಾಖಲೆಗಳ ಹೋಲಿಕೆ.",
    previousGrade: "ಹಿಂದಿನ ಗ್ರೇಡ್",
    currentGrade: "ಪ್ರಸ್ತುತ ಗ್ರೇಡ್",
    gradeChange: "ಗ್ರೇಡ್ ಬದಲಾವಣೆ",
    progressionStatus: "ಪ್ರಗತಿ ಸ್ಥಿತಿ",
    progressionPriority: "ಆದ್ಯತೆ",
    furtherDetails: "ಹೆಚ್ಚುವರಿ ಕ್ಲಿನಿಕಲ್ ವಿವರಗಳು",
    technicalDetails: "ತಾಂತ್ರಿಕ ವಿವರಗಳು",
    disclaimerTitle: "ವೈದ್ಯಕೀಯ ಸೂಚನೆ",
    disclaimer:
      "Eyeabetics ಒಂದು AI-ಸಹಾಯಿತ ಸಂಶೋಧನಾ ಪ್ರೋಟೋಟೈಪ್ ಮತ್ತು ವೃತ್ತಿಪರ ವೈದ್ಯಕೀಯ ನಿರ್ಣಯಕ್ಕೆ ಪರ್ಯಾಯವಲ್ಲ.",
    routineMonitoring:
      "ನಿಯಮಿತ ನೇತ್ರ ಮೇಲ್ವಿಚಾರಣೆಯನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.",
    moderateReferral:
      "ನೇತ್ರ ತಜ್ಞರ ಮೌಲ್ಯಮಾಪನವನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.",
    urgentReferral:
      "ತುರ್ತು ನೇತ್ರ ತಜ್ಞರ ವಿಮರ್ಶೆಯನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.",
    uploadRequired: "ದಯವಿಟ್ಟು ಮೊದಲು ಫಂಡಸ್ ಚಿತ್ರವನ್ನು ಆಯ್ಕೆಮಾಡಿ.",
    patientRequired:
      "ವಿಶ್ಲೇಷಣೆಗೆ ಮೊದಲು Patient ID ನಮೂದಿಸಿ ಅಥವಾ ರೋಗಿಯನ್ನು ರಚಿಸಿ.",
  },

  Tamil: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-உதவியுடன் நீரிழிவு ரெட்டினோபதி ஸ்கிரீனிங்",
    patientInformation: "நோயாளி தகவல்",
    patientId: "நோயாளி ID",
    patientName: "நோயாளியின் பெயர்",
    age: "வயது",
    gender: "பாலினம்",
    phone: "தொலைபேசி",
    village: "கிராமம்",
    district: "மாவட்டம்",
    createPatient: "நோயாளியை உருவாக்கு",
    patientCreated: "நோயாளி வெற்றிகரமாக உருவாக்கப்பட்டார்",
    uploadTitle: "Fundus படத்தை பதிவேற்றவும்",
    uploadDescription:
      "AI உதவியுடன் ஸ்கிரீனிங் செய்ய retinal fundus படத்தை பதிவேற்றவும்.",
    chooseImage: "Fundus படத்தைத் தேர்வு செய்க",
    analyzeImage: "படத்தை பகுப்பாய்வு செய்க",
    analyzing: "பகுப்பாய்வு நடைபெறுகிறது...",
    selectedImage: "தேர்ந்தெடுக்கப்பட்ட படம்",
    clinicalSummary: "5-வினாடி மருத்துவ சுருக்கம்",
    drGrade: "DR தரம்",
    severity: "தீவிரம்",
    imageQuality: "படத் தரம்",
    vesselArea: "இரத்த நாளப் பகுதி",
    riskScore: "ஆபத்து மதிப்பெண்",
    referral: "பரிந்துரை",
    noDr: "நீரிழிவு ரெட்டினோபதி இல்லை",
    mild: "லேசான",
    moderate: "மிதமான",
    severe: "கடுமையான",
    proliferative: "ப்ரோலிஃபெரேட்டிவ்",
    routine: "வழக்கமான",
    urgent: "அவசரம்",
    review: "மருத்துவ மதிப்பாய்வு",
    patientPassport: "ரெட்டினா பாஸ்போர்ட்",
    screeningHistory: "ஸ்கிரீனிங் வரலாறு",
    screenings: "ஸ்கிரீனிங்ஸ்",
    currentScreening: "தற்போதைய ஸ்கிரீனிங்",
    previousScreening: "முந்தைய ஸ்கிரீனிங்",
    noHistory: "முந்தைய ஸ்கிரீனிங் இல்லை.",
    triageQueue: "மருத்துவர் மதிப்பாய்வு வரிசை",
    triageDescription:
      "மருத்துவ மதிப்பாய்விற்கான AI உதவியுடன் ஸ்கிரீனிங் முன்னுரிமை.",
    viewCase: "கேஸைக் காண்க",
    noTriageCases: "தற்போது மதிப்பாய்வு வரிசையில் கேஸ்கள் இல்லை.",
    visualEvidence: "காட்சி ஆதாரம்",
    originalFundus: "அசல் Fundus",
    structuralOverlay: "கட்டமைப்பு பகுப்பாய்வு",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "இது prototype pipeline-இலிருந்து பெறப்பட்ட விளக்க ஆதாரம்; neural network முடிவின் காரண விளக்கம் அல்ல.",
    lesionSegmentation: "Lesion Segmentation",
    vascularStructure: "Vascular Structure",
    classification: "DR தீவிரத்தன்மை வகைப்பாடு",
    progression: "Retinal Progression",
    progressionDescription:
      "நோயாளியின் தற்போதைய மற்றும் முந்தைய ஸ்கிரீனிங் பதிவுகளின் ஒப்பீடு.",
    previousGrade: "முந்தைய தரம்",
    currentGrade: "தற்போதைய தரம்",
    gradeChange: "தர மாற்றம்",
    progressionStatus: "முன்னேற்ற நிலை",
    progressionPriority: "முன்னுரிமை",
    furtherDetails: "கூடுதல் மருத்துவ விவரங்கள்",
    technicalDetails: "தொழில்நுட்ப விவரங்கள்",
    disclaimerTitle: "மருத்துவ மறுப்பு",
    disclaimer:
      "Eyeabetics ஒரு AI உதவியுடன் செயல்படும் ஆராய்ச்சி prototype; இது தொழில்முறை மருத்துவ நோயறிதலுக்கு மாற்றாகாது.",
    routineMonitoring:
      "வழக்கமான கண் பரிசோதனை பரிந்துரைக்கப்படுகிறது.",
    moderateReferral:
      "கண் நிபுணர் மதிப்பீடு பரிந்துரைக்கப்படுகிறது.",
    urgentReferral:
      "அவசர கண் நிபுணர் மதிப்பாய்வு பரிந்துரைக்கப்படுகிறது.",
    uploadRequired: "முதலில் Fundus படத்தைத் தேர்வு செய்யவும்.",
    patientRequired:
      "பகுப்பாய்விற்கு முன் Patient ID உள்ளிடவும் அல்லது நோயாளியை உருவாக்கவும்.",
  },

  Telugu: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-సహాయక డయాబెటిక్ రెటినోపతి స్క్రీనింగ్",
    patientInformation: "రోగి సమాచారం",
    patientId: "రోగి ID",
    patientName: "రోగి పేరు",
    age: "వయస్సు",
    gender: "లింగం",
    phone: "ఫోన్",
    village: "గ్రామం",
    district: "జిల్లా",
    createPatient: "రోగిని సృష్టించండి",
    patientCreated: "రోగి విజయవంతంగా సృష్టించబడింది",
    uploadTitle: "ఫండస్ చిత్రాన్ని అప్లోడ్ చేయండి",
    uploadDescription:
      "AI సహాయక స్క్రీనింగ్ కోసం రెటినల్ ఫండస్ చిత్రాన్ని అప్లోడ్ చేయండి.",
    chooseImage: "ఫండస్ చిత్రాన్ని ఎంచుకోండి",
    analyzeImage: "చిత్రాన్ని విశ్లేషించండి",
    analyzing: "విశ్లేషిస్తోంది...",
    selectedImage: "ఎంచుకున్న చిత్రం",
    clinicalSummary: "5-సెకన్ల క్లినికల్ సారాంశం",
    drGrade: "DR గ్రేడ్",
    severity: "తీవ్రత",
    imageQuality: "చిత్ర నాణ్యత",
    vesselArea: "రక్తనాళ ప్రాంతం",
    riskScore: "రిస్క్ స్కోర్",
    referral: "రిఫరల్",
    noDr: "డయాబెటిక్ రెటినోపతి లేదు",
    mild: "తేలికపాటి",
    moderate: "మధ్యస్థ",
    severe: "తీవ్రమైన",
    proliferative: "ప్రోలిఫెరేటివ్",
    routine: "రూటీన్",
    urgent: "అత్యవసరం",
    review: "క్లినికల్ సమీక్ష",
    patientPassport: "రెటినా పాస్‌పోర్ట్",
    screeningHistory: "స్క్రీనింగ్ చరిత్ర",
    screenings: "స్క్రీనింగ్‌లు",
    currentScreening: "ప్రస్తుత స్క్రీనింగ్",
    previousScreening: "మునుపటి స్క్రీనింగ్",
    noHistory: "మునుపటి స్క్రీనింగ్ అందుబాటులో లేదు.",
    triageQueue: "డాక్టర్ సమీక్ష క్యూ",
    triageDescription:
      "క్లినికల్ సమీక్ష కోసం AI సహాయక స్క్రీనింగ్ ప్రాధాన్యత.",
    viewCase: "కేస్ చూడండి",
    noTriageCases: "ప్రస్తుతం సమీక్ష క్యూ లో కేసులు లేవు.",
    visualEvidence: "దృశ్య ఆధారం",
    originalFundus: "అసలు ఫండస్",
    structuralOverlay: "నిర్మాణ విశ్లేషణ",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "ఇది ప్రోటోటైప్ పైప్‌లైన్ నుండి వచ్చిన వివరణాత్మక ఆధారం; ఇది న్యూరల్ నెట్‌వర్క్ నిర్ణయానికి కారణాత్మక వివరణ కాదు.",
    lesionSegmentation: "లెషన్ సెగ్మెంటేషన్",
    vascularStructure: "రక్తనాళ నిర్మాణం",
    classification: "DR తీవ్రత వర్గీకరణ",
    progression: "రెటినల్ ప్రోగ్రెషన్",
    progressionDescription:
      "రోగి ప్రస్తుత మరియు మునుపటి స్క్రీనింగ్ రికార్డుల పోలిక.",
    previousGrade: "మునుపటి గ్రేడ్",
    currentGrade: "ప్రస్తుత గ్రేడ్",
    gradeChange: "గ్రేడ్ మార్పు",
    progressionStatus: "ప్రోగ్రెషన్ స్థితి",
    progressionPriority: "ప్రాధాన్యత",
    furtherDetails: "అదనపు క్లినికల్ వివరాలు",
    technicalDetails: "సాంకేతిక వివరాలు",
    disclaimerTitle: "వైద్య నిరాకరణ",
    disclaimer:
      "Eyeabetics ఒక AI సహాయక పరిశోధనా ప్రోటోటైప్ మరియు వృత్తిపరమైన వైద్య నిర్ధారణకు ప్రత్యామ్నాయం కాదు.",
    routineMonitoring:
      "క్రమం తప్పకుండా నేత్ర పరీక్ష సిఫార్సు చేయబడింది.",
    moderateReferral:
      "నేత్ర నిపుణుల మూల్యాంకనం సిఫార్సు చేయబడింది.",
    urgentReferral:
      "అత్యవసర నేత్ర నిపుణుల సమీక్ష సిఫార్సు చేయబడింది.",
    uploadRequired: "ముందుగా ఫండస్ చిత్రాన్ని ఎంచుకోండి.",
    patientRequired:
      "విశ్లేషణకు ముందు Patient ID ఇవ్వండి లేదా రోగిని సృష్టించండి.",
  },

  Marathi: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-सहाय्यित डायबेटिक रेटिनोपॅथी स्क्रीनिंग",
    patientInformation: "रुग्ण माहिती",
    patientId: "रुग्ण ID",
    patientName: "रुग्णाचे नाव",
    age: "वय",
    gender: "लिंग",
    phone: "फोन",
    village: "गाव",
    district: "जिल्हा",
    createPatient: "रुग्ण तयार करा",
    patientCreated: "रुग्ण यशस्वीरित्या तयार झाला",
    uploadTitle: "फंडस प्रतिमा अपलोड करा",
    uploadDescription:
      "AI-सहाय्यित स्क्रीनिंगसाठी रेटिनल फंडस प्रतिमा अपलोड करा.",
    chooseImage: "फंडस प्रतिमा निवडा",
    analyzeImage: "प्रतिमेचे विश्लेषण करा",
    analyzing: "विश्लेषण सुरू आहे...",
    selectedImage: "निवडलेली प्रतिमा",
    clinicalSummary: "5-सेकंद क्लिनिकल सारांश",
    drGrade: "DR ग्रेड",
    severity: "तीव्रता",
    imageQuality: "प्रतिमा गुणवत्ता",
    vesselArea: "रक्तवाहिनी क्षेत्र",
    riskScore: "जोखीम स्कोअर",
    referral: "रेफरल",
    noDr: "डायबेटिक रेटिनोपॅथी नाही",
    mild: "सौम्य",
    moderate: "मध्यम",
    severe: "गंभीर",
    proliferative: "प्रोलिफेरेटिव्ह",
    routine: "नियमित",
    urgent: "तातडीचे",
    review: "क्लिनिकल पुनरावलोकन",
    patientPassport: "रेटिना पासपोर्ट",
    screeningHistory: "स्क्रीनिंग इतिहास",
    screenings: "स्क्रीनिंग",
    currentScreening: "सध्याचे स्क्रीनिंग",
    previousScreening: "मागील स्क्रीनिंग",
    noHistory: "मागील स्क्रीनिंग उपलब्ध नाही.",
    triageQueue: "डॉक्टर पुनरावलोकन क्यू",
    triageDescription:
      "क्लिनिकल पुनरावलोकनासाठी AI-सहाय्यित स्क्रीनिंग प्राधान्य.",
    viewCase: "केस पहा",
    noTriageCases: "सध्या पुनरावलोकन क्यूमध्ये कोणतेही केस नाहीत.",
    visualEvidence: "दृश्य पुरावा",
    originalFundus: "मूळ फंडस",
    structuralOverlay: "संरचनात्मक विश्लेषण",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "हा प्रोटोटाइप पाइपलाइनमधून मिळालेला वर्णनात्मक पुरावा आहे; हा न्यूरल नेटवर्कच्या निर्णयाचे कारणात्मक स्पष्टीकरण नाही.",
    lesionSegmentation: "लेजन सेगमेंटेशन",
    vascularStructure: "रक्तवाहिनी संरचना",
    classification: "DR तीव्रता वर्गीकरण",
    progression: "रेटिनल प्रगती",
    progressionDescription:
      "रुग्णाच्या सध्याच्या आणि मागील स्क्रीनिंग नोंदींची तुलना.",
    previousGrade: "मागील ग्रेड",
    currentGrade: "सध्याचा ग्रेड",
    gradeChange: "ग्रेड बदल",
    progressionStatus: "प्रगती स्थिती",
    progressionPriority: "प्राधान्य",
    furtherDetails: "अधिक क्लिनिकल तपशील",
    technicalDetails: "तांत्रिक तपशील",
    disclaimerTitle: "वैद्यकीय अस्वीकरण",
    disclaimer:
      "Eyeabetics हा AI-सहाय्यित संशोधन प्रोटोटाइप आहे आणि व्यावसायिक वैद्यकीय निदानाचा पर्याय नाही.",
    routineMonitoring:
      "नियमित नेत्र तपासणीची शिफारस केली जाते.",
    moderateReferral:
      "नेत्रतज्ज्ञ मूल्यांकनाची शिफारस केली जाते.",
    urgentReferral:
      "तातडीच्या नेत्रतज्ज्ञ पुनरावलोकनाची शिफारस केली जाते.",
    uploadRequired: "कृपया प्रथम फंडस प्रतिमा निवडा.",
    patientRequired:
      "विश्लेषणापूर्वी Patient ID द्या किंवा रुग्ण तयार करा.",
  },

  Gujarati: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-સહાયિત ડાયાબેટિક રેટિનોપેથી સ્ક્રીનિંગ",
    patientInformation: "દર્દીની માહિતી",
    patientId: "દર્દી ID",
    patientName: "દર્દીનું નામ",
    age: "ઉંમર",
    gender: "લિંગ",
    phone: "ફોન",
    village: "ગામ",
    district: "જિલ્લો",
    createPatient: "દર્દી બનાવો",
    patientCreated: "દર્દી સફળતાપૂર્વક બનાવવામાં આવ્યો",
    uploadTitle: "ફંડસ ઇમેજ અપલોડ કરો",
    uploadDescription:
      "AI-સહાયિત સ્ક્રીનિંગ માટે રેટિનલ ફંડસ ઇમેજ અપલોડ કરો.",
    chooseImage: "ફંડસ ઇમેજ પસંદ કરો",
    analyzeImage: "ઇમેજનું વિશ્લેષણ કરો",
    analyzing: "વિશ્લેષણ થઈ રહ્યું છે...",
    selectedImage: "પસંદ કરેલી ઇમેજ",
    clinicalSummary: "5-સેકન્ડ ક્લિનિકલ સારાંશ",
    drGrade: "DR ગ્રેડ",
    severity: "તીવ્રતા",
    imageQuality: "ઇમેજ ગુણવત્તા",
    vesselArea: "રક્તવાહિની વિસ્તાર",
    riskScore: "જોખમ સ્કોર",
    referral: "રેફરલ",
    noDr: "ડાયાબેટિક રેટિનોપેથી નથી",
    mild: "હળવું",
    moderate: "મધ્યમ",
    severe: "ગંભીર",
    proliferative: "પ્રોલિફેરેટિવ",
    routine: "રૂટિન",
    urgent: "તાત્કાલિક",
    review: "ક્લિનિકલ સમીક્ષા",
    patientPassport: "રેટિના પાસપોર્ટ",
    screeningHistory: "સ્ક્રીનિંગ ઇતિહાસ",
    screenings: "સ્ક્રીનિંગ",
    currentScreening: "વર્તમાન સ્ક્રીનિંગ",
    previousScreening: "પાછલી સ્ક્રીનિંગ",
    noHistory: "કોઈ અગાઉની સ્ક્રીનિંગ ઉપલબ્ધ નથી.",
    triageQueue: "ડૉક્ટર સમીક્ષા ક્યુ",
    triageDescription:
      "ક્લિનિકલ સમીક્ષા માટે AI-સહાયિત સ્ક્રીનિંગ પ્રાથમિકતા.",
    viewCase: "કેસ જુઓ",
    noTriageCases: "હાલ સમીક્ષા ક્યુમાં કોઈ કેસ નથી.",
    visualEvidence: "દૃશ્ય પુરાવા",
    originalFundus: "મૂળ ફંડસ",
    structuralOverlay: "સ્ટ્રક્ચરલ વિશ્લેષણ",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "આ પ્રોટોટાઇપ પાઇપલાઇનમાંથી મળેલો વર્ણનાત્મક પુરાવો છે; આ ન્યુરલ નેટવર્કના નિર્ણયનું કારણાત્મક સ્પષ્ટીકરણ નથી.",
    lesionSegmentation: "લેશન સેગમેન્ટેશન",
    vascularStructure: "રક્તવાહિની રચના",
    classification: "DR તીવ્રતા વર્ગીકરણ",
    progression: "રેટિનલ પ્રોગ્રેશન",
    progressionDescription:
      "દર્દીના વર્તમાન અને અગાઉના સ્ક્રીનિંગ રેકોર્ડની તુલના.",
    previousGrade: "પાછલો ગ્રેડ",
    currentGrade: "વર્તમાન ગ્રેડ",
    gradeChange: "ગ્રેડ ફેરફાર",
    progressionStatus: "પ્રોગ્રેશન સ્થિતિ",
    progressionPriority: "પ્રાથમિકતા",
    furtherDetails: "વધુ ક્લિનિકલ વિગતો",
    technicalDetails: "તકનીકી વિગતો",
    disclaimerTitle: "તબીબી અસ્વીકરણ",
    disclaimer:
      "Eyeabetics એ AI-સહાયિત સંશોધન પ્રોટોટાઇપ છે અને વ્યાવસાયિક તબીબી નિદાનનો વિકલ્પ નથી.",
    routineMonitoring:
      "નિયમિત આંખની તપાસની ભલામણ કરવામાં આવે છે.",
    moderateReferral:
      "નેત્ર નિષ્ણાત દ્વારા મૂલ્યાંકનની ભલામણ કરવામાં આવે છે.",
    urgentReferral:
      "તાત્કાલિક નેત્ર નિષ્ણાત સમીક્ષાની ભલામણ કરવામાં આવે છે.",
    uploadRequired: "કૃપા કરીને પહેલા ફંડસ ઇમેજ પસંદ કરો.",
    patientRequired:
      "વિશ્લેષણ પહેલાં Patient ID દાખલ કરો અથવા દર્દી બનાવો.",
  },

  Malayalam: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI സഹായത്തോടെയുള്ള ഡയബറ്റിക് റെറ്റിനോപ്പതി സ്ക്രീനിംഗ്",
    patientInformation: "രോഗിയുടെ വിവരങ്ങൾ",
    patientId: "രോഗി ID",
    patientName: "രോഗിയുടെ പേര്",
    age: "പ്രായം",
    gender: "ലിംഗം",
    phone: "ഫോൺ",
    village: "ഗ്രാമം",
    district: "ജില്ല",
    createPatient: "രോഗിയെ സൃഷ്ടിക്കുക",
    patientCreated: "രോഗി വിജയകരമായി സൃഷ്ടിച്ചു",
    uploadTitle: "ഫണ്ടസ് ചിത്രം അപ്‌ലോഡ് ചെയ്യുക",
    uploadDescription:
      "AI സഹായത്തോടെയുള്ള സ്ക്രീനിംഗിനായി retinal fundus ചിത്രം അപ്‌ലോഡ് ചെയ്യുക.",
    chooseImage: "ഫണ്ടസ് ചിത്രം തിരഞ്ഞെടുക്കുക",
    analyzeImage: "ചിത്രം വിശകലനം ചെയ്യുക",
    analyzing: "വിശകലനം നടക്കുന്നു...",
    selectedImage: "തിരഞ്ഞെടുത്ത ചിത്രം",
    clinicalSummary: "5-സെക്കൻഡ് ക്ലിനിക്കൽ സംഗ്രഹം",
    drGrade: "DR ഗ്രേഡ്",
    severity: "തീവ്രത",
    imageQuality: "ചിത്ര ഗുണനിലവാരം",
    vesselArea: "രക്തക്കുഴൽ വിസ്തീർണ്ണം",
    riskScore: "റിസ്ക് സ്കോർ",
    referral: "റഫറൽ",
    noDr: "ഡയബറ്റിക് റെറ്റിനോപ്പതി ഇല്ല",
    mild: "ലഘു",
    moderate: "മിതമായ",
    severe: "ഗുരുതരമായ",
    proliferative: "പ്രൊലിഫറേറ്റീവ്",
    routine: "റൂട്ടീൻ",
    urgent: "അടിയന്തരം",
    review: "ക്ലിനിക്കൽ റിവ്യൂ",
    patientPassport: "റെറ്റിന പാസ്‌പോർട്ട്",
    screeningHistory: "സ്ക്രീനിംഗ് ചരിത്രം",
    screenings: "സ്ക്രീനിംഗുകൾ",
    currentScreening: "നിലവിലെ സ്ക്രീനിംഗ്",
    previousScreening: "മുൻ സ്ക്രീനിംഗ്",
    noHistory: "മുൻ സ്ക്രീനിംഗ് ലഭ്യമല്ല.",
    triageQueue: "ഡോക്ടർ റിവ്യൂ ക്യൂ",
    triageDescription:
      "ക്ലിനിക്കൽ റിവ്യൂവിനായി AI സഹായത്തോടെയുള്ള സ്ക്രീനിംഗ് മുൻഗണന.",
    viewCase: "കേസ് കാണുക",
    noTriageCases: "നിലവിൽ റിവ്യൂ ക്യൂവിൽ കേസുകളില്ല.",
    visualEvidence: "ദൃശ്യ തെളിവുകൾ",
    originalFundus: "യഥാർത്ഥ ഫണ്ടസ്",
    structuralOverlay: "ഘടനാപരമായ വിശകലനം",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "ഇത് prototype pipeline-ൽ നിന്നുള്ള വിവരണാത്മക തെളിവാണ്; neural-network തീരുമാനത്തിന്റെ കാരണപരമായ വിശദീകരണമല്ല.",
    lesionSegmentation: "Lesion Segmentation",
    vascularStructure: "Vascular Structure",
    classification: "DR തീവ്രത വർഗ്ഗീകരണം",
    progression: "റെറ്റിനൽ പ്രോഗ്രഷൻ",
    progressionDescription:
      "രോഗിയുടെ നിലവിലുള്ളതും മുൻപുള്ളതുമായ സ്ക്രീനിംഗ് രേഖകളുടെ താരതമ്യം.",
    previousGrade: "മുൻ ഗ്രേഡ്",
    currentGrade: "നിലവിലെ ഗ്രേഡ്",
    gradeChange: "ഗ്രേഡ് മാറ്റം",
    progressionStatus: "പ്രോഗ്രഷൻ നില",
    progressionPriority: "മുൻഗണന",
    furtherDetails: "കൂടുതൽ ക്ലിനിക്കൽ വിശദാംശങ്ങൾ",
    technicalDetails: "സാങ്കേതിക വിശദാംശങ്ങൾ",
    disclaimerTitle: "മെഡിക്കൽ ഡിസ്ക്ലെയിമർ",
    disclaimer:
      "Eyeabetics ഒരു AI സഹായത്തോടെയുള്ള ഗവേഷണ പ്രോട്ടോടൈപ്പാണ്, പ്രൊഫഷണൽ മെഡിക്കൽ രോഗനിർണയത്തിന് പകരമല്ല.",
    routineMonitoring:
      "ക്രമമായ നേത്രപരിശോധന ശുപാർശ ചെയ്യുന്നു.",
    moderateReferral:
      "നേത്രരോഗ വിദഗ്ധന്റെ വിലയിരുത്തൽ ശുപാർശ ചെയ്യുന്നു.",
    urgentReferral:
      "അടിയന്തര നേത്രരോഗ വിദഗ്ധ പരിശോധന ശുപാർശ ചെയ്യുന്നു.",
    uploadRequired: "ആദ്യം ഒരു ഫണ്ടസ് ചിത്രം തിരഞ്ഞെടുക്കുക.",
    patientRequired:
      "വിശകലനത്തിന് മുമ്പ് Patient ID നൽകുക അല്ലെങ്കിൽ രോഗിയെ സൃഷ്ടിക്കുക.",
  },

  Punjabi: {
    appTitle: "EYEABETICS",
    appSubtitle: "AI-ਸਹਾਇਕ ਡਾਇਬੇਟਿਕ ਰੈਟੀਨੋਪੈਥੀ ਸਕ੍ਰੀਨਿੰਗ",
    patientInformation: "ਮਰੀਜ਼ ਦੀ ਜਾਣਕਾਰੀ",
    patientId: "ਮਰੀਜ਼ ID",
    patientName: "ਮਰੀਜ਼ ਦਾ ਨਾਮ",
    age: "ਉਮਰ",
    gender: "ਲਿੰਗ",
    phone: "ਫੋਨ",
    village: "ਪਿੰਡ",
    district: "ਜ਼ਿਲ੍ਹਾ",
    createPatient: "ਮਰੀਜ਼ ਬਣਾਓ",
    patientCreated: "ਮਰੀਜ਼ ਸਫਲਤਾਪੂਰਵਕ ਬਣਾਇਆ ਗਿਆ",
    uploadTitle: "ਫੰਡਸ ਚਿੱਤਰ ਅਪਲੋਡ ਕਰੋ",
    uploadDescription:
      "AI-ਸਹਾਇਕ ਸਕ੍ਰੀਨਿੰਗ ਲਈ ਰੈਟਿਨਲ ਫੰਡਸ ਚਿੱਤਰ ਅਪਲੋਡ ਕਰੋ।",
    chooseImage: "ਫੰਡਸ ਚਿੱਤਰ ਚੁਣੋ",
    analyzeImage: "ਚਿੱਤਰ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ",
    analyzing: "ਵਿਸ਼ਲੇਸ਼ਣ ਹੋ ਰਿਹਾ ਹੈ...",
    selectedImage: "ਚੁਣਿਆ ਚਿੱਤਰ",
    clinicalSummary: "5-ਸਕਿੰਟ ਕਲੀਨਿਕਲ ਸਾਰ",
    drGrade: "DR ਗ੍ਰੇਡ",
    severity: "ਗੰਭੀਰਤਾ",
    imageQuality: "ਚਿੱਤਰ ਗੁਣਵੱਤਾ",
    vesselArea: "ਖੂਨ ਦੀਆਂ ਨਾੜੀਆਂ ਦਾ ਖੇਤਰ",
    riskScore: "ਜੋਖਮ ਸਕੋਰ",
    referral: "ਰੈਫਰਲ",
    noDr: "ਡਾਇਬੇਟਿਕ ਰੈਟੀਨੋਪੈਥੀ ਨਹੀਂ",
    mild: "ਹਲਕਾ",
    moderate: "ਮੱਧਮ",
    severe: "ਗੰਭੀਰ",
    proliferative: "ਪ੍ਰੋਲੀਫਰੇਟਿਵ",
    routine: "ਰੂਟੀਨ",
    urgent: "ਤੁਰੰਤ",
    review: "ਕਲੀਨਿਕਲ ਸਮੀਖਿਆ",
    patientPassport: "ਰੈਟੀਨਾ ਪਾਸਪੋਰਟ",
    screeningHistory: "ਸਕ੍ਰੀਨਿੰਗ ਇਤਿਹਾਸ",
    screenings: "ਸਕ੍ਰੀਨਿੰਗ",
    currentScreening: "ਮੌਜੂਦਾ ਸਕ੍ਰੀਨਿੰਗ",
    previousScreening: "ਪਿਛਲੀ ਸਕ੍ਰੀਨਿੰਗ",
    noHistory: "ਕੋਈ ਪਿਛਲੀ ਸਕ੍ਰੀਨਿੰਗ ਉਪਲਬਧ ਨਹੀਂ।",
    triageQueue: "ਡਾਕਟਰ ਸਮੀਖਿਆ ਕਤਾਰ",
    triageDescription:
      "ਕਲੀਨਿਕਲ ਸਮੀਖਿਆ ਲਈ AI-ਸਹਾਇਕ ਸਕ੍ਰੀਨਿੰਗ ਤਰਜੀਹ।",
    viewCase: "ਕੇਸ ਵੇਖੋ",
    noTriageCases: "ਇਸ ਵੇਲੇ ਸਮੀਖਿਆ ਕਤਾਰ ਵਿੱਚ ਕੋਈ ਕੇਸ ਨਹੀਂ ਹੈ।",
    visualEvidence: "ਦ੍ਰਿਸ਼ਟੀਗਤ ਸਬੂਤ",
    originalFundus: "ਅਸਲ ਫੰਡਸ",
    structuralOverlay: "ਸੰਰਚਨਾਤਮਕ ਵਿਸ਼ਲੇਸ਼ਣ",
    aiEvidence: "AI Evidence Summary",
    evidenceDisclaimer:
      "ਇਹ ਪ੍ਰੋਟੋਟਾਈਪ ਪਾਈਪਲਾਈਨ ਤੋਂ ਪ੍ਰਾਪਤ ਵਰਣਨਾਤਮਕ ਸਬੂਤ ਹੈ; ਇਹ ਨਿਊਰਲ ਨੈੱਟਵਰਕ ਦੇ ਫੈਸਲੇ ਦੀ ਕਾਰਣਾਤਮਕ ਵਿਆਖਿਆ ਨਹੀਂ ਹੈ।",
    lesionSegmentation: "ਲੇਜ਼ਨ ਸੈਗਮੈਂਟੇਸ਼ਨ",
    vascularStructure: "ਵੈਸਕੁਲਰ ਢਾਂਚਾ",
    classification: "DR ਗੰਭੀਰਤਾ ਵਰਗੀਕਰਨ",
    progression: "ਰੈਟੀਨਲ ਪ੍ਰਗਤੀ",
    progressionDescription:
      "ਮਰੀਜ਼ ਦੇ ਮੌਜੂਦਾ ਅਤੇ ਪਿਛਲੇ ਸਕ੍ਰੀਨਿੰਗ ਰਿਕਾਰਡ ਦੀ ਤੁਲਨਾ।",
    previousGrade: "ਪਿਛਲਾ ਗ੍ਰੇਡ",
    currentGrade: "ਮੌਜੂਦਾ ਗ੍ਰੇਡ",
    gradeChange: "ਗ੍ਰੇਡ ਬਦਲਾਅ",
    progressionStatus: "ਪ੍ਰਗਤੀ ਸਥਿਤੀ",
    progressionPriority: "ਤਰਜੀਹ",
    furtherDetails: "ਹੋਰ ਕਲੀਨਿਕਲ ਵੇਰਵੇ",
    technicalDetails: "ਤਕਨੀਕੀ ਵੇਰਵੇ",
    disclaimerTitle: "ਮੈਡੀਕਲ ਡਿਸਕਲੇਮਰ",
    disclaimer:
      "Eyeabetics ਇੱਕ AI-ਸਹਾਇਕ ਖੋਜ ਪ੍ਰੋਟੋਟਾਈਪ ਹੈ ਅਤੇ ਪੇਸ਼ੇਵਰ ਮੈਡੀਕਲ ਨਿਦਾਨ ਦਾ ਬਦਲ ਨਹੀਂ ਹੈ।",
    routineMonitoring:
      "ਨਿਯਮਿਤ ਅੱਖਾਂ ਦੀ ਜਾਂਚ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।",
    moderateReferral:
      "ਅੱਖਾਂ ਦੇ ਮਾਹਰ ਦੁਆਰਾ ਮੁਲਾਂਕਣ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।",
    urgentReferral:
      "ਤੁਰੰਤ ਅੱਖਾਂ ਦੇ ਮਾਹਰ ਦੀ ਸਮੀਖਿਆ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।",
    uploadRequired: "ਕਿਰਪਾ ਕਰਕੇ ਪਹਿਲਾਂ ਫੰਡਸ ਚਿੱਤਰ ਚੁਣੋ।",
    patientRequired:
      "ਵਿਸ਼ਲੇਸ਼ਣ ਤੋਂ ਪਹਿਲਾਂ Patient ID ਦਿਓ ਜਾਂ ਮਰੀਜ਼ ਬਣਾਓ।",
  },
};


// ============================================================
// HELPERS
// ============================================================

function getText(language, key) {

  return (
    translations[language]?.[key] ||
    translations.English[key] ||
    key
  );
}


function numberOrNull(value) {

  const n =
    Number(value);

  return Number.isFinite(n)
    ? n
    : null;
}


function getGradeLabel(
  grade,
  language = "English"
) {

  const g =
    numberOrNull(grade);

  const labels = {

    0:
      getText(language, "noDr"),

    1:
      getText(language, "mild"),

    2:
      getText(language, "moderate"),

    3:
      getText(language, "severe"),

    4:
      getText(language, "proliferative"),
  };

  return (
    labels[g] ||
    "Unknown"
  );
}


function getSeverityClass(
  grade
) {

  const g =
    numberOrNull(grade);

  if (g >= 4)
    return "critical";

  if (g === 3)
    return "high";

  if (g === 2)
    return "moderate";

  return "routine";
}


function getReferralText(
  grade,
  language = "English"
) {

  const g =
    numberOrNull(grade);

  if (g >= 3) {

    return getText(
      language,
      "urgentReferral"
    );
  }

  if (g === 2) {

    return getText(
      language,
      "moderateReferral"
    );
  }

  return getText(
    language,
    "routineMonitoring"
  );
}
function createOfflineReferral(
  result,
  patientName,
  patientId
) {
  if (!result) return null;

  const grade = Number(
    result.drGrade ?? result.grade ?? 0
  );

  const severity =
    result.drLabel ||
    getGradeLabel(grade, "English");

  const urgency =
    grade >= 3
      ? "URGENT"
      : grade === 2
      ? "MODERATE"
      : "ROUTINE";

  const message =
    `EYEABETICS REFERRAL\n\n` +
    `Patient: ${patientName || "Patient"}\n` +
    `Patient ID: ${patientId || "N/A"}\n` +
    `DR Grade: ${grade}\n` +
    `Severity: ${severity}\n` +
    `Priority: ${urgency}\n\n` +
    `AI-assisted screening prototype. Clinical review required.`;

  return {
    id: `WA-${Date.now()}`,
    patientName: patientName || "Patient",
    patientId: patientId || "N/A",
    grade,
    severity,
    urgency,
    message,
    status: "QUEUED OFFLINE",
    createdAt: new Date().toISOString(),
  };
}


function getUrgencyLabel(
  priority,
  language = "English"
) {

  const p =
    String(
      priority || ""
    ).toUpperCase();

  if (
    p === "CRITICAL" ||
    p === "HIGH" ||
    p === "URGENT"
  ) {

    return getText(
      language,
      "urgent"
    );
  }

  if (
    p === "MODERATE"
  ) {

    return getText(
      language,
      "review"
    );
  }

  return getText(
    language,
    "routine"
  );
}


function getLesionEntries(
  lesionCounts
) {

  if (
    !lesionCounts ||
    typeof lesionCounts !== "object"
  ) {

    return [];
  }

  return Object.entries(
    lesionCounts
  )
    .filter(
      ([key, value]) => {

        const k =
          String(key)
            .toLowerCase();

        return (
          k !== "background" &&
          k !== "class1" &&
          numberOrNull(value) !== null
        );
      }
    )
    .map(
      ([key, value]) => ({

        className:
          String(key),

        pixels:
          Number(value),
      })
    )
    .sort(
      (a, b) =>
        b.pixels -
        a.pixels
    );
}


function getLesionName(
  className
) {

  const name =
    String(className)
      .toLowerCase();

  if (
    name.includes("class")
  ) {

    return String(
      className
    );
  }

  return `Lesion ${className}`;
}


function getRiskScore(
  result
) {

  return numberOrNull(
    result?.riskScoreAdjusted ??
    result?.riskScore
  );
}


function formatReportDate(
  value
) {

  if (!value)
    return "N/A";

  const date =
    new Date(value);

  if (
    Number.isNaN(
      date.getTime()
    )
  ) {

    return "N/A";
  }

  return date.toLocaleString();
}


function getCurrentGrade(
  progression,
  result
) {

  if (
    progression?.available &&
    progression?.current
  ) {

    return numberOrNull(
      progression.current.drGrade
    );
  }

  return numberOrNull(
    result?.drGrade ??
    result?.grade
  );
}


function getProgressionClass(
  progression
) {

  const level =
    String(
      progression?.progression?.level ||
      ""
    ).toLowerCase();

  if (
    level === "critical"
  )
    return "critical";

  if (
    level === "high"
  )
    return "high";

  if (
    level === "moderate"
  )
    return "moderate";

  return "routine";
}


function getImageUrl(
  fileOrUrl
) {

  if (!fileOrUrl)
    return null;

  if (
    String(fileOrUrl)
      .startsWith("data:")
  ) {

    return fileOrUrl;
  }

  if (
    String(fileOrUrl)
      .startsWith("http://") ||
    String(fileOrUrl)
      .startsWith("https://")
  ) {

    return fileOrUrl;
  }

  const name =
    String(fileOrUrl)
      .split(/[\\/]/)
      .pop();

  return `${API}/api/uploads/${encodeURIComponent(name)}`;
}


// ============================================================
// APP
// ============================================================

function App() {

  const [language, setLanguage] =
    useState("English");

  const [patientId, setPatientId] =
    useState("");

  const [patientName, setPatientName] =
    useState("");
   
  const [showDemoAbha, setShowDemoAbha] = useState(false)

  const [offlineReferral, setOfflineReferral] = useState(null)
  
  const [age, setAge] =
    useState("");

  const [gender, setGender] =
    useState("");

  const [phone, setPhone] =
    useState("");

  const [village, setVillage] =
    useState("");

  const [district, setDistrict] =
    useState("");


  const [image, setImage] =
    useState(null);

  const [preview, setPreview] =
    useState(null);

  const [result, setResult] =
    useState(null);

  const [loading, setLoading] =
    useState(false);

  const [error, setError] =
    useState("");


  const [passportPatient, setPassportPatient] =
    useState(null);

  const [progression, setProgression] =
    useState(null);

  const [progressionLoading, setProgressionLoading] =
    useState(false);

  const [screenings, setScreenings] =
    useState([]);


  const [triage, setTriage] =
    useState(null);

  const [triageLoading, setTriageLoading] =
    useState(false);

  const [triageError, setTriageError] =
    useState("");

  const [selectedTriageCase, setSelectedTriageCase] =
    useState(null);


  const [patientMessage, setPatientMessage] =
    useState("");

  const [showDetails, setShowDetails] =
    useState(false);

  const [showTechnical, setShowTechnical] =
    useState(false);


  const t =
    (key) =>
      getText(
        language,
        key
      );


  // ==========================================================
  // LOAD TRIAGE
  // ==========================================================

  const fetchTriageQueue =
    async () => {

      setTriageLoading(
        true
      );

      setTriageError(
        ""
      );

      try {

        const response =
          await fetch(
            `${API}/api/triage`
          );

        if (!response.ok) {

          throw new Error(
            "Unable to load triage queue."
          );
        }

        const data =
          await response.json();

        setTriage(
          data
        );

      } catch (err) {

        console.error(
          err
        );

        setTriageError(
          err.message
        );

      } finally {

        setTriageLoading(
          false
        );
      }
    };


  // ==========================================================
  // INITIAL LOAD
  // ==========================================================

  useEffect(
    () => {

      fetchTriageQueue();

    },
    []
  );


  // ==========================================================
  // LOAD PATIENT
  // ==========================================================

  const loadPatientData =
    async (
      id
    ) => {

      if (!id)
        return;

      try {

        const patientResponse =
          await fetch(
            `${API}/api/patients/${encodeURIComponent(id)}`
          );

        if (
          patientResponse.ok
        ) {

          const patientData =
            await patientResponse.json();

          if (
            patientData.patient
          ) {

            setPassportPatient(
              patientData.patient
            );

            setPatientName(
              patientData.patient.name ||
              ""
            );

            setAge(
              patientData.patient.age ??
              ""
            );

            setGender(
              patientData.patient.gender ||
              ""
            );

            setPhone(
              patientData.patient.phone ||
              ""
            );

            setVillage(
              patientData.patient.village ||
              ""
            );

            setDistrict(
              patientData.patient.district ||
              ""
            );
          }
        }


        await loadScreeningHistory(
          id
        );

      } catch (err) {

        console.error(
          "Patient loading error:",
          err
        );
      }
    };


  // ==========================================================
  // LOAD SCREENING HISTORY
  // ==========================================================

  const loadScreeningHistory =
    async (
      id
    ) => {

      if (!id)
        return;

      try {

        const response =
          await fetch(
            `${API}/api/patients/${encodeURIComponent(id)}/screenings`
          );

        if (
          !response.ok
        ) {

          return;
        }

        const data =
          await response.json();

        setScreenings(
          data.screenings ||
          []
        );

      } catch (err) {

        console.error(
          "Screening history error:",
          err
        );
      }
    };


  // ==========================================================
  // LOAD PROGRESSION
  // ==========================================================

  const loadProgression =
    async (
      id
    ) => {

      if (!id) {

        setProgression(
          null
        );

        return;
      }

      setProgressionLoading(
        true
      );

      try {

        const response =
          await fetch(
            `${API}/api/patients/${encodeURIComponent(id)}/progression`
          );

        if (
          !response.ok
        ) {

          setProgression(
            null
          );

          return;
        }

        const data =
          await response.json();

        setProgression(
          data.progression ||
          null
        );

      } catch (err) {

        console.error(
          "Progression error:",
          err
        );

        setProgression(
          null
        );

      } finally {

        setProgressionLoading(
          false
        );
      }
    };


  // ==========================================================
  // TRIAGE CASE SELECTION
  // ==========================================================

  const handleTriageCase =
    async (
      caseItem
    ) => {

      if (!caseItem?.patientId)
        return;

      setError("");

      setSelectedTriageCase(
        caseItem
      );

      setPatientId(
        caseItem.patientId
      );


      try {

        // ------------------------------------------------------
        // Patient
        // ------------------------------------------------------

        const patientResponse =
          await fetch(
            `${API}/api/patients/${encodeURIComponent(caseItem.patientId)}`
          );

        if (
          patientResponse.ok
        ) {

          const patientData =
            await patientResponse.json();

          if (
            patientData.patient
          ) {

            setPassportPatient(
              patientData.patient
            );

            setPatientName(
              patientData.patient.name ||
              ""
            );

            setAge(
              patientData.patient.age ??
              ""
            );

            setGender(
              patientData.patient.gender ||
              ""
            );

            setPhone(
              patientData.patient.phone ||
              ""
            );

            setVillage(
              patientData.patient.village ||
              ""
            );

            setDistrict(
              patientData.patient.district ||
              ""
            );
          }
        }


        // ------------------------------------------------------
        // Selected screening
        // ------------------------------------------------------

        if (
          caseItem.screeningId
        ) {

          const screeningResponse =
            await fetch(
              `${API}/api/screenings/${caseItem.screeningId}`
            );

          if (
            screeningResponse.ok
          ) {

            const screeningData =
              await screeningResponse.json();

            if (
              screeningData.screening
            ) {

              const screening =
                screeningData.screening;

              setResult({

                ...screening,

                drGrade:
                  screening.drGrade,

                drLabel:
                  screening.drLabel,

                vesselPercentage:
                  screening.vesselPercentage,

                lesionCounts:
                  screening.lesionFindings,

                isGradeable:
                  screening.imageQuality?.isGradeable,

                qualityScore:
                  screening.imageQuality?.qualityScore,

                qualityMessage:
                  screening.imageQuality?.qualityMessage,

                riskScore:
                  screening.riskScore,

                referral:
                  screening.referral,

                overlayPath:
                  screening.structuralOverlay,

                overlayUrl:
                  screening.overlayUrl,

                imageUrl:
                  screening.imageUrl,

                evidence:
                  screening.evidence,
              });


              // ------------------------------------------------
              // Use server-provided image URL
              // ------------------------------------------------

              const imageUrl =
                screening.imageUrl ||
                getImageUrl(
                  screening.imageName
                );

              setPreview(
                imageUrl
              );
            }
          }
        }


        await loadScreeningHistory(
          caseItem.patientId
        );

        await loadProgression(
          caseItem.patientId
        );


        window.scrollTo({
          top: 0,
          behavior: "smooth",
        });

      } catch (err) {

        console.error(
          "Triage case error:",
          err
        );

        setError(
          "Unable to load the selected case."
        );
      }
    };


  // ==========================================================
  // IMAGE HANDLER
  // ==========================================================

  const handleImage =
    (
      event
    ) => {

      const file =
        event.target.files?.[0];

      if (!file)
        return;

      setImage(
        file
      );

      setPreview(
        URL.createObjectURL(
          file
        )
      );

      setResult(
        null
      );

      setProgression(
        null
      );

      setSelectedTriageCase(
        null
      );

      setError(
        ""
      );

      setPatientMessage(
        ""
      );
    };


  // ==========================================================
  // CREATE PATIENT
  // ==========================================================

  const createPatient =
    async () => {

      setPatientMessage(
        ""
      );

      setError(
        ""
      );


      if (!patientName.trim()) {

        setError(
          "Patient name is required."
        );

        return;
      }


      try {

        const response =
          await fetch(
            `${API}/api/patients`,
            {
              method:
                "POST",

              headers: {
                "Content-Type":
                  "application/json",
              },

              body:
                JSON.stringify({

                  patientId:
                    patientId.trim() ||
                    undefined,

                  name:
                    patientName.trim(),

                  age:
                    age === ""
                      ? undefined
                      : Number(age),

                  gender,

                  phone,

                  village,

                  district,
                }),
            }
          );


        const data =
          await response.json();


        if (
          !response.ok
        ) {

          throw new Error(
            data.error ||
            "Could not create patient."
          );
        }


        setPatientId(
          data.patient.patientId
        );

        setPassportPatient(
          data.patient
        );

        setPatientMessage(
          t("patientCreated")
        );

      } catch (err) {

        console.error(
          err
        );

        setError(
          err.message
        );
      }
    };


  // ==========================================================
  // ANALYZE IMAGE
  // ==========================================================

  const analyzeImage =
    async () => {

      setError(
        ""
      );

      setPatientMessage(
        ""
      );


      if (!image) {

        setError(
          t("uploadRequired")
        );

        return;
      }


      if (!patientId.trim()) {

        setError(
          t("patientRequired")
        );

        return;
      }


      setLoading(
        true
      );

      setResult(
        null
      );

      setProgression(
        null
      );


      try {

        const reader =
          new FileReader();


        reader.onload =
          async () => {

            try {

              const response =
                await fetch(
                  `${API}/api/analyze`,
                  {
                    method:
                      "POST",

                    headers: {
                      "Content-Type":
                        "application/json",
                    },

                    body:
                      JSON.stringify({

                        image:
                          reader.result,

                        patientId:
                          patientId.trim(),
                      }),
                  }
                );


              const data =
                await response.json();


              if (
                !response.ok
              ) {

                throw new Error(
                  data.error ||
                  "Analysis failed."
                );
              }


              setResult(
                data
              );


              // -----------------------------------------------
              // Refresh patient / passport
              // -----------------------------------------------

              await loadPatientData(
                patientId.trim()
              );


              await loadProgression(
                patientId.trim()
              );


              await fetchTriageQueue();


              window.scrollTo({
                top: 0,
                behavior: "smooth",
              });

            } catch (err) {

              console.error(
                err
              );

              setError(
                err.message
              );

            } finally {

              setLoading(
                false
              );
            }
          };


        reader.onerror =
          () => {

            setError(
              "Could not read the image."
            );

            setLoading(
              false
            );
          };


        reader.readAsDataURL(
          image
        );

      } catch (err) {

        console.error(
          err
        );

        setError(
          err.message
        );

        setLoading(
          false
        );
      }
    };


  // ==========================================================
  // DERIVED DATA
  // ==========================================================

  const currentGrade =
    getCurrentGrade(
      progression,
      result
    );


  const currentSeverityClass =
    getSeverityClass(
      currentGrade
    );


  const reportPatientName =
    passportPatient?.name ||
    patientName ||
    "Patient";


  const reportPatientId =
    passportPatient?.patientId ||
    patientId ||
    "N/A";


  const reportAge =
    passportPatient?.age ??
    age ??
    "N/A";


  const reportGender =
    passportPatient?.gender ||
    gender ||
    "N/A";


  const reportVillage =
    passportPatient?.village ||
    village ||
    "N/A";


  const reportDistrict =
    passportPatient?.district ||
    district ||
    "N/A";


  const currentLabel =
    progression?.available
      ? progression.current?.drLabel
      : getGradeLabel(
          currentGrade,
          language
        );


  const reportPriority =
    progression?.available
      ? progression.progression?.priority
      : String(
          result?.referral?.urgency ||
          "ROUTINE"
        ).toUpperCase();


  const passportHistory =
    [...screenings].sort(
      (a, b) =>
        new Date(
          b.screenedAt
        ) -
        new Date(
          a.screenedAt
        )
    );


  const passportCount =
    passportHistory.length;


  const passportLatest =
    passportHistory[0] ||
    null;


  const lesionEntries =
    getLesionEntries(
      result?.lesionCounts ||
      result?.lesionFindings
    );


  const evidence =
    result?.evidence ||
    null;


  const vesselPercentage =
    numberOrNull(
      result?.vesselPercentage
    );


  const qualityScore =
    numberOrNull(
      result?.qualityScore ??
      result?.imageQuality?.qualityScore
    );


  const riskScore =
    getRiskScore(
      result
    );


  const overlayUrl =
    result?.overlayUrl ||
    getImageUrl(
      result?.overlayPath ||
      result?.structuralOverlay
    );


  const originalResultImage =
    result?.imageUrl ||
    getImageUrl(
      result?.imageName
    );


  // ==========================================================
  // RENDER
  // ==========================================================

  return (

    <div className="app hospital-app">


      {/* ======================================================
          NAVBAR
          ====================================================== */}

      <header className="navbar hospital-navbar">

        <div className="brand">

          <div className="brand-mark">
            E
          </div>

          <div>

            <div className="brand-title">
              {t("appTitle")}
            </div>

            <div className="brand-subtitle">
              {t("appSubtitle")}
            </div>

          </div>

        </div>


        <div className="navbar-actions">

          <select
            className="language-select"
            value={language}
            onChange={(e) =>
              setLanguage(
                e.target.value
              )
            }
          >

            {Object.keys(
              translations
            ).map(
              (lang) => (

                <option
                  key={lang}
                  value={lang}
                >
                  {lang}
                </option>

              )
            )}

          </select>

          <div className="status-pill">
            <span className="status-dot"></span>
            AI Screening Prototype
          </div>

        </div>

      </header>


      <main className="main-content">


        {/* ====================================================
            PATIENT INFORMATION
            ==================================================== */}

        <section className="card patient-card">

          <div className="section-heading">

            <div>

              <span className="section-eyebrow">
                PATIENT
              </span>

              <h2>
                {t("patientInformation")}
              </h2>

            </div>

            {passportPatient && (

              <div className="patient-id-badge">

                {passportPatient.patientId}

              </div>

            )}

          </div>


          <div className="form-grid">

            <label>

              <span>
                {t("patientId")}
              </span>

              <input
                value={patientId}
                onChange={(e) =>
                  setPatientId(
                    e.target.value
                  )
                }
                placeholder="e.g. PAT-001"
              />

            </label>


            <label>

              <span>
                {t("patientName")}
              </span>

              <input
                value={patientName}
                onChange={(e) =>
                  setPatientName(
                    e.target.value
                  )
                }
                placeholder="Patient name"
              />

            </label>


            <label>

              <span>
                {t("age")}
              </span>

              <input
                type="number"
                value={age}
                onChange={(e) =>
                  setAge(
                    e.target.value
                  )
                }
                placeholder="Age"
              />

            </label>


            <label>

              <span>
                {t("gender")}
              </span>

              <input
                value={gender}
                onChange={(e) =>
                  setGender(
                    e.target.value
                  )
                }
                placeholder="Gender"
              />

            </label>


            <label>

              <span>
                {t("phone")}
              </span>

              <input
                value={phone}
                onChange={(e) =>
                  setPhone(
                    e.target.value
                  )
                }
                placeholder="Phone"
              />

            </label>


            <label>

              <span>
                {t("village")}
              </span>

              <input
                value={village}
                onChange={(e) =>
                  setVillage(
                    e.target.value
                  )
                }
                placeholder="Village"
              />

            </label>


            <label>

              <span>
                {t("district")}
              </span>

              <input
                value={district}
                onChange={(e) =>
                  setDistrict(
                    e.target.value
                  )
                }
                placeholder="District"
              />

            </label>

          </div>


          <div className="patient-actions">

            <button
              className="secondary-button"
              onClick={
                createPatient
              }
            >
              {t("createPatient")}
            </button>

            {patientMessage && (

              <span className="success-message">
                {patientMessage}
              </span>

            )}

          </div>

        </section>


        {/* ====================================================
            UPLOAD
            ==================================================== */}

        <section className="card upload-card">

          <div className="section-heading">

            <div>

              <span className="section-eyebrow">
                SCREENING
              </span>

              <h2>
                {t("uploadTitle")}
              </h2>

              <p>
                {t("uploadDescription")}
              </p>

            </div>

          </div>


          <div className="upload-layout">

            <label className="upload-box">

              <input
                type="file"
                accept="image/*"
                onChange={
                  handleImage
                }
              />

              <div className="upload-icon">
                ↑
              </div>

              <strong>
                {t("chooseImage")}
              </strong>

              <span>
                JPG / JPEG / PNG
              </span>

            </label>


            <div className="preview-box">

              {preview ? (

                <img
                  src={
                    preview
                  }
                  alt="Fundus preview"
                />

              ) : (

                <div className="empty-preview">
                  {t("selectedImage")}
                </div>

              )}

            </div>

          </div>


          {error && (

            <div className="error-banner">
              {error}
            </div>

          )}


          <button
            className="primary-button analyze-button"
            onClick={
              analyzeImage
            }
            disabled={
              loading ||
              !image ||
              !patientId.trim()
            }
          >

            {loading
              ? t("analyzing")
              : t("analyzeImage")}

          </button>

        </section>


        {/* ====================================================
            TRIAGE QUEUE
            ==================================================== */}

        <section className="card triage-card">

          <div className="section-heading">

            <div>

              <span className="section-eyebrow">
                CLINICAL WORKFLOW
              </span>

              <h2>
                {t("triageQueue")}
              </h2>

              <p>
                {t("triageDescription")}
              </p>

            </div>


            {triage?.summary && (

              <div className="triage-summary">

                <div>
                  <strong>
                    {triage.summary.total}
                  </strong>
                  <span>Total</span>
                </div>

                <div className="critical">
                  <strong>
                    {triage.summary.critical}
                  </strong>
                  <span>Critical</span>
                </div>

                <div className="high">
                  <strong>
                    {triage.summary.high}
                  </strong>
                  <span>High</span>
                </div>

                <div className="moderate">
                  <strong>
                    {triage.summary.moderate}
                  </strong>
                  <span>Moderate</span>
                </div>

              </div>

            )}

          </div>


          {triageLoading && (

            <div className="loading-inline">
              Loading review queue...
            </div>

          )}


          {triageError && (

            <div className="error-banner">
              {triageError}
            </div>

          )}


          {!triageLoading &&
            !triageError &&
            (!triage?.queue ||
              triage.queue.length === 0) && (

              <div className="empty-state">
                {t("noTriageCases")}
              </div>

            )}


          {triage?.queue?.length > 0 && (

            <div className="triage-list">

              {triage.queue
                .slice(0, 12)
                .map(
                  (caseItem) => {

                    const priority =
                      String(
                        caseItem.triage?.priority ||
                        "ROUTINE"
                      ).toUpperCase();

                    const selected =
                      selectedTriageCase?.screeningId ===
                      caseItem.screeningId;


                    return (

                      <div
                        className={`triage-row ${
                          selected
                            ? "selected"
                            : ""
                        }`}
                        key={
                          String(
                            caseItem.screeningId
                          )
                        }
                      >

                        <div className="triage-main">

                          <div className="triage-patient">

                            <strong>
                              {caseItem.patientId}
                            </strong>

                            <span>
                              Grade{" "}
                              {caseItem.drGrade}
                            </span>

                          </div>


                          <div className="triage-reason">

                            <span
                              className={`priority-badge ${priority.toLowerCase()}`}
                            >
                              {priority}
                            </span>

                            <span>
                              {caseItem.triage?.action ||
                                caseItem.referral?.message ||
                                "Clinical review"}
                            </span>

                          </div>

                        </div>


                        <button
                          className="small-button"
                          onClick={() =>
                            handleTriageCase(
                              caseItem
                            )
                          }
                        >
                          {t("viewCase")} →
                        </button>

                      </div>

                    );
                  }
                )}

            </div>

          )}

        </section>


        {/* ====================================================
            CLINICAL SUMMARY
            ==================================================== */}

        {result && (

          <section className="card clinical-summary">

            <div className="section-heading">

              <div>

                <span className="section-eyebrow">
                  SCREENING RESULT
                </span>

                <h2>
                  {t("clinicalSummary")}
                </h2>

              </div>

              <div
                className={`severity-badge ${currentSeverityClass}`}
              >
                {currentLabel ||
                  getGradeLabel(
                    currentGrade,
                    language
                  )}
              </div>

            </div>


            <div className="metric-grid">


              <div className="metric-card grade-metric">

                <span>
                  {t("drGrade")}
                </span>

                <strong>
                  {currentGrade ??
                    "N/A"}
                </strong>

                <small>
                  {currentLabel ||
                    getGradeLabel(
                      currentGrade,
                      language
                    )}
                </small>

              </div>


              <div className="metric-card">

                <span>
                  {t("severity")}
                </span>

                <strong>
                  {getGradeLabel(
                    currentGrade,
                    language
                  )}
                </strong>

              </div>


              <div className="metric-card">

                <span>
                  {t("imageQuality")}
                </span>

                <strong>

                  {qualityScore !== null
                    ? `${qualityScore.toFixed(
                        0
                      )}/100`
                    : "N/A"}

                </strong>

                <small>

                  {result.isGradeable ===
                  false
                    ? "Review image quality"
                    : "Gradeability check passed"}

                </small>

              </div>


              <div className="metric-card">

                <span>
                  {t("vesselArea")}
                </span>

                <strong>

                  {vesselPercentage !== null
                    ? `${vesselPercentage.toFixed(
                        2
                      )}%`
                    : "N/A"}

                </strong>

                <small>
                  Analyzed vessel pixels
                </small>

              </div>


              <div className="metric-card">

                <span>
                  {t("riskScore")}
                </span>

                <strong>

                  {riskScore !== null
                    ? riskScore.toFixed(
                        2
                      )
                    : "N/A"}

                </strong>

              </div>


              <div
                className={`metric-card referral-metric ${currentSeverityClass}`}
              >

                <span>
                  {t("referral")}
                </span>

                <strong>
                  {getUrgencyLabel(
                    reportPriority,
                    language
                  )}
                </strong>

                <small>
                  {getReferralText(
                    currentGrade,
                    language
                  )}
                </small>

              </div>

            </div>


            <div
              className={`clinical-alert ${currentSeverityClass}`}
            >

              <strong>
                {currentGrade >= 3
                  ? t("urgent")
                  : currentGrade === 2
                    ? t("review")
                    : t("routine")}
              </strong>

              <span>
                {getReferralText(
                  currentGrade,
                  language
                )}
              </span>

            </div>

          </section>

        )}


        {/* ====================================================
            RETINA PASSPORT
            ==================================================== */}

        {(passportPatient ||
          patientId) && (

          <section className="card passport-card">

            <div className="section-heading">

              <div>

                <span className="section-eyebrow">
                  LONGITUDINAL RECORD
                </span>

                <h2>
                  {t("patientPassport")}
                </h2>

              </div>

              <div className="passport-count">

                <strong>
                  {passportCount}
                </strong>

                <span>
                  {t("screenings")}
                </span>

              </div>

            </div>


            <div className="passport-header">

              <div className="passport-avatar">
                {reportPatientName
                  .charAt(0)
                  .toUpperCase()}
              </div>


              <div className="passport-identity">

                <h3>
                  {reportPatientName}
                </h3>

                <span>
                  {reportPatientId}
                </span>

              </div>


              <div className="passport-details">

                <div>
                  <span>
                    {t("age")}
                  </span>
                  <strong>
                    {reportAge}
                  </strong>
                </div>

                <div>
                  <span>
                    {t("gender")}
                  </span>
                  <strong>
                    {reportGender}
                  </strong>
                </div>

                <div>
                  <span>
                    {t("village")}
                  </span>
                  <strong>
                    {reportVillage}
                  </strong>
                </div>

                <div>
                  <span>
                    {t("district")}
                  </span>
                  <strong>
                    {reportDistrict}
                  </strong>
                </div>

              </div>

                     </div>


          {/* DEMO ABHA CARD */}

          <div className="demo-abha-section">

            <div className="demo-abha-header">

              <div>
                <span className="summary-label">
                  DIGITAL HEALTH ID
                </span>

                <strong>
                  ABHA / ABDM Demo Link
                </strong>

                <p>
                  Demonstration-only digital health identity
                  for the Eyeabetics prototype.
                </p>
              </div>

              <button
                type="button"
                className="demo-abha-button"
                onClick={() =>
                  setShowDemoAbha((value) => !value)
                }
              >
                {showDemoAbha
                  ? "Hide Demo Card"
                  : "Generate Demo ABHA Card"}
              </button>

            </div>


            {showDemoAbha && (

              <div className="demo-abha-card">

                <div className="demo-abha-card-top">

                  <div className="demo-abha-logo">
                    ABHA
                  </div>

                  <div className="demo-abha-title">
                    <span>
                      AYUSHMAN BHARAT DIGITAL MISSION
                    </span>

                    <strong>
                      DIGITAL HEALTH ID
                    </strong>
                  </div>

                  <div className="demo-abha-badge">
                    DEMO ONLY
                  </div>

                </div>


                <div className="demo-abha-identity">

                  <div>
                    <span>NAME</span>
                    <strong>
                      {reportPatientName}
                    </strong>
                  </div>

                  <div>
                    <span>DEMO ABHA ID</span>
                   <strong>
  DEMO • 12 34 56 78 90 12 34
</strong>
                  </div>

                </div>


                <div className="demo-abha-details">

                  <div>
                    <span>AGE</span>
                    <strong>{reportAge}</strong>
                  </div>

                  <div>
                    <span>GENDER</span>
                    <strong>{reportGender}</strong>
                  </div>

                  <div>
                    <span>LOCATION</span>
                    <strong>
                      {reportVillage}, {reportDistrict}
                    </strong>
                  </div>

                </div>


                <div className="demo-abha-footer">

                  <span>
                    Eyeabetics • Retina Passport
                  </span>

                  <strong>
                    NOT A REAL ABHA ID
                  </strong>

                </div>

              </div>

            )}

          </div>


          {passportLatest && (

              <div className="latest-screening">

                <div>

                  <span>
                    {t("currentScreening")}
                  </span>

                  <strong>
                    Grade{" "}
                    {passportLatest.drGrade}
                  </strong>

                </div>

                <div>

                  <span>
                    {t("severity")}
                  </span>

                  <strong>
                    {passportLatest.drLabel ||
                      getGradeLabel(
                        passportLatest.drGrade,
                        language
                      )}
                  </strong>

                </div>

                <div>

                  <span>
                    {t("referral")}
                  </span>

                  <strong>
                    {getUrgencyLabel(
                      passportLatest.referral?.urgency ||
                        "ROUTINE",
                      language
                    )}
                  </strong>

                </div>

                <div>

                  <span>
                    Date
                  </span>

                  <strong>
                    {formatReportDate(
                      passportLatest.screenedAt
                    )}
                  </strong>

                </div>

              </div>

            )}
                         


          {/* ====================================================
              OFFLINE WHATSAPP STORE & FORWARD
              ==================================================== */}

          <div className="offline-referral-panel">

            <div className="offline-referral-info">

              <span className="offline-status-dot"></span>

              <div>
                <strong>
                  Offline Referral
                </strong>

                <p>
                  Queue this referral for WhatsApp sync
                  when connectivity is restored.
                </p>
              </div>

            </div>

            <button
              type="button"
              className="offline-referral-button"
              onClick={() => {

                const referral =
                  createOfflineReferral(
                    result,
                    reportPatientName,
                    reportPatientId
                  )

                setOfflineReferral(referral)

              }}
              disabled={!result}
            >
              Queue WhatsApp Referral
            </button>

          </div>


          {offlineReferral && (

            <div className="offline-referral-queued">

              <div className="queued-header">

                <div>

                  <span className="section-eyebrow">
                    STORE & FORWARD
                  </span>

                  <h3>
                    WhatsApp Referral Queued
                  </h3>

                </div>

                <span className="queued-badge">
                  {offlineReferral.status}
                </span>

              </div>

              <div className="queued-details">

                <div>
                  <span>Patient</span>
                  <strong>
                    {offlineReferral.patientName}
                  </strong>
                </div>

                <div>
                  <span>Priority</span>
                  <strong>
                    {offlineReferral.urgency}
                  </strong>
                </div>

                <div>
                  <span>Referral ID</span>
                  <strong>
                    {offlineReferral.id}
                  </strong>
                </div>

              </div>

              <pre className="whatsapp-preview">
                {offlineReferral.message}
              </pre>

              <div className="offline-sync-note">
                ✓ Stored locally • Ready for sync when connectivity returns
              </div>

            </div>

          )}


          <div className="history-title">
            {t("screeningHistory")}
          </div>


            {passportHistory.length ===
            0 ? (

              <div className="empty-state">
                {t("noHistory")}
              </div>

            ) : (

              <div className="history-table">

                {passportHistory
                  .map(
                    (
                      screening,
                      index
                    ) => (

                      <div
                        className="history-row"
                        key={
                          String(
                            screening._id ||
                            screening.screeningId ||
                            index
                          )
                        }
                      >

                        <div>

                          <span>
                            {formatReportDate(
                              screening.screenedAt
                            )}
                          </span>

                        </div>


                        <div>

                          <span>
                            {t("drGrade")}
                          </span>

                          <strong>
                            Grade{" "}
                            {screening.drGrade}
                          </strong>

                        </div>


                        <div>

                          <span>
                            {t("severity")}
                          </span>

                          <strong>
                            {screening.drLabel ||
                              getGradeLabel(
                                screening.drGrade,
                                language
                              )}
                          </strong>

                        </div>


                        <div>

                          <span>
                            {t("riskScore")}
                          </span>

                          <strong>
                            {numberOrNull(
                              screening.riskScore
                            ) !== null
                              ? Number(
                                  screening.riskScore
                                ).toFixed(2)
                              : "N/A"}
                          </strong>

                        </div>


                        <div>

                          <span>
                            {t("referral")}
                          </span>

                          <strong>
                            {String(
                              screening.referral?.urgency ||
                              "ROUTINE"
                            ).toUpperCase()}
                          </strong>

                        </div>

                      </div>

                    )
                  )}

              </div>

            )}

          </section>

        )}


        {/* ====================================================
            VISUAL EVIDENCE
            ==================================================== */}

        {result && (

          <section className="card evidence-card">

            <div className="section-heading">

              <div>

                <span className="section-eyebrow">
                  MULTIMODAL EVIDENCE
                </span>

                <h2>
                  {t("visualEvidence")}
                </h2>

              </div>

            </div>


            <div className="image-evidence-grid">


              <div className="evidence-image-card">

                <div className="evidence-image-header">

                  <strong>
                    {t("originalFundus")}
                  </strong>

                </div>


                <div className="evidence-image">

                  {preview ? (

                    <img
                      src={
                        preview
                      }
                      alt="Original retinal fundus"
                    />

                  ) : originalResultImage ? (

                    <img
                      src={
                        originalResultImage
                      }
                      alt="Original retinal fundus"
                    />

                  ) : (

                    <div className="empty-preview">
                      No image available
                    </div>

                  )}

                </div>

              </div>


              <div className="evidence-image-card">

                <div className="evidence-image-header">

                  <strong>
                    {t("structuralOverlay")}
                  </strong>

                  <span>
                    Lesions + vessels
                  </span>

                </div>


                <div className="evidence-image">

                  {overlayUrl ? (

                    <img
                      src={
                        overlayUrl
                      }
                      alt="Structural retinal analysis overlay"
                    />

                  ) : (

                    <div className="empty-preview">
                      Structural overlay unavailable
                    </div>

                  )}

                </div>

              </div>

            </div>

          </section>

        )}


        {/* ====================================================
            AI EVIDENCE SUMMARY
            ==================================================== */}

        {result && (

          <section className="card ai-evidence-card">

            <div className="section-heading">

              <div>

                <span className="section-eyebrow">
                  EVIDENCE LAYER
                </span>

                <h2>
                  {t("aiEvidence")}
                </h2>

              </div>

            </div>


            <div className="evidence-disclaimer">

              {evidence?.disclaimer ||
                t("evidenceDisclaimer")}

            </div>


            {evidence?.escalation && (

              <div
                className={`evidence-escalation ${currentSeverityClass}`}
              >

                {evidence.escalation}

              </div>

            )}


            <div className="evidence-findings">

              {(evidence?.findings ||
                []).map(
                  (
                    finding,
                    index
                  ) => (

                    <div
                      className={`finding-card finding-${finding.type}`}
                      key={
                        `${finding.type}-${index}`
                      }
                    >

                      <div className="finding-icon">

                        {finding.type ===
                        "classification"
                          ? "◉"
                          : finding.type ===
                              "lesion"
                            ? "✦"
                            : finding.type ===
                                "vascular"
                              ? "⌁"
                              : finding.type ===
                                  "quality"
                                ? "✓"
                                : "!"}

                      </div>


                      <div className="finding-content">

                        <span>
                          {finding.title}
                        </span>

                        <strong>
                          {finding.value}
                        </strong>

                        <p>
                          {finding.detail}
                        </p>


                        {finding.classes?.length >
                          0 && (

                          <div className="lesion-class-list">

                            {finding.classes.map(
                              (
                                lesion,
                                lesionIndex
                              ) => (

                                <div
                                  className="lesion-class-item"
                                  key={
                                    `${lesion.className}-${lesionIndex}`
                                  }
                                >

                                  <span>
                                    {getLesionName(
                                      lesion.className
                                    )}
                                  </span>

                                  <strong>
                                    {Number(
                                      lesion.pixels
                                    ).toLocaleString()}
                                  </strong>

                                </div>

                              )
                            )}

                          </div>

                        )}

                      </div>

                    </div>

                  )
                )}

            </div>


            {lesionEntries.length > 0 && (

              <div className="lesion-note">

                <strong>
                  Lesion output:
                </strong>{" "}

                The current prototype reports generic
                segmentation classes. Their exact
                semantic mapping should be verified
                against the deployed model configuration
                before assigning clinical lesion names.

              </div>

            )}

          </section>

        )}


        {/* ====================================================
            PROGRESSION
            ==================================================== */}

        {patientId && (

          <section className="card progression-card">

            <div className="section-heading">

              <div>

                <span className="section-eyebrow">
                  LONGITUDINAL ANALYSIS
                </span>

                <h2>
                  {t("progression")}
                </h2>

                <p>
                  {t("progressionDescription")}
                </p>

              </div>

              {progression?.available && (

                <div
                  className={`progression-badge ${getProgressionClass(
                    progression
                  )}`}
                >
                  {String(
                    progression.progression?.priority ||
                    "ROUTINE"
                  ).toUpperCase()}
                </div>

              )}

            </div>


            {progressionLoading && (

              <div className="loading-inline">
                Loading progression...
              </div>

            )}


            {!progressionLoading &&
              !progression?.available && (

                <div className="progression-empty">

                  <strong>
                    {currentGrade !== null
                      ? `Current screening: Grade ${currentGrade}`
                      : "Current screening available"}
                  </strong>

                  <span>
                    A previous screening is required
                    for longitudinal comparison.
                  </span>

                </div>

              )}


            {!progressionLoading &&
              progression?.available && (

                <>

                  <div className="progression-grid">

                    <div className="progression-box">

                      <span>
                        {t("previousGrade")}
                      </span>

                      <strong>
                        Grade{" "}
                        {
                          progression.previous
                            ?.drGrade
                        }
                      </strong>

                      <small>
                        {
                          progression.previous
                            ?.drLabel ||
                          getGradeLabel(
                            progression.previous
                              ?.drGrade,
                            language
                          )
                        }
                      </small>

                    </div>


                    <div className="progression-arrow">
                      →
                    </div>


                    <div className="progression-box current">

                      <span>
                        {t("currentGrade")}
                      </span>

                      <strong>
                        Grade{" "}
                        {
                          progression.current
                            ?.drGrade
                        }
                      </strong>

                      <small>
                        {
                          progression.current
                            ?.drLabel ||
                          getGradeLabel(
                            progression.current
                              ?.drGrade,
                            language
                          )
                        }
                      </small>

                    </div>


                    <div className="progression-change">

                      <span>
                        {t("gradeChange")}
                      </span>

                      <strong>
                        {progression.changes
                          ?.drGrade >= 0
                          ? "+"
                          : ""}
                        {
                          progression.changes
                            ?.drGrade ??
                          0
                        }
                      </strong>

                    </div>

                  </div>


                  <div
                    className={`progression-status ${getProgressionClass(
                      progression
                    )}`}
                  >

                    <div>

                      <span>
                        {t("progressionStatus")}
                      </span>

                      <strong>
                        {
                          progression.progression
                            ?.status ||
                          "Stable"
                        }
                      </strong>

                    </div>


                    <div>

                      <span>
                        {t("progressionPriority")}
                      </span>

                      <strong>
                        {
                          progression.progression
                            ?.priority ||
                          "ROUTINE"
                        }
                      </strong>

                    </div>

                  </div>

                </>

              )}

          </section>

        )}


        {/* ====================================================
            FURTHER DETAILS
            ==================================================== */}

        {result && (

          <section className="card collapsible-card">

            <button
              className="collapse-header"
              onClick={() =>
                setShowDetails(
                  !showDetails
                )
              }
            >

              <span>
                {t("furtherDetails")}
              </span>

              <span>
                {showDetails
                  ? "−"
                  : "+"}
              </span>

            </button>


            {showDetails && (

              <div className="collapse-content">

                <div className="detail-grid">

                  <div>

                    <span>
                      DR Grade
                    </span>

                    <strong>
                      {currentGrade}
                    </strong>

                  </div>


                  <div>

                    <span>
                      DR Label
                    </span>

                    <strong>
                      {result.drLabel ||
                        currentLabel}
                    </strong>

                  </div>


                  <div>

                    <span>
                      Quality Score
                    </span>

                    <strong>
                      {qualityScore !== null
                        ? `${qualityScore.toFixed(
                            0
                          )}/100`
                        : "N/A"}
                    </strong>

                  </div>


                  <div>

                    <span>
                      Gradeable
                    </span>

                    <strong>
                      {result.isGradeable ===
                      false
                        ? "No"
                        : "Yes"}
                    </strong>

                  </div>


                  <div>

                    <span>
                      Vessel Area
                    </span>

                    <strong>
                      {vesselPercentage !== null
                        ? `${vesselPercentage.toFixed(
                            2
                          )}%`
                        : "N/A"}
                    </strong>

                  </div>


                  <div>

                    <span>
                      Risk
                    </span>

                    <strong>
                      {riskScore !== null
                        ? riskScore.toFixed(
                            2
                          )
                        : "N/A"}
                    </strong>

                  </div>


                  <div>

                    <span>
                      Referral Urgency
                    </span>

                    <strong>
                      {
                        result.referral
                          ?.urgency ||
                        "ROUTINE"
                      }
                    </strong>

                  </div>


                  <div>

                    <span>
                      Referral Timeframe
                    </span>

                    <strong>
                      {
                        result.referral
                          ?.timeframe ||
                        "N/A"
                      }
                    </strong>

                  </div>

                </div>

              </div>

            )}

          </section>

        )}


        {/* ====================================================
            TECHNICAL DETAILS
            ==================================================== */}

        {result && (

          <section className="card collapsible-card">

            <button
              className="collapse-header"
              onClick={() =>
                setShowTechnical(
                  !showTechnical
                )
              }
            >

              <span>
                {t("technicalDetails")}
              </span>

              <span>
                {showTechnical
                  ? "−"
                  : "+"}
              </span>

            </button>


            {showTechnical && (

              <div className="collapse-content">

                <div className="technical-grid">

                  <div>

                    <span>
                      DR Classifier
                    </span>

                    <strong>
                      EfficientNet-B0
                    </strong>

                  </div>


                  <div>

                    <span>
                      DR Classes
                    </span>

                    <strong>
                      Grade 0–4
                    </strong>

                  </div>


                  <div>

                    <span>
                      Lesion Model
                    </span>

                    <strong>
                      U-Net
                    </strong>

                  </div>


                  <div>

                    <span>
                      Vessel Model
                    </span>

                    <strong>
                      U-Net
                    </strong>

                  </div>


                  <div>

                    <span>
                      Inference Engine
                    </span>

                    <strong>
                      MATLAB R2026a
                    </strong>

                  </div>


                  <div>

                    <span>
                      Backend
                    </span>

                    <strong>
                      Node.js
                    </strong>

                  </div>


                  <div>

                    <span>
                      Database
                    </span>

                    <strong>
                      MongoDB
                    </strong>

                  </div>


                  <div>

                    <span>
                      Frontend
                    </span>

                    <strong>
                      React + Vite
                    </strong>

                  </div>

                </div>

              </div>

            )}

          </section>

        )}


        {/* ====================================================
            DISCLAIMER
            ==================================================== */}

        <section className="disclaimer-card">

          <div className="disclaimer-icon">
            !
          </div>

          <div>

            <strong>
              {t("disclaimerTitle")}
            </strong>

            <p>
              {t("disclaimer")}
            </p>

          </div>

        </section>


      </main>


      {/* ======================================================
          FOOTER
          ====================================================== */}

      <footer className="footer">

        <span>
          EYEABETICS • AI-Assisted Retinal Screening
        </span>

        <span>
          Research Prototype • Clinical Review Required
        </span>

      </footer>

    </div>
  );
}


export default App;