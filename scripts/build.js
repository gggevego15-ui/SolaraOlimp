const fs = require("node:fs");
const path = require("node:path");

const root = process.cwd();
const output = path.join(root, "dist");
const requiredFiles = ["index.html", "_headers", "_redirects"];

for (const file of requiredFiles) {
  if (!fs.existsSync(path.join(root, file))) {
    throw new Error(`Required deployment file is missing: ${file}`);
  }
}

const html = fs.readFileSync(path.join(root, "index.html"), "utf8");
if (!html.includes('const API_URL="https://husjlwgohxtatgguzdjm.supabase.co/functions/v1/olimp-api"')) {
  throw new Error("Production Supabase API URL is missing or unexpected");
}
if (!/const API_KEY="sb_publishable_[^"]+"/.test(html)) {
  throw new Error("Supabase publishable key is missing");
}

fs.rmSync(output, { recursive: true, force: true });
fs.mkdirSync(output, { recursive: true });
for (const file of requiredFiles) {
  fs.copyFileSync(path.join(root, file), path.join(output, file));
}

const deployedFiles = fs.readdirSync(output).sort();
if (deployedFiles.some((file) => file === "supabase" || file === ".github" || file === "README.md")) {
  throw new Error("Internal project files must not be included in the public deployment");
}
console.log(`Static site bundle ready: ${deployedFiles.join(", ")}`);
console.log(`index.html: ${fs.statSync(path.join(output, "index.html")).size} bytes`);
