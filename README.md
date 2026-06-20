# Kurdyuk Lite

Lightweight product development framework for Claude Code. 3-7 tasks, single context, strict phase pipeline.

## Pipeline

```
Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review
```

Every phase produces an artifact. Every transition requires user approval. No skipping.

## Key Idea

**Charter (Constitution)** — a dedicated artifact that defines the product's soul: numbered principles (order =
priority), scope, concrete examples, and one success criterion. Written before any spec or code. Every
subsequent decision is checked against it. How to write one: `charter-for-charter.md`.

## Install

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
~/.kurdyuk-lite/bin/kurdyuk-lite init .       # injects the contract into ./CLAUDE.md + copies templates
~/.kurdyuk-lite/bin/kurdyuk-lite check .      # expect: Status: UP TO DATE
```

Then open Claude in the repo and paste `.kurdyuk-lite/STARTER-PROMPT.md`, or just describe your idea.
One-paste install: see `BOOTSTRAP.md`.

## Structure

```
kurdyuk-lite/
├── CLAUDE.md             # thin wrapper → points at CLAUDE-contract.md
├── CLAUDE-contract.md    # the canonical operating contract (injected into target projects)
├── concept.md            # full methodology + charter deep dive
├── charter-for-charter.md# meta-rules for writing charters
├── README.md             # this file
├── BOOTSTRAP.md          # paste-into-Claude installer
├── MIGRATION.md          # upgrading a v2 Review-Cycle repo to v3
├── VERSION
├── LICENSE
├── bin/
│   ├── kurdyuk-lite      # init / check engine
│   └── kurdyuk-install   # one-command bootstrap
├── reference/            # charters to study (not copied into targets)
│   ├── examples.md
│   ├── example-charter.md
│   └── charter-product-discovery-example.md
└── templates/            # copied into a target project's .kurdyuk-lite/templates/
    ├── state.md  gate-log.md  brief.md  charter.md
    └── spec.md   plan.md      todo.md   final-review.md
```

## When to Use

- **3-7 tasks, 1-2 sessions** → Kurdyuk Lite
- **8+ tasks, multi-session** → you've outgrown Lite; split the work or use a heavier process
- **Single fix, quick refactor** → no framework needed

## Docs

- [concept.md](concept.md) — full methodology, charter structure, phase details
- [charter-for-charter.md](charter-for-charter.md) — how to write a charter
- [reference/examples.md](reference/examples.md) — charters to study
- [CLAUDE-contract.md](CLAUDE-contract.md) — the operating contract
- [MIGRATION.md](MIGRATION.md) — upgrading a v2 Review-Cycle repo to v3

## Requirements

[Claude Code](https://claude.com/claude-code) — the CLI, desktop app, or IDE extension. No other dependencies: Kurdyuk Lite is just Bash + Markdown.

## License

MIT — see [LICENSE](LICENSE).
