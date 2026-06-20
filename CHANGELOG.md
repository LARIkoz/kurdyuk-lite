# Changelog

All notable changes to this project are documented here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.2.0] - 2026-06-20

Multi-agent support.

### Added

- `kurdyuk-lite init --agent <claude|codex|gemini|all>` injects the contract into the right instructions file (`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`). Default stays `claude`.

### Changed

- The contract and docs are agent-neutral: Claude Code is the default, but the framework runs on Codex, Gemini, and any agent that reads a project instructions file.

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

[3.2.0]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.2.0
[3.1.0]: https://github.com/LARIkoz/kurdyuk-lite/releases/tag/v3.1.0
[3.0.1]: https://github.com/LARIkoz/kurdyuk-lite/commits/main
[3.0.0]: https://github.com/LARIkoz/kurdyuk-lite/commits/main
