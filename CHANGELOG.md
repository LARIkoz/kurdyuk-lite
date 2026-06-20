# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.3.1] - 2026-06-20

Tooling and a translation fix.

### Added

- Continuous integration: `.github/workflows/test.yml` runs the installer test suite on Linux and macOS for every push and pull request, with a CI badge on the README.
- `test/run.sh` — committed installer test suite (init/check across every `--agent` target, idempotency, drift → `BROKEN`, self-init guard). It is what CI runs and what `CONTRIBUTING.md` now points contributors to.

### Fixed

- Translated READMEs: the "Agents" badge linked to the English `#works-with-any-agent` anchor, which does not exist once the heading is translated. Added an explicit anchor in `README.ru.md` / `README.ja.md` / `README.zh-CN.md` so the badge resolves.

## [3.3.0] - 2026-06-20

Agent self-install + translated READMEs.

### Added

- **Agent self-install.** `BOOTSTRAP.md` is now an agent-neutral runbook: paste one line into any agent (Claude Code / Codex / Gemini CLI) and it picks the matching `--agent`, clones, injects the contract, verifies, and reports a health verdict — no manual steps.
- `kurdyuk-install` accepts `[project-dir]` and `--agent <claude|codex|gemini|all>` in any order, passes the agent through to `init`, and ends with an explicit `HEALTH: <verdict>` line (non-zero exit on anything but `UP TO DATE`) so an agent or CI can detect a bad install.
- Translated READMEs: `README.ru.md` (Русский), `README.ja.md` (日本語), `README.zh-CN.md` (中文), with a flag language-switcher row by the badges in each. English `README.md` is the source; translations may lag it.

### Changed

- `BOOTSTRAP.md`, `kurdyuk-install`, and the in-target `STARTER-PROMPT.md` are agent-neutral (no longer Claude-only).
- README `Install` section leads with the one-line agent self-install; the manual clone and a `curl … | bash` one-liner follow.

## [3.2.0] - 2026-06-20

Multi-agent support.

### Added

- `kurdyuk-lite init --agent <claude|codex|gemini|all>` injects the contract into the right instructions file (`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`). Default stays `claude`.
- `reference/discovery-toolkit.md` — optional, opt-in Phase-1 discovery scaffolds (Jobs-to-be-Done & the job hierarchy, jobs-based segmentation, critical sequence, Four Forces, the Riskiest Assumption Test, a laddering interview). Rewritten in our own words; not copied into target projects by `init`. Indexed in `reference/examples.md`.
- README **Acknowledgements** crediting the methods the framework draws on (Jobs-to-be-Done — Clayton Christensen; the AJTBD synthesis — Ivan Zamesin; the Four Forces — Bob Moesta; the annotation cycle — Boris Tane).

### Changed

- The contract and docs are agent-neutral: Claude Code is the default, but the framework runs on Codex, Gemini, and any agent that reads a project instructions file.
- `kurdyuk-lite check` now verifies the **contract block inside the agent file** (`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`), not just the stored version hash — it reports `UP TO DATE`, `UPDATE AVAILABLE`, `LOCAL EDIT`, or `BROKEN`, so a hand-edited or missing block is caught.
- README version badge is driven by the latest Git tag instead of a hardcoded number.
- `templates/brief.md` names the "market context" field the contract requires.
- `CONTRIBUTING.md` adds maintainer notes (the tag-driven version badge; the files that restate the phase pipeline).

## [3.1.0] - 2026-06-20

First public release.

### Added

- MIT `LICENSE`.
- A worked, self-contained charter example (`reference/example-charter.md`) and a research-pipeline charter variant.
- Public-facing `README` with a Jobs-to-be-Done framing of the job the framework closes.
- Community & machine-readability files: `CONTRIBUTING`, `CODE_OF_CONDUCT`, `SECURITY`, `CHANGELOG`, `llms.txt`, issue/PR templates.

### Changed

- Genericized the docs for a public audience (removed internal product and pipeline references).

## [3.0.1] - 2026-06-20

Fixes from a multi-dimension adversarial audit.

### Added

- `init` now copies the in-target `README.md` and `STARTER-PROMPT.md` so the documented "paste the starter prompt" step resolves after a clean install.
- A guard refusing `init` onto the framework repo itself (it used to corrupt the wrapper `CLAUDE.md`).
- Contract: an explicit Phase-5 readiness checklist, a rejected-gate procedure, a `/compact`-resume rule, and run-folder materialization details.

### Changed

- `kurdyuk-install` and `MIGRATION` use `git pull --ff-only` (no silent stale update / false "UP TO DATE").
- Moved `charter-product-discovery` out of `templates/` into `reference/` (it was an undocumented template that shipped into every target).
- `spec.md` template gained the Data Model / API Shape section the contract requires.

## [3.0.0] - 2026-06-20

Charter-based framework.

### Added

- Six-phase pipeline: Brief → Charter → Spec → Plan → Implement → Final Review.
- `CLAUDE-contract.md` as the single canonical contract, injected by `bin/kurdyuk-lite init`; `CLAUDE.md` is a thin wrapper that points at it.
- `concept.md`, `charter-for-charter.md`, and the v3 template set.

### Changed

- Replaced the v2 "Review Cycle + Readiness" model with the charter-driven pipeline.

[3.3.1]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.3.1
[3.3.0]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.3.0
[3.2.0]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.2.0
[3.1.0]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.1.0
[3.0.1]: https://github.com/LARIkoz/kurdyuk-lite/commits/main
[3.0.0]: https://github.com/LARIkoz/kurdyuk-lite/commits/main
