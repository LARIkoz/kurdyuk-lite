# Kurdyuk Lite — Framework Source Repo

This repository **is** the Kurdyuk Lite framework. You are editing the framework itself, not using it.

## The contract lives in one place

`CLAUDE-contract.md` is the **canonical operating contract** — the Brief → Charter → Spec → Plan → Implement
→ Final Review pipeline. `kurdyuk-lite init` injects it as a marked block into a target project's `CLAUDE.md`.

**One source of truth:** edit the contract in `CLAUDE-contract.md`. Never maintain a second copy of the pipeline
rules here — divergence between the two is exactly the bug this layout prevents.

## Map

- `CLAUDE-contract.md` — the operating contract (injected into target projects)
- `concept.md` — framework methodology + charter deep dive
- `charter-for-charter.md` — meta-rules for writing any charter
- `reference/examples.md` — reference charters to study
- `templates/` — the phase templates `init` copies into a target project
- `bin/kurdyuk-lite` — `init` / `check` engine · `bin/kurdyuk-install` — one-command bootstrap
- `README.md` — install + usage · `BOOTSTRAP.md` — paste-into-Claude installer · `MIGRATION.md` — v2→v3 upgrade

## Working in this repo (developing the framework)

- Touching a charter or the contract → obey `charter-for-charter.md`: no heuristics, no HOW, testable, write-then-cut.
- Smallest clean diff. No decorative docs outside the file map above.
- The contract is hash-anchored (`bin/kurdyuk-lite check`) — after editing `CLAUDE-contract.md`, bump `VERSION`.
- Dogfooding (running the pipeline on a product inside this repo) → that run is governed by `CLAUDE-contract.md`; read it.
