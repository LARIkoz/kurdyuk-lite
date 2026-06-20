# Kurdyuk Lite — in your project

This folder is what Kurdyuk Lite looks like **inside a target repo** after `kurdyuk-lite init`. A practical,
Claude-first Lite process you can drop into any repo. Not full orchestration, not a multi-agent circus.

## Good for

- running an idea / feature / internal tool through a real thinking flow before coding;
- not losing context in a long chat;
- making Claude think → charter → spec → plan → then code.

## Not for

- heavy multi-model review cycles, or many-task multi-session work;
- complex multi-agent orchestration.

## Structure in the target repo

```text
<your-repo>/
├── CLAUDE.md                  # contract injected as a marked block
└── .kurdyuk-lite/
    ├── README.md
    ├── STARTER-PROMPT.md
    ├── templates/
    │   ├── state.md
    │   ├── gate-log.md
    │   ├── brief.md
    │   ├── charter.md
    │   ├── spec.md
    │   ├── plan.md
    │   ├── todo.md
    │   └── final-review.md
    └── runs/
        └── <project-slug>/
```

## Install

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
~/.kurdyuk-lite/bin/kurdyuk-lite init .
~/.kurdyuk-lite/bin/kurdyuk-lite check .      # expect: Status: UP TO DATE
```

Then open Claude in this repo and paste `STARTER-PROMPT.md`, or just describe your idea.

## The flow

1. **Brief** — brainstorm + research → `brief.md`.
2. **Charter** — the constitution (numbered principles) → `charter.md`. The key artifact.
3. **Spec** — requirements + acceptance criteria → `spec.md`.
4. **Plan** — tasks + dependencies → `plan.md` / `todo.md`.
5. **Implement** — execute from `todo.md`, verify each task.
6. **Final review** — verdict `go | revise | no-go` → `final-review.md`.

## Hard rules

- `state.md` first, everything else second.
- `charter.md` is the constitution — check it first when unsure, not last.
- `plan.md` = contract. `todo.md` = execution surface.
- No silent scope changes — surface a material change back into the base files.
- Pass every gate explicitly. Don't pretend a gate passed.
