import http from "http";
import fs from "fs";
import path from "path";
import { execFile } from "child_process";

import mongoose from "mongoose";

import Patient from "./models/Patient.js";
import Screening from "./models/Screening.js";

import calculateProgression from "./progressionEngine.js";
import calculateTriage from "./triageEngine.js";
import buildEvidenceSummary from "./evidenceEngine.js";


// ============================================================
// MONGODB
// ============================================================

const MONGO_URI =
  "mongodb://127.0.0.1:27017/eyeabetics";

mongoose
  .connect(MONGO_URI)
  .then(() => {
    console.log("✅ MongoDB connected");
    console.log("🪪 Retina Passport database ready");
  })
  .catch((error) => {
    console.error(
      "❌ MongoDB connection failed:",
      error
    );
  });


// ============================================================
// CONFIGURATION
// ============================================================

const PORT = 5000;

const ROOT =
  "C:\\Users\\KIIT\\Desktop\\Eyeabetics_Innovate";

const UPLOAD_DIR = path.join(
  ROOT,
  "website",
  "backend",
  "uploads"
);

// Legacy project folder.
// Used only as a read-only fallback for older demo files.
const LEGACY_UPLOAD_DIR =
  "C:\\Users\\KIIT\\Downloads\\Eyeabetics\\website\\backend\\uploads";

const MATLAB_PATH =
  "C:\\Program Files\\MATLAB\\R2026a\\bin\\matlab.exe";

fs.mkdirSync(
  UPLOAD_DIR,
  { recursive: true }
);


// ============================================================
// RESPONSE HELPER
// ============================================================

function send(res, status, data) {

  res.writeHead(status, {
    "Content-Type": "application/json",

    "Access-Control-Allow-Origin": "*",

    "Access-Control-Allow-Methods":
      "GET, POST, OPTIONS",

    "Access-Control-Allow-Headers":
      "Content-Type",
  });

  res.end(
    JSON.stringify(data)
  );
}


// ============================================================
// READ JSON BODY
// ============================================================

function readBody(req) {

  return new Promise(
    (resolve, reject) => {

      let body = "";

      req.on(
        "data",
        (chunk) => {
          body += chunk;
        }
      );

      req.on(
        "end",
        () => {

          try {

            resolve(
              JSON.parse(body)
            );

          } catch (error) {

            reject(error);
          }
        }
      );

      req.on(
        "error",
        reject
      );
    }
  );
}


// ============================================================
// FILE HELPERS
// ============================================================

function getContentType(filePath) {

  const extension =
    path.extname(filePath)
      .toLowerCase();

  const types = {

    ".jpg":
      "image/jpeg",

    ".jpeg":
      "image/jpeg",

    ".png":
      "image/png",

    ".webp":
      "image/webp",

    ".json":
      "application/json",
  };

  return (
    types[extension] ||
    "application/octet-stream"
  );
}


function findUploadFile(fileName) {

  const safeName =
    path.basename(fileName);

  const candidates = [

    path.join(
      UPLOAD_DIR,
      safeName
    ),

    path.join(
      LEGACY_UPLOAD_DIR,
      safeName
    ),
  ];

  for (
    const candidate of candidates
  ) {

    if (
      fs.existsSync(candidate) &&
      fs.statSync(candidate).isFile()
    ) {

      return candidate;
    }
  }

  return null;
}


function sendFile(
  res,
  filePath
) {

  try {

    const data =
      fs.readFileSync(filePath);

    res.writeHead(
      200,
      {
        "Content-Type":
          getContentType(filePath),

        "Access-Control-Allow-Origin":
          "*",

        "Cache-Control":
          "no-cache",
      }
    );

    res.end(data);

  } catch (error) {

    console.error(
      "❌ File read failed:",
      error
    );

    return send(
      res,
      500,
      {
        success: false,
        error:
          "Could not read requested file",
        details:
          error.message,
      }
    );
  }
}


