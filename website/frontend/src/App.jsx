import { useState } from 'react'
import './App.css'

const translations = {
  English: {
    analysisWorkspace: 'ANALYSIS WORKSPACE',
    fundusAnalysis: 'Fundus Image Analysis',
    livePipeline: 'LIVE PIPELINE',
    uploadTitle: 'Upload fundus image',
    uploadText: 'JPG or PNG retinal image',
    chooseImage: 'Choose Image',
    imageReady: 'IMAGE READY',
    analyze: 'Analyze Retina →',
    analyzing: 'Analyzing...',
    analysisComplete: 'ANALYSIS COMPLETE',
    retinalResults: 'Retinal Analysis Results',
    complete: '● COMPLETE',
    original: 'ORIGINAL FUNDUS',
    structural: 'STRUCTURAL ANALYSIS',
    drGrade: 'DR GRADE',
    confidence: 'CONFIDENCE',
    riskScore: 'RISK SCORE',
    vesselArea: 'VESSEL AREA',
    lesionFindings: 'LESION FINDINGS',
    recommendation: 'RECOMMENDATION',
    quality: 'IMAGE QUALITY',
    model: 'MODEL',
    status: 'STATUS',
    analysisDone: 'Analysis Complete',
    lesionModel: '4-Class U-Net',
    language: 'Language',
    noLesions: 'No lesion classes detected',
    classLabel: 'Lesion Class',
    pixels: 'pixels',

    disclaimer:
      'AI-assisted screening prototype. Results should be reviewed by a qualified ophthalmologist.',

    footer:
      'AI-assisted retinal analysis • Research prototype',

    engineReady: 'MATLAB AI Engine Ready',

    retinalIntelligence: 'RETINAL INTELLIGENCE',

    heroTitle1: 'Understand the eye',
    heroTitle2: 'through AI.',

    heroText:
      'Upload a fundus image and let the Eyeabetics pipeline analyze diabetic retinopathy, retinal lesion patterns, and vascular structure using trained deep-learning models.',

    aiScreening: 'AI RETINAL SCREENING',

    readyText:
      'Ready to send through the complete Eyeabetics AI analysis pipeline.',

    loadingDetails:
      'DR classification, lesion segmentation, vessel segmentation and risk analysis are running.',

    qualityWarning:
      'The image may not be suitable for reliable analysis.',

    noVisualization: 'No visualization available',

    clinicalReview: 'Clinical review recommended.',

    lowConfidence: 'LOW CONFIDENCE - Human Review Recommended',

    grade0: '0 - No DR',
    grade1: '1 - Mild',
    grade2: '2 - Moderate',
    grade3: '3 - Severe',
    grade4: '4 - Proliferative',

    urgencyLow: 'Low Risk',
    urgencyModerate: 'Moderate Risk',
    urgencyHigh: 'High Risk',

    referralRoutine:
      'Routine ophthalmic monitoring recommended.',

    referral4Weeks:
      'Refer within 4 weeks',

    referralUrgent:
      'Urgent ophthalmology review recommended.',

    errorAnalysis: 'Analysis failed'
  },

  Hindi: {
    analysisWorkspace: 'विश्लेषण कार्यक्षेत्र',
    fundusAnalysis: 'फंडस इमेज विश्लेषण',
    livePipeline: 'लाइव पाइपलाइन',
    uploadTitle: 'फंडस इमेज अपलोड करें',
    uploadText: 'JPG या PNG रेटिनल इमेज',
    chooseImage: 'इमेज चुनें',
    imageReady: 'इमेज तैयार',
    analyze: 'रेटिना का विश्लेषण करें →',
    analyzing: 'विश्लेषण हो रहा है...',
    analysisComplete: 'विश्लेषण पूरा',
    retinalResults: 'रेटिनल विश्लेषण परिणाम',
    complete: '● पूरा',
    original: 'मूल फंडस',
    structural: 'संरचनात्मक विश्लेषण',
    drGrade: 'DR ग्रेड',
    confidence: 'विश्वास स्तर',
    riskScore: 'जोखिम स्कोर',
    vesselArea: 'रक्त वाहिका क्षेत्र',
    lesionFindings: 'घाव के परिणाम',
    recommendation: 'सुझाव',
    quality: 'इमेज गुणवत्ता',
    model: 'मॉडल',
    status: 'स्थिति',
    analysisDone: 'विश्लेषण पूरा',
    lesionModel: '4-क्लास U-Net',
    language: 'भाषा',
    noLesions: 'कोई घाव क्लास नहीं मिली',
    classLabel: 'घाव क्लास',
    pixels: 'पिक्सेल',

    disclaimer:
      'AI-सहायता प्राप्त स्क्रीनिंग प्रोटोटाइप। परिणामों की समीक्षा योग्य नेत्र विशेषज्ञ द्वारा की जानी चाहिए।',

    footer:
      'AI-सहायता प्राप्त रेटिनल विश्लेषण • रिसर्च प्रोटोटाइप',

    engineReady: 'MATLAB AI इंजन तैयार',

    retinalIntelligence: 'रेटिनल इंटेलिजेंस',

    heroTitle1: 'AI के माध्यम से',
    heroTitle2: 'आंख को समझें।',

    heroText:
      'फंडस इमेज अपलोड करें और Eyeabetics पाइपलाइन को डायबिटिक रेटिनोपैथी, रेटिनल घावों तथा रक्त वाहिकाओं की संरचना का विश्लेषण करने दें।',

    aiScreening: 'AI रेटिनल स्क्रीनिंग',

    readyText:
      'पूरे Eyeabetics AI विश्लेषण पाइपलाइन के लिए इमेज तैयार है।',

    loadingDetails:
      'DR वर्गीकरण, घाव विभाजन, रक्त वाहिका विभाजन और जोखिम विश्लेषण चल रहा है।',

    qualityWarning:
      'यह इमेज विश्वसनीय विश्लेषण के लिए उपयुक्त नहीं हो सकती।',

    noVisualization: 'कोई विज़ुअलाइज़ेशन उपलब्ध नहीं है',

    clinicalReview:
      'चिकित्सकीय समीक्षा की सलाह दी जाती है।',

    lowConfidence:
      'कम विश्वास स्तर - मानव विशेषज्ञ द्वारा समीक्षा आवश्यक',

    grade0: '0 - DR नहीं',
    grade1: '1 - हल्का',
    grade2: '2 - मध्यम',
    grade3: '3 - गंभीर',
    grade4: '4 - प्रोलिफेरेटिव',

    urgencyLow: 'कम जोखिम',
    urgencyModerate: 'मध्यम जोखिम',
    urgencyHigh: 'उच्च जोखिम',

    referralRoutine:
      'नियमित नेत्र जांच की सलाह दी जाती है।',

    referral4Weeks:
      '4 सप्ताह के भीतर विशेषज्ञ से परामर्श लें',

    referralUrgent:
      'तत्काल नेत्र विशेषज्ञ समीक्षा की सलाह दी जाती है।',

    errorAnalysis: 'विश्लेषण विफल हुआ'
  },

  Odia: {
    analysisWorkspace: 'ବିଶ୍ଳେଷଣ କାର୍ଯ୍ୟକ୍ଷେତ୍ର',
    fundusAnalysis: 'ଫଣ୍ଡସ୍ ଚିତ୍ର ବିଶ୍ଳେଷଣ',
    livePipeline: 'ଲାଇଭ୍ ପାଇପଲାଇନ୍',
    uploadTitle: 'ଫଣ୍ଡସ୍ ଚିତ୍ର ଅପଲୋଡ୍ କରନ୍ତୁ',
    uploadText: 'JPG କିମ୍ବା PNG ରେଟିନାଲ୍ ଚିତ୍ର',
    chooseImage: 'ଚିତ୍ର ବାଛନ୍ତୁ',
    imageReady: 'ଚିତ୍ର ପ୍ରସ୍ତୁତ',
    analyze: 'ରେଟିନା ବିଶ୍ଳେଷଣ କରନ୍ତୁ →',
    analyzing: 'ବିଶ୍ଳେଷଣ ଚାଲିଛି...',
    analysisComplete: 'ବିଶ୍ଳେଷଣ ସମ୍ପୂର୍ଣ୍ଣ',
    retinalResults: 'ରେଟିନାଲ୍ ବିଶ୍ଳେଷଣ ଫଳାଫଳ',
    complete: '● ସମ୍ପୂର୍ଣ୍ଣ',
    original: 'ମୂଳ ଫଣ୍ଡସ୍',
    structural: 'ଗଠନାତ୍ମକ ବିଶ୍ଳେଷଣ',
    drGrade: 'DR ଗ୍ରେଡ୍',
    confidence: 'ବିଶ୍ୱାସ ସ୍ତର',
    riskScore: 'ବିପଦ ସ୍କୋର',
    vesselArea: 'ରକ୍ତନଳୀ କ୍ଷେତ୍ର',
    lesionFindings: 'ଲେସନ୍ ଫଳାଫଳ',
    recommendation: 'ପରାମର୍ଶ',
    quality: 'ଚିତ୍ର ଗୁଣବତ୍ତା',
    model: 'ମଡେଲ୍',
    status: 'ସ୍ଥିତି',
    analysisDone: 'ବିଶ୍ଳେଷଣ ସମ୍ପୂର୍ଣ୍ଣ',
    lesionModel: '4-କ୍ଲାସ୍ U-Net',
    language: 'ଭାଷା',
    noLesions: 'କୌଣସି ଲେସନ୍ କ୍ଲାସ୍ ଚିହ୍ନଟ ହୋଇନାହିଁ',
    classLabel: 'ଲେସନ୍ କ୍ଲାସ୍',
    pixels: 'ପିକ୍ସେଲ୍',

    disclaimer:
      'AI-ସହାୟିତ ସ୍କ୍ରିନିଂ ପ୍ରୋଟୋଟାଇପ୍। ଫଳାଫଳକୁ ଜଣେ ଯୋଗ୍ୟ ଚକ୍ଷୁ ବିଶେଷଜ୍ଞ ସମୀକ୍ଷା କରିବା ଉଚିତ।',

    footer:
      'AI-ସହାୟିତ ରେଟିନାଲ୍ ବିଶ୍ଳେଷଣ • ଗବେଷଣା ପ୍ରୋଟୋଟାଇପ୍',

    engineReady: 'MATLAB AI ଇଞ୍ଜିନ୍ ପ୍ରସ୍ତୁତ',

    retinalIntelligence: 'ରେଟିନାଲ୍ ଇଣ୍ଟେଲିଜେନ୍ସ',

    heroTitle1: 'AI ମାଧ୍ୟମରେ',
    heroTitle2: 'ଆଖିକୁ ବୁଝନ୍ତୁ।',

    heroText:
      'ଫଣ୍ଡସ୍ ଚିତ୍ର ଅପଲୋଡ୍ କରନ୍ତୁ ଏବଂ Eyeabetics ପାଇପଲାଇନ୍ ଦ୍ୱାରା ଡାଏବେଟିକ୍ ରେଟିନୋପାଥି, ରେଟିନାଲ୍ ଲେସନ୍ ଏବଂ ରକ୍ତନଳୀ ଗଠନର ବିଶ୍ଳେଷଣ କରନ୍ତୁ।',

    aiScreening: 'AI ରେଟିନାଲ୍ ସ୍କ୍ରିନିଂ',

    readyText:
      'ସମ୍ପୂର୍ଣ୍ଣ Eyeabetics AI ବିଶ୍ଳେଷଣ ପାଇପଲାଇନ୍ ପାଇଁ ଚିତ୍ର ପ୍ରସ୍ତୁତ।',

    loadingDetails:
      'DR ବର୍ଗୀକରଣ, ଲେସନ୍ ସେଗମେଣ୍ଟେସନ୍, ରକ୍ତନଳୀ ସେଗମେଣ୍ଟେସନ୍ ଏବଂ ବିପଦ ବିଶ୍ଳେଷଣ ଚାଲିଛି।',

    qualityWarning:
      'ବିଶ୍ୱସନୀୟ ବିଶ୍ଳେଷଣ ପାଇଁ ଏହି ଚିତ୍ର ଉପଯୁକ୍ତ ନ ହୋଇପାରେ।',

    noVisualization:
      'କୌଣସି ଭିଜୁଆଲାଇଜେସନ୍ ଉପଲବ୍ଧ ନାହିଁ',

    clinicalReview:
      'ଚିକିତ୍ସା ବିଶେଷଜ୍ଞଙ୍କ ସମୀକ୍ଷାର ପରାମର୍ଶ ଦିଆଯାଉଛି।',

    lowConfidence:
      'କମ୍ ବିଶ୍ୱାସ ସ୍ତର - ମାନବ ବିଶେଷଜ୍ଞଙ୍କ ସମୀକ୍ଷା ଆବଶ୍ୟକ',

    grade0: '0 - DR ନାହିଁ',
    grade1: '1 - ହାଲୁକା',
    grade2: '2 - ମଧ୍ୟମ',
    grade3: '3 - ଗୁରୁତର',
    grade4: '4 - ପ୍ରୋଲିଫେରେଟିଭ୍',

    urgencyLow: 'କମ୍ ବିପଦ',
    urgencyModerate: 'ମଧ୍ୟମ ବିପଦ',
    urgencyHigh: 'ଉଚ୍ଚ ବିପଦ',

    referralRoutine:
      'ନିୟମିତ ଚକ୍ଷୁ ପରୀକ୍ଷାର ପରାମର୍ଶ ଦିଆଯାଉଛି।',

    referral4Weeks:
      '4 ସପ୍ତାହ ମଧ୍ୟରେ ବିଶେଷଜ୍ଞଙ୍କ ସହ ପରାମର୍ଶ କରନ୍ତୁ',

    referralUrgent:
      'ତୁରନ୍ତ ଚକ୍ଷୁ ବିଶେଷଜ୍ଞଙ୍କ ସମୀକ୍ଷାର ପରାମର୍ଶ ଦିଆଯାଉଛି।',

    errorAnalysis: 'ବିଶ୍ଳେଷଣ ବିଫଳ ହେଲା'
  },

  Bengali: {
    analysisWorkspace: 'বিশ্লেষণ কর্মক্ষেত্র',
    fundusAnalysis: 'ফান্ডাস ইমেজ বিশ্লেষণ',
    livePipeline: 'লাইভ পাইপলাইন',
    uploadTitle: 'ফান্ডাস ইমেজ আপলোড করুন',
    uploadText: 'JPG বা PNG রেটিনাল ইমেজ',
    chooseImage: 'ইমেজ নির্বাচন করুন',
    imageReady: 'ইমেজ প্রস্তুত',
    analyze: 'রেটিনা বিশ্লেষণ করুন →',
    analyzing: 'বিশ্লেষণ চলছে...',
    analysisComplete: 'বিশ্লেষণ সম্পূর্ণ',
    retinalResults: 'রেটিনাল বিশ্লেষণের ফলাফল',
    complete: '● সম্পূর্ণ',
    original: 'মূল ফান্ডাস',
    structural: 'গঠনগত বিশ্লেষণ',
    drGrade: 'DR গ্রেড',
    confidence: 'বিশ্বাসযোগ্যতা',
    riskScore: 'ঝুঁকি স্কোর',
    vesselArea: 'রক্তনালীর এলাকা',
    lesionFindings: 'লেশন ফলাফল',
    recommendation: 'পরামর্শ',
    quality: 'ইমেজের গুণমান',
    model: 'মডেল',
    status: 'অবস্থা',
    analysisDone: 'বিশ্লেষণ সম্পূর্ণ',
    lesionModel: '4-ক্লাস U-Net',
    language: 'ভাষা',
    noLesions: 'কোনও লেশন ক্লাস শনাক্ত হয়নি',
    classLabel: 'লেশন ক্লাস',
    pixels: 'পিক্সেল',

    disclaimer:
      'AI-সহায়িত স্ক্রিনিং প্রোটোটাইপ। ফলাফল একজন যোগ্য চক্ষু বিশেষজ্ঞের দ্বারা পর্যালোচনা করা উচিত।',

    footer:
      'AI-সহায়িত রেটিনাল বিশ্লেষণ • গবেষণা প্রোটোটাইপ',

    engineReady: 'MATLAB AI ইঞ্জিন প্রস্তুত',

    retinalIntelligence: 'রেটিনাল ইন্টেলিজেন্স',

    heroTitle1: 'AI-এর মাধ্যমে',
    heroTitle2: 'চোখকে বুঝুন।',

    heroText:
      'ফান্ডাস ইমেজ আপলোড করুন এবং Eyeabetics পাইপলাইনকে ডায়াবেটিক রেটিনোপ্যাথি, রেটিনাল লেশন ও রক্তনালীর গঠন বিশ্লেষণ করতে দিন।',

    aiScreening: 'AI রেটিনাল স্ক্রিনিং',

    readyText:
      'সম্পূর্ণ Eyeabetics AI বিশ্লেষণ পাইপলাইনের জন্য ইমেজ প্রস্তুত।',

    loadingDetails:
      'DR শ্রেণিবিন্যাস, লেশন সেগমেন্টেশন, রক্তনালী সেগমেন্টেশন এবং ঝুঁকি বিশ্লেষণ চলছে।',

    qualityWarning:
      'নির্ভরযোগ্য বিশ্লেষণের জন্য এই ইমেজটি উপযুক্ত নাও হতে পারে।',

    noVisualization:
      'কোনও ভিজ্যুয়ালাইজেশন উপলব্ধ নেই',

    clinicalReview:
      'চিকিৎসা বিশেষজ্ঞের পর্যালোচনা সুপারিশ করা হচ্ছে।',

    lowConfidence:
      'কম বিশ্বাসযোগ্যতা - মানব বিশেষজ্ঞের পর্যালোচনা প্রয়োজন',

    grade0: '0 - DR নেই',
    grade1: '1 - মৃদু',
    grade2: '2 - মাঝারি',
    grade3: '3 - গুরুতর',
    grade4: '4 - প্রোলিফারেটিভ',

    urgencyLow: 'কম ঝুঁকি',
    urgencyModerate: 'মাঝারি ঝুঁকি',
    urgencyHigh: 'উচ্চ ঝুঁকি',

    referralRoutine:
      'নিয়মিত চক্ষু পরীক্ষা করার পরামর্শ দেওয়া হচ্ছে।',

    referral4Weeks:
      '4 সপ্তাহের মধ্যে বিশেষজ্ঞের পরামর্শ নিন',

    referralUrgent:
      'জরুরি চক্ষু বিশেষজ্ঞের পর্যালোচনা করার পরামর্শ দেওয়া হচ্ছে।',

    errorAnalysis: 'বিশ্লেষণ ব্যর্থ হয়েছে'
  },

  Kannada: {
    analysisWorkspace: 'ವಿಶ್ಲೇಷಣಾ ಕಾರ್ಯಕ್ಷೇತ್ರ',
    fundusAnalysis: 'ಫಂಡಸ್ ಚಿತ್ರ ವಿಶ್ಲೇಷಣೆ',
    livePipeline: 'ಲೈವ್ ಪೈಪ್‌ಲೈನ್',
    uploadTitle: 'ಫಂಡಸ್ ಚಿತ್ರವನ್ನು ಅಪ್‌ಲೋಡ್ ಮಾಡಿ',
    uploadText: 'JPG ಅಥವಾ PNG ರೆಟಿನಲ್ ಚಿತ್ರ',
    chooseImage: 'ಚಿತ್ರ ಆಯ್ಕೆಮಾಡಿ',
    imageReady: 'ಚಿತ್ರ ಸಿದ್ಧವಾಗಿದೆ',
    analyze: 'ರೆಟಿನಾ ವಿಶ್ಲೇಷಿಸಿ →',
    analyzing: 'ವಿಶ್ಲೇಷಣೆ ನಡೆಯುತ್ತಿದೆ...',
    analysisComplete: 'ವಿಶ್ಲೇಷಣೆ ಪೂರ್ಣಗೊಂಡಿದೆ',
    retinalResults: 'ರೆಟಿನಲ್ ವಿಶ್ಲೇಷಣೆಯ ಫಲಿತಾಂಶಗಳು',
    complete: '● ಪೂರ್ಣ',
    original: 'ಮೂಲ ಫಂಡಸ್',
    structural: 'ರಚನಾತ್ಮಕ ವಿಶ್ಲೇಷಣೆ',
    drGrade: 'DR ಗ್ರೇಡ್',
    confidence: 'ವಿಶ್ವಾಸ ಮಟ್ಟ',
    riskScore: 'ಅಪಾಯ ಸ್ಕೋರ್',
    vesselArea: 'ರಕ್ತನಾಳ ಪ್ರದೇಶ',
    lesionFindings: 'ಲೆಷನ್ ಫಲಿತಾಂಶಗಳು',
    recommendation: 'ಶಿಫಾರಸು',
    quality: 'ಚಿತ್ರ ಗುಣಮಟ್ಟ',
    model: 'ಮಾದರಿ',
    status: 'ಸ್ಥಿತಿ',
    analysisDone: 'ವಿಶ್ಲೇಷಣೆ ಪೂರ್ಣ',
    lesionModel: '4-ಕ್ಲಾಸ್ U-Net',
    language: 'ಭಾಷೆ',
    noLesions: 'ಯಾವುದೇ ಲೆಷನ್ ಕ್ಲಾಸ್ ಪತ್ತೆಯಾಗಿಲ್ಲ',
    classLabel: 'ಲೆಷನ್ ಕ್ಲಾಸ್',
    pixels: 'ಪಿಕ್ಸೆಲ್‌ಗಳು',

    disclaimer:
      'AI-ಸಹಾಯಿತ ಸ್ಕ್ರೀನಿಂಗ್ ಪ್ರೋಟೋಟೈಪ್. ಫಲಿತಾಂಶಗಳನ್ನು ಅರ್ಹ ನೇತ್ರ ತಜ್ಞರು ಪರಿಶೀಲಿಸಬೇಕು.',

    footer:
      'AI-ಸಹಾಯಿತ ರೆಟಿನಲ್ ವಿಶ್ಲೇಷಣೆ • ಸಂಶೋಧನಾ ಪ್ರೋಟೋಟೈಪ್',

    engineReady: 'MATLAB AI ಎಂಜಿನ್ ಸಿದ್ಧವಾಗಿದೆ',

    retinalIntelligence: 'ರೆಟಿನಲ್ ಇಂಟೆಲಿಜೆನ್ಸ್',

    heroTitle1: 'AI ಮೂಲಕ',
    heroTitle2: 'ಕಣ್ಣನ್ನು ಅರ್ಥಮಾಡಿಕೊಳ್ಳಿ.',

    heroText:
      'ಫಂಡಸ್ ಚಿತ್ರವನ್ನು ಅಪ್‌ಲೋಡ್ ಮಾಡಿ ಮತ್ತು Eyeabetics ಪೈಪ್‌ಲೈನ್ ಡಯಾಬೆಟಿಕ್ ರೆಟಿನೋಪತಿ, ರೆಟಿನಲ್ ಲೆಷನ್‌ಗಳು ಮತ್ತು ರಕ್ತನಾಳಗಳ ರಚನೆಯನ್ನು ವಿಶ್ಲೇಷಿಸಲು ಅವಕಾಶ ನೀಡಿ.',

    aiScreening: 'AI ರೆಟಿನಲ್ ಸ್ಕ್ರೀನಿಂಗ್',

    readyText:
      'ಸಂಪೂರ್ಣ Eyeabetics AI ವಿಶ್ಲೇಷಣಾ ಪೈಪ್‌ಲೈನ್‌ಗೆ ಚಿತ್ರ ಸಿದ್ಧವಾಗಿದೆ.',

    loadingDetails:
      'DR ವರ್ಗೀಕರಣ, ಲೆಷನ್ ಸೆಗ್ಮೆಂಟೇಶನ್, ರಕ್ತನಾಳ ಸೆಗ್ಮೆಂಟೇಶನ್ ಮತ್ತು ಅಪಾಯ ವಿಶ್ಲೇಷಣೆ ನಡೆಯುತ್ತಿದೆ.',

    qualityWarning:
      'ವಿಶ್ವಾಸಾರ್ಹ ವಿಶ್ಲೇಷಣೆಗೆ ಈ ಚಿತ್ರ ಸೂಕ್ತವಾಗಿರದಿರಬಹುದು.',

    noVisualization:
      'ಯಾವುದೇ ದೃಶ್ಯೀಕರಣ ಲಭ್ಯವಿಲ್ಲ',

    clinicalReview:
      'ವೈದ್ಯಕೀಯ ತಜ್ಞರ ಪರಿಶೀಲನೆಯನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.',

    lowConfidence:
      'ಕಡಿಮೆ ವಿಶ್ವಾಸ ಮಟ್ಟ - ಮಾನವ ತಜ್ಞರ ಪರಿಶೀಲನೆ ಅಗತ್ಯ',

    grade0: '0 - DR ಇಲ್ಲ',
    grade1: '1 - ಸೌಮ್ಯ',
    grade2: '2 - ಮಧ್ಯಮ',
    grade3: '3 - ತೀವ್ರ',
    grade4: '4 - ಪ್ರೊಲಿಫೆರೇಟಿವ್',

    urgencyLow: 'ಕಡಿಮೆ ಅಪಾಯ',
    urgencyModerate: 'ಮಧ್ಯಮ ಅಪಾಯ',
    urgencyHigh: 'ಹೆಚ್ಚಿನ ಅಪಾಯ',

    referralRoutine:
      'ನಿಯಮಿತ ನೇತ್ರ ತಪಾಸಣೆಯನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.',

    referral4Weeks:
      '4 ವಾರಗಳೊಳಗೆ ತಜ್ಞರನ್ನು ಸಂಪರ್ಕಿಸಿ',

    referralUrgent:
      'ತುರ್ತು ನೇತ್ರ ತಜ್ಞರ ಪರಿಶೀಲನೆಯನ್ನು ಶಿಫಾರಸು ಮಾಡಲಾಗಿದೆ.',

    errorAnalysis: 'ವಿಶ್ಲೇಷಣೆ ವಿಫಲವಾಗಿದೆ'
  },

  Tamil: {
    analysisWorkspace: 'பகுப்பாய்வு பணியிடம்',
    fundusAnalysis: 'ஃபண்டஸ் படப் பகுப்பாய்வு',
    livePipeline: 'நேரடி பைப்லைன்',
    uploadTitle: 'ஃபண்டஸ் படத்தை பதிவேற்றவும்',
    uploadText: 'JPG அல்லது PNG விழித்திரை படம்',
    chooseImage: 'படத்தைத் தேர்ந்தெடுக்கவும்',
    imageReady: 'படம் தயாராக உள்ளது',
    analyze: 'விழித்திரையை பகுப்பாய்வு செய் →',
    analyzing: 'பகுப்பாய்வு நடைபெறுகிறது...',
    analysisComplete: 'பகுப்பாய்வு முடிந்தது',
    retinalResults: 'விழித்திரை பகுப்பாய்வு முடிவுகள்',
    complete: '● முடிந்தது',
    original: 'அசல் ஃபண்டஸ்',
    structural: 'கட்டமைப்பு பகுப்பாய்வு',
    drGrade: 'DR தரம்',
    confidence: 'நம்பகத்தன்மை',
    riskScore: 'ஆபத்து மதிப்பெண்',
    vesselArea: 'இரத்த நாள பகுதி',
    lesionFindings: 'காய முடிவுகள்',
    recommendation: 'பரிந்துரை',
    quality: 'படத் தரம்',
    model: 'மாதிரி',
    status: 'நிலை',
    analysisDone: 'பகுப்பாய்வு முடிந்தது',
    lesionModel: '4-வகுப்பு U-Net',
    language: 'மொழி',
    noLesions: 'காய வகுப்புகள் எதுவும் கண்டறியப்படவில்லை',
    classLabel: 'காய வகுப்பு',
    pixels: 'பிக்சல்கள்',

    disclaimer:
      'AI-உதவிய திரையிடல் முன்மாதிரி. முடிவுகளை தகுதியான கண் மருத்துவர் மதிப்பாய்வு செய்ய வேண்டும்.',

    footer:
      'AI-உதவிய விழித்திரை பகுப்பாய்வு • ஆராய்ச்சி முன்மாதிரி',

    engineReady: 'MATLAB AI இயந்திரம் தயாராக உள்ளது',

    retinalIntelligence: 'விழித்திரை நுண்ணறிவு',

    heroTitle1: 'AI மூலம்',
    heroTitle2: 'கண்ணைப் புரிந்துகொள்ளுங்கள்.',

    heroText:
      'ஃபண்டஸ் படத்தைப் பதிவேற்றி, Eyeabetics பைப்லைன் நீரிழிவு விழித்திரை நோய், விழித்திரை காயங்கள் மற்றும் இரத்த நாள அமைப்பை பகுப்பாய்வு செய்யட்டும்.',

    aiScreening: 'AI விழித்திரை ஸ்கிரீனிங்',

    readyText:
      'முழுமையான Eyeabetics AI பகுப்பாய்வு பைப்லைனுக்கு படம் தயாராக உள்ளது.',

    loadingDetails:
      'DR வகைப்படுத்தல், காயப் பிரிவு, இரத்த நாளப் பிரிவு மற்றும் ஆபத்து பகுப்பாய்வு நடைபெறுகிறது.',

    qualityWarning:
      'நம்பகமான பகுப்பாய்வுக்கு இந்தப் படம் பொருத்தமானதாக இல்லாமல் இருக்கலாம்.',

    noVisualization:
      'காட்சிப்படுத்தல் எதுவும் இல்லை',

    clinicalReview:
      'மருத்துவ நிபுணரின் மதிப்பாய்வு பரிந்துரைக்கப்படுகிறது.',

    lowConfidence:
      'குறைந்த நம்பகத்தன்மை - மனித நிபுணர் மதிப்பாய்வு அவசியம்',

    grade0: '0 - DR இல்லை',
    grade1: '1 - லேசான',
    grade2: '2 - மிதமான',
    grade3: '3 - கடுமையான',
    grade4: '4 - பெருக்கமடைந்த',

    urgencyLow: 'குறைந்த ஆபத்து',
    urgencyModerate: 'மிதமான ஆபத்து',
    urgencyHigh: 'அதிக ஆபத்து',

    referralRoutine:
      'வழக்கமான கண் பரிசோதனை பரிந்துரைக்கப்படுகிறது.',

    referral4Weeks:
      '4 வாரங்களுக்குள் நிபுணரை அணுகவும்',

    referralUrgent:
      'அவசர கண் நிபுணர் மதிப்பாய்வு பரிந்துரைக்கப்படுகிறது.',

    errorAnalysis: 'பகுப்பாய்வு தோல்வியடைந்தது'
  },

  Telugu: {
    analysisWorkspace: 'విశ్లేషణ కార్యస్థలం',
    fundusAnalysis: 'ఫండస్ చిత్ర విశ్లేషణ',
    livePipeline: 'లైవ్ పైప్‌లైన్',
    uploadTitle: 'ఫండస్ చిత్రాన్ని అప్‌లోడ్ చేయండి',
    uploadText: 'JPG లేదా PNG రెటినల్ చిత్రం',
    chooseImage: 'చిత్రాన్ని ఎంచుకోండి',
    imageReady: 'చిత్రం సిద్ధంగా ఉంది',
    analyze: 'రెటినాను విశ్లేషించండి →',
    analyzing: 'విశ్లేషణ జరుగుతోంది...',
    analysisComplete: 'విశ్లేషణ పూర్తయింది',
    retinalResults: 'రెటినల్ విశ్లేషణ ఫలితాలు',
    complete: '● పూర్తయింది',
    original: 'అసలు ఫండస్',
    structural: 'నిర్మాణ విశ్లేషణ',
    drGrade: 'DR గ్రేడ్',
    confidence: 'నమ్మక స్థాయి',
    riskScore: 'ప్రమాద స్కోర్',
    vesselArea: 'రక్తనాళ ప్రాంతం',
    lesionFindings: 'లెషన్ ఫలితాలు',
    recommendation: 'సిఫార్సు',
    quality: 'చిత్ర నాణ్యత',
    model: 'మోడల్',
    status: 'స్థితి',
    analysisDone: 'విశ్లేషణ పూర్తయింది',
    lesionModel: '4-క్లాస్ U-Net',
    language: 'భాష',
    noLesions: 'లెషన్ క్లాసులు గుర్తించబడలేదు',
    classLabel: 'లెషన్ క్లాస్',
    pixels: 'పిక్సెల్స్',

    disclaimer:
      'AI సహాయంతో కూడిన స్క్రీనింగ్ ప్రోటోటైప్. ఫలితాలను అర్హత కలిగిన నేత్ర వైద్యుడు సమీక్షించాలి.',

    footer:
      'AI సహాయంతో రెటినల్ విశ్లేషణ • పరిశోధనా ప్రోటోటైప్',

    engineReady: 'MATLAB AI ఇంజిన్ సిద్ధంగా ఉంది',

    retinalIntelligence: 'రెటినల్ ఇంటెలిజెన్స్',

    heroTitle1: 'AI ద్వారా',
    heroTitle2: 'కంటిని అర్థం చేసుకోండి.',

    heroText:
      'ఫండస్ చిత్రాన్ని అప్‌లోడ్ చేసి Eyeabetics పైప్‌లైన్ ద్వారా డయాబెటిక్ రెటినోపతి, రెటినల్ లెషన్లు మరియు రక్తనాళ నిర్మాణాన్ని విశ్లేషించండి.',

    aiScreening: 'AI రెటినల్ స్క్రీనింగ్',

    readyText:
      'పూర్తి Eyeabetics AI విశ్లేషణ పైప్‌లైన్‌కు చిత్రం సిద్ధంగా ఉంది.',

    loadingDetails:
      'DR వర్గీకరణ, లెషన్ సెగ్మెంటేషన్, రక్తనాళ సెగ్మెంటేషన్ మరియు ప్రమాద విశ్లేషణ జరుగుతున్నాయి.',

    qualityWarning:
      'నమ్మకమైన విశ్లేషణకు ఈ చిత్రం అనుకూలంగా ఉండకపోవచ్చు.',

    noVisualization:
      'విజువలైజేషన్ అందుబాటులో లేదు',

    clinicalReview:
      'వైద్య నిపుణుల సమీక్ష సిఫార్సు చేయబడింది.',

    lowConfidence:
      'తక్కువ నమ్మక స్థాయి - మానవ నిపుణుల సమీక్ష అవసరం',

    grade0: '0 - DR లేదు',
    grade1: '1 - తేలికపాటి',
    grade2: '2 - మోస్తరు',
    grade3: '3 - తీవ్రమైన',
    grade4: '4 - ప్రొలిఫరేటివ్',

    urgencyLow: 'తక్కువ ప్రమాదం',
    urgencyModerate: 'మధ్యస్థ ప్రమాదం',
    urgencyHigh: 'అధిక ప్రమాదం',

    referralRoutine:
      'సాధారణ నేత్ర పరీక్షను సిఫార్సు చేస్తున్నాము.',

    referral4Weeks:
      '4 వారాల్లో నిపుణుడిని సంప్రదించండి',

    referralUrgent:
      'తక్షణ నేత్ర వైద్య నిపుణుల సమీక్ష సిఫార్సు చేయబడింది.',

    errorAnalysis: 'విశ్లేషణ విఫలమైంది'
  },

  Marathi: {
    analysisWorkspace: 'विश्लेषण कार्यक्षेत्र',
    fundusAnalysis: 'फंडस प्रतिमा विश्लेषण',
    livePipeline: 'लाईव्ह पाइपलाइन',
    uploadTitle: 'फंडस प्रतिमा अपलोड करा',
    uploadText: 'JPG किंवा PNG रेटिनल प्रतिमा',
    chooseImage: 'प्रतिमा निवडा',
    imageReady: 'प्रतिमा तयार',
    analyze: 'रेटिनाचे विश्लेषण करा →',
    analyzing: 'विश्लेषण सुरू आहे...',
    analysisComplete: 'विश्लेषण पूर्ण',
    retinalResults: 'रेटिनल विश्लेषणाचे परिणाम',
    complete: '● पूर्ण',
    original: 'मूळ फंडस',
    structural: 'संरचनात्मक विश्लेषण',
    drGrade: 'DR ग्रेड',
    confidence: 'विश्वास पातळी',
    riskScore: 'जोखीम स्कोअर',
    vesselArea: 'रक्तवाहिनी क्षेत्र',
    lesionFindings: 'लेझन निष्कर्ष',
    recommendation: 'शिफारस',
    quality: 'प्रतिमा गुणवत्ता',
    model: 'मॉडेल',
    status: 'स्थिती',
    analysisDone: 'विश्लेषण पूर्ण',
    lesionModel: '4-क्लास U-Net',
    language: 'भाषा',
    noLesions: 'कोणतेही लेझन वर्ग आढळले नाहीत',
    classLabel: 'लेझन वर्ग',
    pixels: 'पिक्सेल',

    disclaimer:
      'AI-सहाय्यित स्क्रीनिंग प्रोटोटाइप. परिणामांची पात्र नेत्रतज्ज्ञांकडून तपासणी केली पाहिजे.',

    footer:
      'AI-सहाय्यित रेटिनल विश्लेषण • संशोधन प्रोटोटाइप',

    engineReady: 'MATLAB AI इंजिन तयार आहे',

    retinalIntelligence: 'रेटिनल इंटेलिजन्स',

    heroTitle1: 'AI द्वारे',
    heroTitle2: 'डोळा समजून घ्या.',

    heroText:
      'फंडस प्रतिमा अपलोड करा आणि Eyeabetics पाइपलाइनद्वारे डायबेटिक रेटिनोपॅथी, रेटिनल लेझन्स आणि रक्तवाहिन्यांच्या संरचनेचे विश्लेषण करा.',

    aiScreening: 'AI रेटिनल स्क्रीनिंग',

    readyText:
      'संपूर्ण Eyeabetics AI विश्लेषण पाइपलाइनसाठी प्रतिमा तयार आहे.',

    loadingDetails:
      'DR वर्गीकरण, लेझन सेगमेंटेशन, रक्तवाहिनी सेगमेंटेशन आणि जोखीम विश्लेषण सुरू आहे.',

    qualityWarning:
      'विश्वसनीय विश्लेषणासाठी ही प्रतिमा योग्य नसू शकते.',

    noVisualization:
      'कोणतेही व्हिज्युअलायझेशन उपलब्ध नाही',

    clinicalReview:
      'वैद्यकीय तज्ज्ञांकडून तपासणी करण्याची शिफारस केली जाते.',

    lowConfidence:
      'कमी विश्वास पातळी - मानवी तज्ज्ञांची तपासणी आवश्यक',

    grade0: '0 - DR नाही',
    grade1: '1 - सौम्य',
    grade2: '2 - मध्यम',
    grade3: '3 - गंभीर',
    grade4: '4 - प्रोलिफरेटिव्ह',

    urgencyLow: 'कमी जोखीम',
    urgencyModerate: 'मध्यम जोखीम',
    urgencyHigh: 'उच्च जोखीम',

    referralRoutine:
      'नियमित नेत्र तपासणीची शिफारस केली जाते.',

    referral4Weeks:
      '4 आठवड्यांच्या आत तज्ज्ञांचा सल्ला घ्या',

    referralUrgent:
      'तातडीच्या नेत्रतज्ज्ञ तपासणीची शिफारस केली जाते.',

    errorAnalysis: 'विश्लेषण अयशस्वी झाले'
  },

  Gujarati: {
    analysisWorkspace: 'વિશ્લેષણ કાર્યક્ષેત્ર',
    fundusAnalysis: 'ફંડસ ઈમેજ વિશ્લેષણ',
    livePipeline: 'લાઈવ પાઇપલાઇન',
    uploadTitle: 'ફંડસ ઈમેજ અપલોડ કરો',
    uploadText: 'JPG અથવા PNG રેટિનલ ઈમેજ',
    chooseImage: 'ઈમેજ પસંદ કરો',
    imageReady: 'ઈમેજ તૈયાર',
    analyze: 'રેટિનાનું વિશ્લેષણ કરો →',
    analyzing: 'વિશ્લેષણ થઈ રહ્યું છે...',
    analysisComplete: 'વિશ્લેષણ પૂર્ણ',
    retinalResults: 'રેટિનલ વિશ્લેષણ પરિણામો',
    complete: '● પૂર્ણ',
    original: 'મૂળ ફંડસ',
    structural: 'માળખાકીય વિશ્લેષણ',
    drGrade: 'DR ગ્રેડ',
    confidence: 'વિશ્વાસ સ્તર',
    riskScore: 'જોખમ સ્કોર',
    vesselArea: 'રક્તવાહિની વિસ્તાર',
    lesionFindings: 'લેઝન પરિણામો',
    recommendation: 'ભલામણ',
    quality: 'ઈમેજ ગુણવત્તા',
    model: 'મોડેલ',
    status: 'સ્થિતિ',
    analysisDone: 'વિશ્લેષણ પૂર્ણ',
    lesionModel: '4-ક્લાસ U-Net',
    language: 'ભાષા',
    noLesions: 'કોઈ લેઝન ક્લાસ મળ્યા નથી',
    classLabel: 'લેઝન ક્લાસ',
    pixels: 'પિક્સેલ',

    disclaimer:
      'AI-સહાયિત સ્ક્રીનિંગ પ્રોટોટાઇપ. પરિણામોની લાયક નેત્ર નિષ્ણાત દ્વારા સમીક્ષા કરવી જોઈએ.',

    footer:
      'AI-સહાયિત રેટિનલ વિશ્લેષણ • સંશોધન પ્રોટોટાઇપ',

    engineReady: 'MATLAB AI એન્જિન તૈયાર છે',

    retinalIntelligence: 'રેટિનલ ઇન્ટેલિજન્સ',

    heroTitle1: 'AI દ્વારા',
    heroTitle2: 'આંખને સમજો.',

    heroText:
      'ફંડસ ઈમેજ અપલોડ કરો અને Eyeabetics પાઇપલાઇન દ્વારા ડાયાબિટિક રેટિનોપેથી, રેટિનલ લેઝન્સ અને રક્તવાહિનીની રચનાનું વિશ્લેષણ કરો.',

    aiScreening: 'AI રેટિનલ સ્ક્રીનિંગ',

    readyText:
      'સંપૂર્ણ Eyeabetics AI વિશ્લેષણ પાઇપલાઇન માટે ઈમેજ તૈયાર છે.',

    loadingDetails:
      'DR વર્ગીકરણ, લેઝન સેગમેન્ટેશન, રક્તવાહિની સેગમેન્ટેશન અને જોખમ વિશ્લેષણ ચાલી રહ્યું છે.',

    qualityWarning:
      'વિશ્વસનીય વિશ્લેષણ માટે આ ઈમેજ યોગ્ય ન હોઈ શકે.',

    noVisualization:
      'કોઈ વિઝ્યુઅલાઇઝેશન ઉપલબ્ધ નથી',

    clinicalReview:
      'તબીબી નિષ્ણાતની સમીક્ષા કરવાની ભલામણ કરવામાં આવે છે.',

    lowConfidence:
      'ઓછું વિશ્વાસ સ્તર - માનવ નિષ્ણાતની સમીક્ષા જરૂરી',

    grade0: '0 - DR નથી',
    grade1: '1 - હળવું',
    grade2: '2 - મધ્યમ',
    grade3: '3 - ગંભીર',
    grade4: '4 - પ્રોલિફેરેટિવ',

    urgencyLow: 'ઓછું જોખમ',
    urgencyModerate: 'મધ્યમ જોખમ',
    urgencyHigh: 'ઉચ્ચ જોખમ',

    referralRoutine:
      'નિયમિત આંખની તપાસ કરવાની ભલામણ કરવામાં આવે છે.',

    referral4Weeks:
      '4 અઠવાડિયામાં નિષ્ણાતની સલાહ લો',

    referralUrgent:
      'તાત્કાલિક નેત્ર નિષ્ણાતની સમીક્ષા કરવાની ભલામણ કરવામાં આવે છે.',

    errorAnalysis: 'વિશ્લેષણ નિષ્ફળ થયું'
  },

  Malayalam: {
    analysisWorkspace: 'വിശകലന പ്രവർത്തനമേഖല',
    fundusAnalysis: 'ഫണ്ടസ് ഇമേജ് വിശകലനം',
    livePipeline: 'ലൈവ് പൈപ്പ്‌ലൈൻ',
    uploadTitle: 'ഫണ്ടസ് ചിത്രം അപ്‌ലോഡ് ചെയ്യുക',
    uploadText: 'JPG അല്ലെങ്കിൽ PNG റെറ്റിനൽ ചിത്രം',
    chooseImage: 'ചിത്രം തിരഞ്ഞെടുക്കുക',
    imageReady: 'ചിത്രം തയ്യാറാണ്',
    analyze: 'റെറ്റിന വിശകലനം ചെയ്യുക →',
    analyzing: 'വിശകലനം നടക്കുന്നു...',
    analysisComplete: 'വിശകലനം പൂർത്തിയായി',
    retinalResults: 'റെറ്റിനൽ വിശകലന ഫലങ്ങൾ',
    complete: '● പൂർത്തിയായി',
    original: 'യഥാർത്ഥ ഫണ്ടസ്',
    structural: 'ഘടനാപരമായ വിശകലനം',
    drGrade: 'DR ഗ്രേഡ്',
    confidence: 'വിശ്വാസനില',
    riskScore: 'റിസ്ക് സ്കോർ',
    vesselArea: 'രക്തക്കുഴൽ വിസ്തീർണ്ണം',
    lesionFindings: 'ലെഷൻ ഫലങ്ങൾ',
    recommendation: 'ശുപാർശ',
    quality: 'ചിത്ര ഗുണനിലവാരം',
    model: 'മോഡൽ',
    status: 'സ്ഥിതി',
    analysisDone: 'വിശകലനം പൂർത്തിയായി',
    lesionModel: '4-ക്ലാസ് U-Net',
    language: 'ഭാഷ',
    noLesions: 'ലെഷൻ ക്ലാസുകൾ കണ്ടെത്തിയില്ല',
    classLabel: 'ലെഷൻ ക്ലാസ്',
    pixels: 'പിക്സലുകൾ',

    disclaimer:
      'AI സഹായത്തോടെയുള്ള സ്ക്രീനിംഗ് പ്രോട്ടോടൈപ്പ്. ഫലങ്ങൾ യോഗ്യതയുള്ള നേത്രരോഗ വിദഗ്ധൻ പരിശോധിക്കണം.',

    footer:
      'AI സഹായത്തോടെയുള്ള റെറ്റിനൽ വിശകലനം • ഗവേഷണ പ്രോട്ടോടൈപ്പ്',

    engineReady: 'MATLAB AI എഞ്ചിൻ തയ്യാറാണ്',

    retinalIntelligence: 'റെറ്റിനൽ ഇന്റലിജൻസ്',

    heroTitle1: 'AI വഴി',
    heroTitle2: 'കണ്ണിനെ മനസ്സിലാക്കാം.',

    heroText:
      'ഫണ്ടസ് ചിത്രം അപ്‌ലോഡ് ചെയ്ത് Eyeabetics പൈപ്പ്‌ലൈൻ ഉപയോഗിച്ച് ഡയബറ്റിക് റെറ്റിനോപ്പതി, റെറ്റിനൽ ലെഷനുകൾ, രക്തക്കുഴൽ ഘടന എന്നിവ വിശകലനം ചെയ്യുക.',

    aiScreening: 'AI റെറ്റിനൽ സ്ക്രീനിംഗ്',

    readyText:
      'പൂർണ്ണ Eyeabetics AI വിശകലന പൈപ്പ്‌ലൈനിലേക്ക് ചിത്രം തയ്യാറാണ്.',

    loadingDetails:
      'DR വർഗ്ഗീകരണം, ലെഷൻ സെഗ്മെന്റേഷൻ, രക്തക്കുഴൽ സെഗ്മെന്റേഷൻ, റിസ്ക് വിശകലനം എന്നിവ നടക്കുന്നു.',

    qualityWarning:
      'വിശ്വസനീയമായ വിശകലനത്തിന് ഈ ചിത്രം അനുയോജ്യമാകണമെന്നില്ല.',

    noVisualization:
      'വിഷ്വലൈസേഷൻ ലഭ്യമല്ല',

    clinicalReview:
      'മെഡിക്കൽ വിദഗ്ധന്റെ പരിശോധന ശുപാർശ ചെയ്യുന്നു.',

    lowConfidence:
      'കുറഞ്ഞ വിശ്വാസനില - മനുഷ്യ വിദഗ്ധന്റെ പരിശോധന ആവശ്യമാണ്',

    grade0: '0 - DR ഇല്ല',
    grade1: '1 - നേരിയ',
    grade2: '2 - മിതമായ',
    grade3: '3 - ഗുരുതര',
    grade4: '4 - പ്രൊലിഫറേറ്റീവ്',

    urgencyLow: 'കുറഞ്ഞ റിസ്ക്',
    urgencyModerate: 'മിതമായ റിസ്ക്',
    urgencyHigh: 'ഉയർന്ന റിസ്ക്',

    referralRoutine:
      'പതിവ് നേത്ര പരിശോധന ശുപാർശ ചെയ്യുന്നു.',

    referral4Weeks:
      '4 ആഴ്ചയ്ക്കുള്ളിൽ വിദഗ്ധനെ സമീപിക്കുക',

    referralUrgent:
      'അടിയന്തര നേത്ര വിദഗ്ധ പരിശോധന ശുപാർശ ചെയ്യുന്നു.',

    errorAnalysis: 'വിശകലനം പരാജയപ്പെട്ടു'
  },

  Punjabi: {
    analysisWorkspace: 'ਵਿਸ਼ਲੇਸ਼ਣ ਕਾਰਜ ਖੇਤਰ',
    fundusAnalysis: 'ਫੰਡਸ ਚਿੱਤਰ ਵਿਸ਼ਲੇਸ਼ਣ',
    livePipeline: 'ਲਾਈਵ ਪਾਈਪਲਾਈਨ',
    uploadTitle: 'ਫੰਡਸ ਚਿੱਤਰ ਅਪਲੋਡ ਕਰੋ',
    uploadText: 'JPG ਜਾਂ PNG ਰੈਟਿਨਲ ਚਿੱਤਰ',
    chooseImage: 'ਚਿੱਤਰ ਚੁਣੋ',
    imageReady: 'ਚਿੱਤਰ ਤਿਆਰ ਹੈ',
    analyze: 'ਰੈਟਿਨਾ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ →',
    analyzing: 'ਵਿਸ਼ਲੇਸ਼ਣ ਹੋ ਰਿਹਾ ਹੈ...',
    analysisComplete: 'ਵਿਸ਼ਲੇਸ਼ਣ ਪੂਰਾ',
    retinalResults: 'ਰੈਟਿਨਲ ਵਿਸ਼ਲੇਸ਼ਣ ਦੇ ਨਤੀਜੇ',
    complete: '● ਪੂਰਾ',
    original: 'ਮੂਲ ਫੰਡਸ',
    structural: 'ਢਾਂਚਾਗਤ ਵਿਸ਼ਲੇਸ਼ਣ',
    drGrade: 'DR ਗ੍ਰੇਡ',
    confidence: 'ਭਰੋਸੇ ਦਾ ਪੱਧਰ',
    riskScore: 'ਖਤਰੇ ਦਾ ਸਕੋਰ',
    vesselArea: 'ਖੂਨ ਦੀਆਂ ਨਾੜੀਆਂ ਦਾ ਖੇਤਰ',
    lesionFindings: 'ਲੇਜ਼ਨ ਨਤੀਜੇ',
    recommendation: 'ਸਿਫਾਰਸ਼',
    quality: 'ਚਿੱਤਰ ਦੀ ਗੁਣਵੱਤਾ',
    model: 'ਮਾਡਲ',
    status: 'ਸਥਿਤੀ',
    analysisDone: 'ਵਿਸ਼ਲੇਸ਼ਣ ਪੂਰਾ',
    lesionModel: '4-ਕਲਾਸ U-Net',
    language: 'ਭਾਸ਼ਾ',
    noLesions: 'ਕੋਈ ਲੇਜ਼ਨ ਕਲਾਸ ਨਹੀਂ ਮਿਲੀ',
    classLabel: 'ਲੇਜ਼ਨ ਕਲਾਸ',
    pixels: 'ਪਿਕਸਲ',

    disclaimer:
      'AI-ਸਹਾਇਤਾ ਪ੍ਰਾਪਤ ਸਕ੍ਰੀਨਿੰਗ ਪ੍ਰੋਟੋਟਾਈਪ। ਨਤੀਜਿਆਂ ਦੀ ਯੋਗ ਨੇਤਰ ਵਿਸ਼ੇਸ਼ਗਿਆਰ ਦੁਆਰਾ ਸਮੀਖਿਆ ਕੀਤੀ ਜਾਣੀ ਚਾਹੀਦੀ ਹੈ।',

    footer:
      'AI-ਸਹਾਇਤਾ ਪ੍ਰਾਪਤ ਰੈਟਿਨਲ ਵਿਸ਼ਲੇਸ਼ਣ • ਖੋਜ ਪ੍ਰੋਟੋਟਾਈਪ',

    engineReady: 'MATLAB AI ਇੰਜਣ ਤਿਆਰ ਹੈ',

    retinalIntelligence: 'ਰੈਟਿਨਲ ਇੰਟੈਲੀਜੈਂਸ',

    heroTitle1: 'AI ਰਾਹੀਂ',
    heroTitle2: 'ਅੱਖ ਨੂੰ ਸਮਝੋ।',

    heroText:
      'ਫੰਡਸ ਚਿੱਤਰ ਅਪਲੋਡ ਕਰੋ ਅਤੇ Eyeabetics ਪਾਈਪਲਾਈਨ ਰਾਹੀਂ ਡਾਇਬੈਟਿਕ ਰੈਟਿਨੋਪੈਥੀ, ਰੈਟਿਨਲ ਲੇਜ਼ਨ ਅਤੇ ਖੂਨ ਦੀਆਂ ਨਾੜੀਆਂ ਦੀ ਬਣਤਰ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਕਰੋ।',

    aiScreening: 'AI ਰੈਟਿਨਲ ਸਕ੍ਰੀਨਿੰਗ',

    readyText:
      'ਪੂਰੀ Eyeabetics AI ਵਿਸ਼ਲੇਸ਼ਣ ਪਾਈਪਲਾਈਨ ਲਈ ਚਿੱਤਰ ਤਿਆਰ ਹੈ।',

    loadingDetails:
      'DR ਵਰਗੀਕਰਨ, ਲੇਜ਼ਨ ਸੈਗਮੈਂਟੇਸ਼ਨ, ਖੂਨ ਦੀਆਂ ਨਾੜੀਆਂ ਦੀ ਸੈਗਮੈਂਟੇਸ਼ਨ ਅਤੇ ਖਤਰੇ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ ਚੱਲ ਰਿਹਾ ਹੈ।',

    qualityWarning:
      'ਭਰੋਸੇਯੋਗ ਵਿਸ਼ਲੇਸ਼ਣ ਲਈ ਇਹ ਚਿੱਤਰ ਢੁਕਵਾਂ ਨਹੀਂ ਹੋ ਸਕਦਾ।',

    noVisualization:
      'ਕੋਈ ਵਿਜ਼ੂਅਲਾਈਜ਼ੇਸ਼ਨ ਉਪਲਬਧ ਨਹੀਂ',

    clinicalReview:
      'ਡਾਕਟਰੀ ਮਾਹਿਰ ਦੁਆਰਾ ਸਮੀਖਿਆ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।',

    lowConfidence:
      'ਘੱਟ ਭਰੋਸੇ ਦਾ ਪੱਧਰ - ਮਨੁੱਖੀ ਮਾਹਿਰ ਦੀ ਸਮੀਖਿਆ ਜ਼ਰੂਰੀ ਹੈ',

    grade0: '0 - DR ਨਹੀਂ',
    grade1: '1 - ਹਲਕਾ',
    grade2: '2 - ਦਰਮਿਆਨਾ',
    grade3: '3 - ਗੰਭੀਰ',
    grade4: '4 - ਪ੍ਰੋਲੀਫਰੇਟਿਵ',

    urgencyLow: 'ਘੱਟ ਖਤਰਾ',
    urgencyModerate: 'ਦਰਮਿਆਨਾ ਖਤਰਾ',
    urgencyHigh: 'ਉੱਚ ਖਤਰਾ',

    referralRoutine:
      'ਨਿਯਮਿਤ ਅੱਖਾਂ ਦੀ ਜਾਂਚ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।',

    referral4Weeks:
      '4 ਹਫ਼ਤਿਆਂ ਦੇ ਅੰਦਰ ਮਾਹਿਰ ਨਾਲ ਸੰਪਰਕ ਕਰੋ',

    referralUrgent:
      'ਤੁਰੰਤ ਨੇਤਰ ਵਿਸ਼ੇਸ਼ਗਿਆਰ ਦੀ ਸਮੀਖਿਆ ਦੀ ਸਿਫਾਰਸ਼ ਕੀਤੀ ਜਾਂਦੀ ਹੈ।',

    errorAnalysis: 'ਵਿਸ਼ਲੇਸ਼ਣ ਅਸਫਲ ਹੋਇਆ'
  }
}


