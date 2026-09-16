import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

export const sha256 = (value) => createHash("sha256").update(value).digest("hex");
export const DISTRIBUTION_FILES = [
  ".github/workflows/verify.yml",
  "LICENSE",
  "README.md",
  "metadata.yaml",
  "scripts/verify.mjs",
  "template.tpl",
];

export function metadata(versions) {
  return [
    'homepage: "https://siteos.sh"',
    'documentation: "https://github.com/pixel-point/siteos-gtm-cookie#installation"',
    versions.length ? "versions:" : "versions: []",
    ...versions.flatMap(({ sha, changeNotes }) => [
      `  - sha: ${sha}`,
      `    changeNotes: ${JSON.stringify(changeNotes)}`,
    ]),
    "",
  ].join("\n");
}

export function validateVersions(versions) {
  assert.ok(Array.isArray(versions), "versions must be an array");
  const seen = new Set();
  for (const version of versions) {
    assert.match(version.sha, /^[a-f0-9]{40}$/, "invalid distribution commit SHA");
    assert.match(version.templateSha256, /^[a-f0-9]{64}$/, "invalid template hash");
    assert.ok(
      typeof version.changeNotes === "string" && version.changeNotes.trim(),
      "missing notes",
    );
    assert.ok(!seen.has(version.sha), "duplicate version SHA");
    seen.add(version.sha);
  }
}

export function validateTemplate(template) {
  const section = (name, next) => JSON.parse(template.split(name)[1].split(next)[0]);
  const info = section("___INFO___", "___TEMPLATE_PARAMETERS___");
  assert.equal(info.type, "TAG");
  assert.ok(info.containerContexts.includes("WEB"));
  assert.ok(info.categories?.includes("TAG_MANAGEMENT"), "missing Gallery category");
  const thumbnail = Buffer.from(info.brand.thumbnail.split(",")[1], "base64");
  assert.equal(thumbnail.subarray(1, 4).toString(), "PNG");
  assert.ok(thumbnail.length < 50 * 1024, "thumbnail exceeds Gallery limit");
  const width = thumbnail.readUInt32BE(16);
  assert.equal(width, thumbnail.readUInt32BE(20));
  assert.ok(width >= 48 && width <= 96, "invalid thumbnail size");
  section("___TEMPLATE_PARAMETERS___", "___SANDBOXED_JS_FOR_WEB_TEMPLATE___");
  section("___WEB_PERMISSIONS___", "___TESTS___");
  assert.ok(template.includes("___TESTS___"), "missing GTM tests");
}

export function verify(root, { release = false } = {}) {
  root = fs.realpathSync(root);
  const manifest = JSON.parse(fs.readFileSync(path.join(root, "publication.json"), "utf8"));
  assert.equal(manifest.schemaVersion, 1);
  validateVersions(manifest.versions);
  assert.deepEqual(
    Object.keys(manifest.files).sort(),
    [...DISTRIBUTION_FILES].sort(),
    "invalid distribution file set",
  );
  for (const [name, hash] of Object.entries(manifest.files)) {
    assert.ok(!path.isAbsolute(name) && !name.split("/").includes(".."), "unsafe manifest path");
    const file = path.join(root, name);
    assert.equal(fs.realpathSync(file), file, "symlinks are not allowed");
    assert.ok(fs.lstatSync(file).isFile(), "distribution files must be regular files");
    assert.equal(sha256(fs.readFileSync(file)), hash, `modified distribution file: ${name}`);
  }
  const template = fs.readFileSync(path.join(root, "template.tpl"), "utf8");
  validateTemplate(template);
  assert.equal(
    fs.readFileSync(path.join(root, "metadata.yaml"), "utf8"),
    metadata(manifest.versions),
  );
  for (const version of manifest.versions) {
    const committed = execFileSync("git", ["show", `${version.sha}:template.tpl`], { cwd: root });
    execFileSync("git", ["merge-base", "--is-ancestor", version.sha, "HEAD"], { cwd: root });
    assert.equal(sha256(committed), version.templateSha256, "historical template hash mismatch");
  }
  if (release) {
    assert.ok(manifest.versions.length, "no Gallery version recorded");
    assert.equal(manifest.source.dirty, false, "release requires committed source files");
    assert.match(manifest.source.revision, /^[a-f0-9]{40}$/);
    assert.equal(
      sha256(template),
      manifest.versions[0].templateSha256,
      "current template is unreleased",
    );
  }
  return manifest;
}

if (process.argv[1] && fs.realpathSync(process.argv[1]) === fileURLToPath(import.meta.url)) {
  assert.ok(
    process.argv.slice(2).every((arg) => arg === "--release"),
    "unsupported argument",
  );
  const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
  verify(root, { release: process.argv.includes("--release") });
  console.log("Cookie GTM distribution verified.");
}
