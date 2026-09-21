# Eyeabetics

## AI-Assisted Diabetic Retinopathy Screening and Retinal Analysis

Eyeabetics is a research prototype developed to support diabetic retinopathy screening through retinal image analysis. The system combines image quality assessment, diabetic retinopathy classification, retinal lesion and vessel segmentation, structural evidence, referral support, and longitudinal patient records into a single workflow.

The project is designed with resource-constrained healthcare settings in mind, where access to specialist screening and continuity of patient records can be limited.

## Project Overview

A fundus image passes through a sequence of analysis stages:

1. Image quality assessment to determine whether the image is suitable for analysis
2. Diabetic retinopathy classification using a five-level grading system
3. Retinal lesion segmentation for structural analysis
4. Retinal vessel segmentation
5. Combination of retinal findings with selected patient information for risk and referral support
6. Storage of screening results as part of the patient's longitudinal record

The system is intended to support screening and clinical review rather than replace professional ophthalmic assessment.

## Current Capabilities

### Diabetic Retinopathy Classification

The classification model uses EfficientNet-B0 and provides five DR grades:

- Grade 0 - No DR
- Grade 1 - Mild
- Grade 2 - Moderate
- Grade 3 - Severe
- Grade 4 - Proliferative

### Retinal Lesion Analysis

A U-Net based segmentation model is used to identify retinal lesion patterns at the pixel level. These outputs provide additional structural evidence alongside the DR classification.

### Retinal Vessel Analysis

A second U-Net model is used to segment retinal blood vessels and provide supporting measurements such as vessel area.

### Image Quality Assessment

The system checks the quality and gradeability of the captured fundus image before analysis. The current implementation assesses image suitability and does not perform adaptive image enhancement.

### Risk and Referral Support

The prototype combines the DR grade with selected patient factors to generate a referral category. The output is intended to support clinical review and does not represent an autonomous medical decision.

### Retina Passport

Screening results and patient information can be stored together to support follow-up and comparison across multiple screening visits.

## Technology Stack

- Python and PyTorch
- ONNX
- MATLAB R2026a
- Node.js
- MongoDB
- React
- Vite
- Simulink for planned workflow and scalability studies

## System Workflow

```text
Fundus Image
     |
     v
Image Quality Assessment
     |
     v
DR Classification
     |
     +------------------+
     |                  |
     v                  v
Lesion Segmentation   Vessel Segmentation
     |                  |
     +--------+---------+
              |
              v
     Structural Analysis
              |
              v
       Risk and Referral
              |
              v
     Report and Patient Record
     ## Research Direction

The current project focuses on diabetic retinopathy screening and retinal structural analysis.

A future research direction is Oculomics, where measurable retinal features such as vessel and lesion patterns could be studied alongside clinical information to investigate possible associations with broader systemic health.

This is a future research direction and is not a current capability for diagnosing systemic diseases.

## Research Report

A detailed research report covering the technical architecture, current capabilities, validation scope, future research direction, and supporting references is available here:

[Eyeabetics Research Report](Report/Eyeabetics_Research_Report.pdf)

## Research Status and Limitations

Eyeabetics is currently a research prototype. The results demonstrated by the project represent technical implementation and prototype-level evaluation and should not be interpreted as clinical validation.

Further work is required in areas such as external validation, calibration, prospective evaluation, testing across different populations and imaging devices, clinical workflow studies, privacy and security, and regulatory assessment before clinical deployment.

## Disclaimer

Eyeabetics is intended for research and screening support. Its outputs should be reviewed by qualified healthcare professionals and should not be used as a replacement for professional medical assessment.