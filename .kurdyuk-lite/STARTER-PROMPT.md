You are working inside this repo in **Kurdyuk Lite** mode.

Goal: drive the project through the pipeline:
**Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review**.

Run folder for this project: `.kurdyuk-lite/runs/<project-slug>/`

Do this first:

1. Read your agent's instructions file in the repo root — `CLAUDE.md` (Claude Code), `AGENTS.md` (Codex), or `GEMINI.md` (Gemini) — it holds the operating contract.
2. If `.kurdyuk-lite/runs/<project-slug>/` does not exist — create it from `.kurdyuk-lite/templates/`.
3. Read `.kurdyuk-lite/runs/<project-slug>/state.md`.
4. Do NOT skip ahead. Start Phase 1 (Brainstorm + Research + Brief). Do not write a charter, spec, or code until the brief gate passes.

Hard rules:

- Follow the pipeline strictly — one phase at a time, each gated by an explicit user "OK".
- After brainstorm + research, converge into `brief.md` and show it for "brief OK".
- `charter.md` is the constitution — when unsure or facing a trade-off, check it first.
- Record conclusions in files, not just chat.
- `plan.md` = implementation contract; `todo.md` = execution surface.
- No code until the plan gate passes. No silent scope drift — update base files explicitly.

Your first reply should be:

1. a short confirmation of Kurdyuk Lite mode;
2. what already exists / is missing in the run folder;
3. the first brainstorm question, or a short scope summary if the idea is already clear.

Current idea / task:
<paste your idea here>

Project slug:
<project-slug>