function App() {
  const [image, setImage] = useState(null)
  const [preview, setPreview] = useState(null)
  const [result, setResult] = useState(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [language, setLanguage] = useState('English')

  const t = translations[language]

  const handleImage = (e) => {
    const file = e.target.files?.[0]

    if (!file) return

    setImage(file)
    setPreview(URL.createObjectURL(file))
    setResult(null)
    setError('')
  }


  const analyzeImage = async () => {
    if (!image) return

    setLoading(true)
    setError('')
    setResult(null)

    try {
      const reader = new FileReader()

      reader.onload = async () => {
        try {
          const response = await fetch(
            'http://localhost:5000/api/analyze',
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
              },
              body: JSON.stringify({
                image: reader.result,
              }),
            }
          )

          const data = await response.json()

          if (!response.ok) {
            throw new Error(data.error || t.errorAnalysis)
          }

          setResult(data)

        } catch (err) {
          setError(err.message)
        } finally {
          setLoading(false)
        }
      }

      reader.readAsDataURL(image)

    } catch (err) {
      setError(err.message)
      setLoading(false)
    }
  }


  const getGradeLabel = (grade) => {
    const labels = [
      t.grade0,
      t.grade1,
      t.grade2,
      t.grade3,
      t.grade4
    ]

    const n = Number(grade)

    return Number.isInteger(n) && n >= 0 && n <= 4
      ? labels[n]
      : 'N/A'
  }


  const getUrgencyLabel = (urgency) => {
    const value = String(urgency || '').toLowerCase()

    if (value.includes('high')) {
      return t.urgencyHigh
    }

    if (value.includes('moderate')) {
      return t.urgencyModerate
    }

    if (value.includes('low')) {
      return t.urgencyLow
    }

    return ''
  }


  const getReferralText = () => {
    const urgency = String(
      result?.referral?.urgency || ''
    ).toLowerCase()

    if (urgency.includes('high')) {
      return t.referralUrgent
    }

    if (urgency.includes('moderate')) {
      return t.referral4Weeks
    }

    if (urgency.includes('low')) {
      return t.referralRoutine
    }

    return (
      result?.referral?.timeframe ||
      result?.referral?.message ||
      t.clinicalReview
    )
  }


  const getLesionEntries = () => {
    if (!result?.lesionCounts) return []

    return Object.entries(result.lesionCounts).filter(
      ([key]) =>
        key.toLowerCase() !== 'background' &&
        key.toLowerCase() !== 'class1'
    )
  }


  const getLesionName = (name) => {
    const value = String(name).toLowerCase()

    if (value.includes('class2')) {
      return language === 'English'
        ? 'Exudative / Lesion Class 2'
        : `${t.classLabel} 2`
    }

    if (value.includes('class3')) {
      return language === 'English'
        ? 'Hemorrhagic / Lesion Class 3'
        : `${t.classLabel} 3`
    }

    if (value.includes('class4')) {
      return language === 'English'
        ? 'Lesion Class 4'
        : `${t.classLabel} 4`
    }

    return `${t.classLabel} ${name.replace(/class/i, '')}`
  }


  /*
   * IMPORTANT:
   * MATLAB returns riskScoreAdjusted.
   * Older frontend code expected result.riskScore.
   * This helper supports both so the UI never shows N/A
   * when MATLAB has actually calculated a risk score.
   */
  const getRiskScore = () => {
    if (result?.riskScoreAdjusted !== undefined) {
      return Number(result.riskScoreAdjusted)
    }

    if (result?.riskScore !== undefined) {
      return Number(result.riskScore)
    }

    return null
  }


  const riskScore = getRiskScore()


  const getConfidence = () => {
    if (typeof result?.confidence === 'number') {
      return result.confidence
    }

    if (typeof result?.drConfidence === 'number') {
      return result.drConfidence
    }

    return null
  }


  const confidence = getConfidence()


  return (
    <div className="app">

      <header className="navbar">

        <div className="brand">

          <div className="brand-icon">
            E
          </div>

          <div>
            <h1>Eyeabetics</h1>

            <span>
              {t.footer}
            </span>
          </div>

        </div>


        <div className="nav-right">

          <div className="language-selector">

            <label htmlFor="language">
              {t.language}
            </label>

            <select
              id="language"
              value={language}
              onChange={(e) =>
                setLanguage(e.target.value)
              }
            >

              {Object.keys(translations).map(
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

          </div>


          <div className="status">

            <span className="status-dot"></span>

            {t.engineReady}

          </div>

        </div>

      </header>


      <main>

        <section className="hero">

          <div>

            <p className="eyebrow">
              {t.retinalIntelligence}
            </p>

            <h2>

              {t.heroTitle1}

              <br />

              <span>
                {t.heroTitle2}
              </span>

            </h2>


            <p className="hero-text">
              {t.heroText}
            </p>

          </div>


          <div className="hero-card">

            <div className="scan-line"></div>

            <div className="eye-symbol">
              ◉
            </div>

            <p>
              {t.aiScreening}
            </p>

            <span>
              MATLAB • U-NET • IDRiD
            </span>

          </div>

        </section>


        <section className="analysis-card">

          <div className="section-heading">

            <div>

              <p className="eyebrow">
                {t.analysisWorkspace}
              </p>

              <h3>
                {t.fundusAnalysis}
              </h3>

            </div>

            <span className="pipeline">
              {t.livePipeline}
            </span>

          </div>


          <div className="upload-area">

            {!preview ? (

              <label className="upload-box">

                <div className="upload-icon">
                  ↑
                </div>

                <h4>
                  {t.uploadTitle}
                </h4>

                <p>
                  {t.uploadText}
                </p>

                <span className="browse">
                  {t.chooseImage}
                </span>

                <input
                  type="file"
                  accept="image/png,image/jpeg"
                  onChange={handleImage}
                  hidden
                />

              </label>

            ) : (

              <div className="preview-container">

                <img
                  src={preview}
                  alt="Fundus preview"
                />

                <div className="preview-info">

                  <p className="eyebrow">
                    {t.imageReady}
                  </p>

                  <h4>
                    {image?.name}
                  </h4>

                  <p>
                    {t.readyText}
                  </p>

                  <button
                    onClick={analyzeImage}
                    disabled={loading}
                  >

                    {loading
                      ? t.analyzing
                      : t.analyze}

                  </button>

                </div>

              </div>

            )}

          </div>


          {error && (
            <div className="error">
              {error}
            </div>
          )}


          {loading && (

            <div className="loading">

              <div className="loader"></div>

              <div>

                <strong>
                  {t.analyzing}
                </strong>

                <p>
                  {t.loadingDetails}
                </p>

              </div>

            </div>

          )}

        </section>


        {result && (

          <section className="results">

            <div className="section-heading">

              <div>

                <p className="eyebrow">
                  {t.analysisComplete}
                </p>

                <h3>
                  {t.retinalResults}
                </h3>

              </div>

              <span className="complete">
                {t.complete}
              </span>

            </div>


            {!result.isGradeable && (

              <div className="quality-warning">

                <strong>
                  {t.quality}
                </strong>

                <p>
                  {result.qualityMessage ||
                    t.qualityWarning}
                </p>

              </div>

            )}


            <div className="main-result">

              <div className="dr-result-card">

                <span>
                  {t.drGrade}
                </span>

                <strong>
                  {getGradeLabel(
                    result.grade ??
                    result.drGrade
                  )}
                </strong>

                <small>

                  {t.confidence}:{' '}

                  {confidence !== null
                    ? `${(
                        confidence * 100
                      ).toFixed(2)}%`
                    : 'N/A'}

                </small>

              </div>


              <div className="risk-result-card">

                <span>
                  {t.riskScore}
                </span>

                <strong>
                  {riskScore !== null
                    ? riskScore.toFixed(2)
                    : 'N/A'}
                </strong>

                <small>

                  {confidence !== null &&
                  confidence < 0.6
                    ? t.lowConfidence
                    : (
                        getUrgencyLabel(
                          result?.referral?.urgency
                        ) || 'N/A'
                      )}

                </small>

              </div>

            </div>


            <div className="result-grid">

              <div className="result-image">

                <div className="result-label">
                  {t.original}
                </div>

                <img
                  src={preview}
                  alt="Original fundus"
                />

              </div>


              <div className="result-image">

                <div className="result-label">
                  {t.structural}
                </div>

                {result.overlay ? (

                  <img
                    src={`data:image/png;base64,${result.overlay}`}
                    alt="Structural retinal analysis"
                  />

                ) : (

                  <div className="no-image">
                    {t.noVisualization}
                  </div>

                )}

              </div>

            </div>


            <div className="metrics">

              <div>

                <span>
                  {t.drGrade}
                </span>

                <strong>
                  {getGradeLabel(
                    result.grade ??
                    result.drGrade
                  )}
                </strong>

              </div>


              <div>

                <span>
                  {t.confidence}
                </span>

                <strong>
                  {confidence !== null
                    ? `${(
                        confidence * 100
                      ).toFixed(2)}%`
                    : 'N/A'}
                </strong>

              </div>


              <div>

                <span>
                  {t.vesselArea}
                </span>

                <strong>
                  {typeof result.vesselPercentage ===
                    'number'
                    ? `${result.vesselPercentage.toFixed(
                        2
                      )}%`
                    : 'N/A'}
                </strong>

              </div>


              <div>

                <span>
                  {t.quality}
                </span>

                <strong>
                  {typeof result.qualityScore ===
                    'number'
                    ? result.qualityScore.toFixed(0)
                    : 'N/A'}
                </strong>

              </div>

            </div>


            <div className="detail-grid">

              <div className="detail-card">

                <p className="eyebrow">
                  {t.lesionFindings}
                </p>


                {getLesionEntries().length > 0 ? (

                  <div className="lesion-list">

                    {getLesionEntries().map(
                      ([name, pixels]) => (

                        <div
                          className="lesion-item"
                          key={name}
                        >

                          <span>
                            {getLesionName(name)}
                          </span>

                          <strong>
                            {Number(
                              pixels
                            ).toLocaleString()}{' '}
                            {t.pixels}
                          </strong>

                        </div>

                      )
                    )}

                  </div>

                ) : (

                  <p>
                    {t.noLesions}
                  </p>

                )}

              </div>


              <div className="detail-card recommendation-card">

                <p className="eyebrow">
                  {t.recommendation}
                </p>

                <h4>
                  {getReferralText()}
                </h4>


                {result.referral?.nearestCenter && (

                  <p>
                    {result.referral.nearestCenter}
                  </p>

                )}

              </div>

            </div>


            <div className="technical-strip">

              <div>

                <span>
                  {t.model}
                </span>

                <strong>
                  {t.lesionModel}
                </strong>

              </div>


              <div>

                <span>
                  {t.status}
                </span>

                <strong>
                  {t.analysisDone}
                </strong>

              </div>


              <div>

                <span>
                  {t.riskScore}
                </span>

                <strong>
                  {riskScore !== null
                    ? riskScore.toFixed(2)
                    : 'N/A'}
                </strong>

              </div>

            </div>


            <div className="disclaimer">
              {t.disclaimer}
            </div>

          </section>

        )}

      </main>


      <footer>

        <span>
          Eyeabetics
        </span>

        <span>
          {t.footer}
        </span>

      </footer>

    </div>
  )
}

export default App