// ============================================================
// SERVER
// ============================================================

const server =
  http.createServer(
    async (req, res) => {

      try {

        // ======================================================
        // CORS
        // ======================================================

        if (
          req.method === "OPTIONS"
        ) {

          res.writeHead(
            204,
            {
              "Access-Control-Allow-Origin":
                "*",

              "Access-Control-Allow-Methods":
                "GET, POST, OPTIONS",

              "Access-Control-Allow-Headers":
                "Content-Type",
            }
          );

          return res.end();
        }


        // ======================================================
        // HEALTH CHECK
        // ======================================================

        if (
          req.method === "GET" &&
          req.url === "/api/health"
        ) {

          return send(
            res,
            200,
            {
              success: true,

              service:
                "Eyeabetics backend",

              mongodb:
                mongoose.connection
                  .readyState === 1
                  ? "connected"
                  : "disconnected",

              matlab:
                "available",
            }
          );
        }


        // ======================================================
        // CREATE PATIENT
        // ======================================================

        if (
          req.method === "POST" &&
          req.url === "/api/patients"
        ) {

          try {

            const data =
              await readBody(req);

            if (!data.name) {

              return send(
                res,
                400,
                {
                  error:
                    "Patient name is required",
                }
              );
            }

            const patientId =
              data.patientId ||
              `PAT-${Date.now()}`;

            const existingPatient =
              await Patient.findOne({
                patientId,
              });

            if (existingPatient) {

              return send(
                res,
                409,
                {
                  error:
                    "Patient ID already exists",

                  patientId,
                }
              );
            }

            const patient =
              await Patient.create({

                patientId,

                name:
                  data.name,

                age:
                  data.age,

                gender:
                  data.gender,

                phone:
                  data.phone,

                village:
                  data.village,

                district:
                  data.district,
              });

            console.log(
              "🪪 Patient created:",
              patient.patientId
            );

            return send(
              res,
              201,
              {
                success: true,
                patient,
              }
            );

          } catch (error) {

            console.error(
              "❌ Patient creation failed:",
              error
            );

            return send(
              res,
              500,
              {
                error:
                  "Could not create patient",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // PATIENT PROFILE
        // GET /api/patients/:patientId
        //
        // PATIENT SCREENING HISTORY
        // GET /api/patients/:patientId/screenings
        // ======================================================

        if (
          req.method === "GET" &&
          req.url.startsWith(
            "/api/patients/"
          ) &&
          !req.url.endsWith(
            "/progression"
          )
        ) {

          try {

            const parts =
              req.url.split("/");

            const patientId =
              parts[3];

            if (!patientId) {

              return send(
                res,
                400,
                {
                  error:
                    "Patient ID is required",
                }
              );
            }


            // --------------------------------------------------
            // SCREENING HISTORY
            // --------------------------------------------------

            if (
              parts[4] === "screenings"
            ) {

              const patient =
                await Patient.findOne({
                  patientId,
                });

              if (!patient) {

                return send(
                  res,
                  404,
                  {
                    error:
                      "Patient not found",
                  }
                );
              }

              const screenings =
  await Screening.find({
    patientId,
  })
  .sort({
    screenedAt: -1,
  });

const enrichedScreenings =
  screenings.map((screening) => {

    const imageFileName =
      screening.imageName
        ? path.basename(
            screening.imageName
          )
        : null;

    const overlayFileName =
      screening.structuralOverlay
        ? path.basename(
            screening.structuralOverlay
          )
        : null;

    const imageExists =
      imageFileName &&
      Boolean(
        findUploadFile(
          imageFileName
        )
      );

    const overlayExists =
      overlayFileName &&
      Boolean(
        findUploadFile(
          overlayFileName
        )
      );

    return {
      ...screening.toObject(),

      imageUrl:
        imageExists
          ? `/api/uploads/${encodeURIComponent(
              imageFileName
            )}`
          : null,

      overlayUrl:
        overlayExists
          ? `/api/uploads/${encodeURIComponent(
              overlayFileName
            )}`
          : null,
    };
  });

return send(
  res,
  200,
  {
    success: true,
    patient,
    screenings:
      enrichedScreenings,
  }
);
            }


            // --------------------------------------------------
            // PATIENT PROFILE
            // --------------------------------------------------

            const patient =
              await Patient.findOne({
                patientId,
              });

            if (!patient) {

              return send(
                res,
                404,
                {
                  error:
                    "Patient not found",
                }
              );
            }

            return send(
              res,
              200,
              {
                success: true,
                patient,
              }
            );

          } catch (error) {

            console.error(
              "❌ Patient retrieval failed:",
              error
            );

            return send(
              res,
              500,
              {
                error:
                  "Could not retrieve patient",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // RETINAL PROGRESSION
        //
        // GET
        // /api/patients/:patientId/progression
        // ======================================================

        if (
          req.method === "GET" &&
          req.url.startsWith(
            "/api/patients/"
          ) &&
          req.url.endsWith(
            "/progression"
          )
        ) {

          try {

            const parts =
              req.url.split("/");

            const patientId =
              parts[3];

            if (!patientId) {

              return send(
                res,
                400,
                {
                  error:
                    "Patient ID is required",
                }
              );
            }

            const patient =
              await Patient.findOne({
                patientId,
              });

            if (!patient) {

              return send(
                res,
                404,
                {
                  error:
                    "Patient not found",
                }
              );
            }

            const screenings =
              await Screening.find({
                patientId,
              })
              .sort({
                screenedAt: -1,
              });

            const progression =
              calculateProgression(
                screenings
              );

            console.log(
              "\n📈 PROGRESSION ANALYSIS"
            );

            console.log(
              "Patient:",
              patientId
            );

            if (
              progression.available
            ) {

              console.log(
                "Previous DR Grade:",
                progression.previous.drGrade
              );

              console.log(
                "Current DR Grade:",
                progression.current.drGrade
              );

              console.log(
                "Grade Change:",
                progression.changes.drGrade
              );

              console.log(
                "Status:",
                progression.progression.status
              );

              console.log(
                "Priority:",
                progression.progression.priority
              );

            } else {

              console.log(
                progression.message
              );
            }

            return send(
              res,
              200,
              {
                success: true,

                patient,

                progression,
              }
            );

          } catch (error) {

            console.error(
              "❌ Progression analysis failed:",
              error
            );

            return send(
              res,
              500,
              {
                error:
                  "Could not calculate progression",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // SERVE FUNDUS / OVERLAY FILES
        //
        // GET /api/uploads/:filename
        // ======================================================

        if (
          req.method === "GET" &&
          req.url.startsWith(
            "/api/uploads/"
          )
        ) {

          const requestedName =
            decodeURIComponent(
              req.url
                .split(
                  "/api/uploads/"
                )[1]
                .split("?")[0]
            );

          if (!requestedName) {

            return send(
              res,
              400,
              {
                success: false,
                error:
                  "File name is required.",
              }
            );
          }

          const filePath =
            findUploadFile(
              requestedName
            );

          if (!filePath) {

            return send(
              res,
              404,
              {
                success: false,
                error:
                  "Requested screening file was not found.",
              }
            );
          }

          return sendFile(
            res,
            filePath
          );
        }


        // ======================================================
        // GET SPECIFIC SCREENING
        //
        // GET /api/screenings/:screeningId
        // ======================================================

        if (
          req.method === "GET" &&
          req.url.startsWith(
            "/api/screenings/"
          )
        ) {

          try {

            const screeningId =
              req.url
                .split(
                  "/api/screenings/"
                )[1]
                .split("?")[0];

            if (!screeningId) {

              return send(
                res,
                400,
                {
                  success: false,
                  error:
                    "Screening ID is required.",
                }
              );
            }

            const screening =
              await Screening.findById(
                screeningId
              );

            if (!screening) {

              return send(
                res,
                404,
                {
                  success: false,
                  error:
                    "Screening not found.",
                }
              );
            }


            // --------------------------------------------------
            // IMAGE URL
            // --------------------------------------------------

            const imageFileName =
              screening.imageName
                ? path.basename(
                    screening.imageName
                  )
                : null;


            // --------------------------------------------------
            // OVERLAY URL
            // --------------------------------------------------

            const overlayFileName =
              screening.structuralOverlay
                ? path.basename(
                    screening.structuralOverlay
                  )
                : null;


            const imageExists =
              imageFileName &&
              Boolean(
                findUploadFile(
                  imageFileName
                )
              );

            const overlayExists =
              overlayFileName &&
              Boolean(
                findUploadFile(
                  overlayFileName
                )
              );


            // --------------------------------------------------
            // EVIDENCE ENGINE
            // --------------------------------------------------

            const evidence =
              buildEvidenceSummary(
                screening.toObject()
              );


            // --------------------------------------------------
            // FINAL SCREENING RESPONSE
            // --------------------------------------------------

            const enrichedScreening = {

              ...screening.toObject(),

              imageUrl:
                imageExists
                  ? `/api/uploads/${encodeURIComponent(
                      imageFileName
                    )}`
                  : null,

              overlayUrl:
                overlayExists
                  ? `/api/uploads/${encodeURIComponent(
                      overlayFileName
                    )}`
                  : null,

              evidence,
            };


            return send(
              res,
              200,
              {
                success: true,

                screening:
                  enrichedScreening,
              }
            );

          } catch (error) {

            console.error(
              "❌ Screening lookup failed:",
              error
            );

            return send(
              res,
              500,
              {
                success: false,

                error:
                  "Unable to load screening.",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // MANUAL SCREENING SAVE
        //
        // POST /api/screenings
        // ======================================================

        if (
          req.method === "POST" &&
          req.url === "/api/screenings"
        ) {

          try {

            const data =
              await readBody(req);

            if (!data.patientId) {

              return send(
                res,
                400,
                {
                  error:
                    "Patient ID is required",
                }
              );
            }

            const patient =
              await Patient.findOne({
                patientId:
                  data.patientId,
              });

            if (!patient) {

              return send(
                res,
                404,
                {
                  error:
                    "Patient not found",
                }
              );
            }

            const screening =
              await Screening.create({

                patientId:
                  data.patientId,

                imageName:
                  data.imageName,

                drGrade:
                  data.drGrade,

                drLabel:
                  data.drLabel,

                vesselPercentage:
                  data.vesselPercentage,

                lesionFindings:
                  data.lesionFindings,

                imageQuality:
                  data.imageQuality,

                riskScore:
                  data.riskScore,

                referral:
                  data.referral,

                structuralOverlay:
                  data.structuralOverlay,

                screenedAt:
                  data.screenedAt ||
                  new Date(),
              });


            console.log(
              "📋 Screening saved for:",
              data.patientId
            );

            return send(
              res,
              201,
              {
                success: true,

                screening,
              }
            );

          } catch (error) {

            console.error(
              "❌ Screening save failed:",
              error
            );

            return send(
              res,
              500,
              {
                error:
                  "Could not save screening",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // AI TRIAGE QUEUE
        //
        // GET /api/triage
        // ======================================================

        if (
          req.method === "GET" &&
          req.url === "/api/triage"
        ) {

          try {

            const screenings =
              await Screening.find({})
                .sort({
                  screenedAt: -1,
                });


            // --------------------------------------------------
            // BUILD QUEUE
            // --------------------------------------------------

            const queue =
              screenings.map(
                (screening) => {

                  let triage;


                  // Use saved triage if
                  // available.
                  if (
                    screening.triage
                  ) {

                    triage =
                      screening.triage;

                  } else {

                    triage =
                      calculateTriage(
                        screening
                      );
                  }


                  return {

                    screeningId:
                      screening._id,

                    patientId:
                      screening.patientId,

                    imageName:
                      screening.imageName,

                    screenedAt:
                      screening.screenedAt,

                    drGrade:
                      screening.drGrade,

                    drLabel:
                      screening.drLabel,

                    riskScore:
                      screening.riskScore,

                    vesselPercentage:
                      screening.vesselPercentage,

                    imageQuality:
                      screening.imageQuality,

                    referral:
                      screening.referral,

                    triage: {

                      score:
                        triage.score,

                      priority:
                        triage.priority,

                      level:
                        triage.level,

                      action:
                        triage.action,

                      reason:
                        triage.reason,

                      queueEligible:
                        triage.queueEligible,
                    },
                  };
                }
              );


            // --------------------------------------------------
            // PRIORITY ORDER
            // --------------------------------------------------

            const priorityRank = {

              "IMAGE RECHECK": 0,

              "CRITICAL": 1,

              "HIGH": 2,

              "MODERATE": 3,

              "ROUTINE": 4,
            };


            queue.sort(
              (a, b) => {

                const priorityA =
                  priorityRank[
                    a.triage.priority
                  ] ?? 99;

                const priorityB =
                  priorityRank[
                    b.triage.priority
                  ] ?? 99;


                if (
                  priorityA !==
                  priorityB
                ) {

                  return (
                    priorityA -
                    priorityB
                  );
                }


                return (
                  Number(
                    b.triage.score || 0
                  ) -
                  Number(
                    a.triage.score || 0
                  )
                );
              }
            );


            // --------------------------------------------------
            // SUMMARY
            // --------------------------------------------------

            const summary = {

              total:
                queue.length,

              critical:
                queue.filter(
                  (item) =>
                    item.triage.priority ===
                    "CRITICAL"
                ).length,

              high:
                queue.filter(
                  (item) =>
                    item.triage.priority ===
                    "HIGH"
                ).length,

              moderate:
                queue.filter(
                  (item) =>
                    item.triage.priority ===
                    "MODERATE"
                ).length,

              routine:
                queue.filter(
                  (item) =>
                    item.triage.priority ===
                    "ROUTINE"
                ).length,

              imageRecheck:
                queue.filter(
                  (item) =>
                    item.triage.priority ===
                    "IMAGE RECHECK"
                ).length,
            };


            console.log(
              "\n================================="
            );

            console.log(
              "🚦 OPHTHALMOLOGY TRIAGE QUEUE"
            );

            console.log(
              "Total cases:",
              summary.total
            );

            console.log(
              "Critical:",
              summary.critical
            );

            console.log(
              "High:",
              summary.high
            );

            console.log(
              "Moderate:",
              summary.moderate
            );

            console.log(
              "Routine:",
              summary.routine
            );

            console.log(
              "Image Recheck:",
              summary.imageRecheck
            );

            console.log(
              "=================================\n"
            );


            return send(
              res,
              200,
              {
                success: true,

                summary,

                queue,
              }
            );

          } catch (error) {

            console.error(
              "❌ Triage queue failed:",
              error
            );

            return send(
              res,
              500,
              {
                error:
                  "Could not load triage queue",

                details:
                  error.message,
              }
            );
          }
        }


        // ======================================================
        // AI ANALYSIS
        //
        // POST /api/analyze
        // ======================================================

        if (
          req.method !== "POST" ||
          req.url !== "/api/analyze"
        ) {

          return send(
            res,
            404,
            {
              error:
                "Endpoint not found",
            }
          );
        }


        // ======================================================
        // READ REQUEST
        // ======================================================

        const request =
          await readBody(req);

        if (!request.image) {

          return send(
            res,
            400,
            {
              error:
                "No image supplied",
            }
          );
        }


        // ======================================================
        // IMAGE VALIDATION
        // ======================================================

        const match =
          request.image.match(
            /^data:image\/([a-zA-Z0-9.+-]+);base64,(.+)$/
          );

        if (!match) {

          return send(
            res,
            400,
            {
              error:
                "Invalid image format",
            }
          );
        }


        // ======================================================
        // SAVE UPLOADED IMAGE
        // ======================================================

        const extension =
          match[1] === "jpeg"
            ? "jpg"
            : match[1];

        const imagePath =
          path.join(
            UPLOAD_DIR,
            `fundus_${Date.now()}.${extension}`
          );

        const jsonPath =
          imagePath + ".json";


        fs.writeFileSync(
          imagePath,

          Buffer.from(
            match[2],
            "base64"
          )
        );


        console.log(
          "\n================================="
        );

        console.log(
          "🧠 EYEABETICS AI ANALYSIS"
        );

        console.log(
          "Image:",
          imagePath
        );

        if (
          request.patientId
        ) {

          console.log(
            "Patient:",
            request.patientId
          );
        }

        console.log(
          "=================================\n"
        );


        // ======================================================
        // MATLAB COMMAND
        // ======================================================

        const matlabCommand =
          `web_inference('${imagePath
            .replace(/\\/g, "/")}','${jsonPath
            .replace(/\\/g, "/")}')`;


        // ======================================================
        // RUN MATLAB
        // ======================================================

        execFile(

          MATLAB_PATH,

          [
            "-batch",
            matlabCommand,
          ],

          {
            windowsHide:
              true,

            timeout:
              600000,
          },

          async (
            error,
            stdout,
            stderr
          ) => {

            console.log(
              stdout
            );

            if (stderr) {

              console.log(
                stderr
              );
            }


            // --------------------------------------------------
            // MATLAB ERROR
            // --------------------------------------------------

            if (error) {

              console.error(
                "❌ MATLAB error:",
                error
              );

              return send(
                res,
                500,
                {
                  error:
                    "MATLAB inference failed",

                  details:
                    stderr ||
                    error.message,
                }
              );
            }


            // --------------------------------------------------
            // RESULT CHECK
            // --------------------------------------------------

            if (
              !fs.existsSync(
                jsonPath
              )
            ) {

              return send(
                res,
                500,
                {
                  error:
                    "MATLAB completed but no result was produced",
                }
              );
            }


            // --------------------------------------------------
            // READ MATLAB RESULT
            // --------------------------------------------------

            let result;

            try {

              result =
                JSON.parse(
                  fs.readFileSync(
                    jsonPath,
                    "utf8"
                  )
                );

            } catch (
              parseError
            ) {

              return send(
                res,
                500,
                {
                  error:
                    "Could not read MATLAB result",

                  details:
                    parseError.message,
                }
              );
            }


            // ==================================================
            // EVIDENCE ENGINE
            // ==================================================

            const evidence =
              buildEvidenceSummary(
                result
              );

            result.evidence =
              evidence;


            // ==================================================
            // LOAD STRUCTURAL OVERLAY
            // ==================================================

            if (
              result.overlayPath &&
              fs.existsSync(
                result.overlayPath
              )
            ) {

              result.overlay =
                fs
                  .readFileSync(
                    result.overlayPath
                  )
                  .toString(
                    "base64"
                  );
            }
             // --------------------------------------
// BUILD AI EVIDENCE SUMMARY
// --------------------------------------

try {
  result.evidence = buildEvidenceSummary(result);

  console.log("\n🧠 AI EVIDENCE ENGINE");
  console.log(
    "Evidence findings:",
    result.evidence.findings.length
  );
  console.log(
    "Evidence summary generated successfully"
  );
} catch (evidenceError) {
  console.error(
    "⚠️ Evidence engine failed:",
    evidenceError.message
  );

  result.evidence = {
    title: "AI Evidence Summary",
    disclaimer:
      "Evidence summary unavailable for this screening.",
    escalation:
      "Clinical review should rely on the available screening outputs.",
    findings: [],
  };
}

            // ==================================================
            // SAVE TO RETINA PASSPORT
            // ==================================================

            let passportSaved =
              false;

            let screeningId =
              null;


            if (
              request.patientId
            ) {

              try {

                const patient =
                  await Patient.findOne(
                    {
                      patientId:
                        request.patientId,
                    }
                  );


                if (!patient) {

                  return send(
                    res,
                    404,
                    {
                      error:
                        "AI analysis completed, but patient was not found",

                      patientId:
                        request.patientId,
                    }
                  );
                }


                // ----------------------------------------------
                // TRIAGE
                // ----------------------------------------------

                const triage =
                  calculateTriage(
                    result
                  );


                console.log(
                  "\n🚦 TRIAGE ANALYSIS"
                );

                console.log(
                  "Patient:",
                  request.patientId
                );

                console.log(
                  "Triage Score:",
                  triage.score
                );

                console.log(
                  "Priority:",
                  triage.priority
                );

                console.log(
                  "Action:",
                  triage.action
                );


                // ----------------------------------------------
                // SAVE SCREENING
                // ----------------------------------------------

                const screening =
                  await Screening.create({

                    patientId:
                      request.patientId,

                    imageName:
                      path.basename(
                        imagePath
                      ),

                    drGrade:
                      result.drGrade,

                    drLabel:
                      result.drLabel,

                    vesselPercentage:
                      result.vesselPercentage,

                    lesionFindings:
                      result.lesionCounts,

                    imageQuality: {

                      isGradeable:
                        result.isGradeable,

                      qualityScore:
                        result.qualityScore,

                      qualityMessage:
                        result.qualityMessage,
                    },

                    riskScore:
                      result.riskScore,

                    referral:
                      result.referral,

                    structuralOverlay:
                      result.overlayPath,

                    screenedAt:
                      new Date(),
                  });


                passportSaved =
                  true;

                screeningId =
                  screening._id;


                console.log(
                  "🪪 AI result saved to Retina Passport"
                );

                console.log(
                  "Patient:",
                  request.patientId
                );

                console.log(
                  "Screening ID:",
                  screeningId
                );

                console.log(
                  "DR Grade:",
                  result.drGrade
                );

              } catch (
                databaseError
              ) {

                console.error(
                  "❌ Could not save screening:",
                  databaseError
                );

                return send(
                  res,
                  500,
                  {
                    error:
                      "AI analysis completed, but screening could not be saved",

                    details:
                      databaseError.message,
                  }
                );
              }
            }


            // ==================================================
            // FINAL RESPONSE
            // ==================================================

            return send(
              res,
              200,
              {

                ...result,

                passportSaved,

                screeningId,
              }
            );
          }
        );

      } catch (error) {

        console.error(
          "❌ Server request error:",
          error
        );

        return send(
          res,
          400,
          {
            error:
              error.message,
          }
        );
      }
    }
  );


// ============================================================
// START SERVER
// ============================================================

server.listen(
  PORT,
  () => {

    console.log(
      `\n🚀 EYEABETICS backend running on http://localhost:${PORT}`
    );

    console.log(
      "🩺 Health API: http://localhost:5000/api/health"
    );

    console.log(
      "🚦 Triage API: http://localhost:5000/api/triage"
    );

    console.log(
      "🪪 Screening API: http://localhost:5000/api/screenings/:id"
    );

    console.log(
      "📈 Progression API: http://localhost:5000/api/patients/:id/progression"
    );

    console.log(
      "🖼️ File API: http://localhost:5000/api/uploads/:filename"
    );

    console.log(
      "🧠 Evidence Engine: enabled"
    );

    console.log("");
  }
);