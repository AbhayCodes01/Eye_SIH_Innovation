import http from "http";
import fs from "fs";
import path from "path";
import { execFile } from "child_process";

const PORT = 5000;

const ROOT = "C:\\Users\\KIIT\\Downloads\\Eyeabetics";
const UPLOAD_DIR = path.join(ROOT, "website", "backend", "uploads");
const MATLAB_SCRIPT = path.join(ROOT, "website", "backend", "web_inference.m");

fs.mkdirSync(UPLOAD_DIR, { recursive: true });

function send(res, status, data) {
  res.writeHead(status, {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  });

  res.end(JSON.stringify(data));
}

const server = http.createServer((req, res) => {

  if (req.method === "OPTIONS") {
    res.writeHead(204, {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "Access-Control-Allow-Headers": "Content-Type",
    });
    return res.end();
  }

  if (req.method !== "POST" || req.url !== "/api/analyze") {
    return send(res, 404, { error: "Endpoint not found" });
  }

  let body = "";

  req.on("data", chunk => {
    body += chunk;
  });

  req.on("end", () => {

    try {
      const request = JSON.parse(body);

      if (!request.image) {
        return send(res, 400, { error: "No image supplied" });
      }

      const match = request.image.match(/^data:image\/([a-zA-Z0-9.+-]+);base64,(.+)$/);

      if (!match) {
        return send(res, 400, { error: "Invalid image format" });
      }

      const extension = match[1] === "jpeg" ? "jpg" : match[1];

      const imagePath = path.join(
        UPLOAD_DIR,
        `fundus_${Date.now()}.${extension}`
      );

      const jsonPath = imagePath + ".json";

      fs.writeFileSync(
        imagePath,
        Buffer.from(match[2], "base64")
      );

      console.log("\n=================================");
      console.log("EYEABETICS ANALYSIS");
      console.log("Image:", imagePath);
      console.log("=================================\n");

      const matlabCommand =
        `web_inference('${imagePath.replace(/\\/g, "/")}','${jsonPath.replace(/\\/g, "/")}')`;

      execFile(
  "C:\\Program Files\\MATLAB\\R2026a\\bin\\matlab.exe",
        ["-batch", matlabCommand],
        {
          windowsHide: true,
          timeout: 120000
        },
        (error, stdout, stderr) => {

          console.log(stdout);

          if (stderr) {
            console.log(stderr);
          }

          if (error) {
            console.error(error);
            return send(res, 500, {
              error: "MATLAB inference failed",
              details: stderr || error.message
            });
          }

          if (!fs.existsSync(jsonPath)) {
            return send(res, 500, {
              error: "MATLAB completed but no result was produced"
            });
          }

          try {
            const result = JSON.parse(
              fs.readFileSync(jsonPath, "utf8")
            );

            if (result.overlayPath && fs.existsSync(result.overlayPath)) {
              result.overlay = fs
                .readFileSync(result.overlayPath)
                .toString("base64");
            }

            return send(res, 200, result);

          } catch (e) {
            return send(res, 500, {
              error: "Could not read MATLAB result",
              details: e.message
            });
          }
        }
      );

    } catch (e) {
      return send(res, 400, {
        error: e.message
      });
    }
  });
});

server.listen(PORT, () => {
  console.log(`\nEYEABETICS backend running on http://localhost:${PORT}`);
});