# Migration → v3 (Charter-based)

Copy the text between the lines and paste it into your Claude Code session.

---

Migrate this project to Kurdyuk Lite v3.

What changed: v3 replaces the old Review-Cycle pipeline with a charter-driven one —
**Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review**. The **Charter** (a numbered
constitution) is the new centerpiece. Templates changed: `charter` + `spec` + `gate-log` replace
`intent` / `invariants` / `research` / `implementation-readiness`.

1. Update the framework and re-init this project (the managed block in `CLAUDE.md` is replaced in place, your
   project-specific rules outside the markers are preserved, and the old `CLAUDE.md` is backed up):

```bash
git -C ~/.kurdyuk-lite pull --ff-only && chmod +x ~/.kurdyuk-lite/bin/kurdyuk-lite ~/.kurdyuk-lite/bin/kurdyuk-install
~/.kurdyuk-lite/bin/kurdyuk-lite init .
~/.kurdyuk-lite/bin/kurdyuk-lite check .      # expect: Status: UP TO DATE
```

2. After migration:

- Read `CLAUDE.md` — the contract block is now v3.
- Finished v2 runs in `.kurdyuk-lite/runs/` can stay as-is; nothing to port.
- For an active run: you now have `charter.md` and `spec.md` templates. If the run had an `intent.md` /
  `invariants.md`, fold their durable decisions into a proper `charter.md` (constitution, numbered principles),
  then continue from the correct phase.

Repeat step 1 for every project that uses Kurdyuk.

---
