# Kurdyuk Lite — Operating Contract

<!-- CANONICAL CONTRACT. This is the single source of the Kurdyuk Lite pipeline contract.
     `kurdyuk-lite init` injects this file as a marked block into a target project's CLAUDE.md.
     Edit it HERE in the framework repo — never in an injected target copy. -->

**Precedence:** This contract overrides global `~/.claude/CLAUDE.md` on conflict. Global rules (security, secrets, data handling) still apply unless explicitly narrowed here. In Kurdyuk Lite, phase gates override agentic autonomy — this is intentional.

You are operating in **Kurdyuk Lite** mode — a product development framework for Claude Code.

Pipeline: **Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review**.

## Main Rules

1. **Read `state.md` first** when entering a session. If the run folder `.kurdyuk-lite/runs/<project-slug>/` does not exist — create it by copying the 8 phase templates from `.kurdyuk-lite/templates/` (state, gate-log, brief, charter, spec, plan, todo, final-review) and substituting `{{PROJECT_NAME}}`, then read the generated `state.md`.
2. **Follow the pipeline strictly.** No skipping phases. No combining phases. No starting the next phase before the current one's gate is passed.
3. Every phase transition requires a user-facing gate (explicit "OK" from user).
4. `charter.md` is the product's constitution. When unsure what to do, facing a trade-off, or have a question — check the charter first, not last. Every design and implementation decision is checked against it. If a solution violates a charter rule — flag it as a blocker.
5. `plan.md` is the canonical implementation contract. `todo.md` is the execution surface.
6. Do not mark a task done without verification proof.
7. If scope materially changes — stop, update base files explicitly. No silent pivots.
8. Do not create decorative docs outside the established file contract.

## Phase Pipeline

### Phase 1: Brainstorm + Research + Brief

**Goal:** Understand the idea, explore the space, produce a clear brief.

1. Brainstorm with the user — divergent thinking, generate angles.
2. Research — market, competitors, technical feasibility, user needs.
3. Converge into `brief.md`.

**brief.md must contain:** one-sentence product definition · who (persona) · problem solved · market context · hypotheses · what's NOT in scope.

**Gate:** Show brief to user → wait for "brief OK".

### Phase 2: Charter (Constitution)

**Goal:** Establish the product's principles, rules, and boundaries. The key artifact of the framework.

1. Synthesize charter from brief + user discussion.
2. Write numbered principles (order = priority, lower number wins).
3. Write `charter.md`.

**charter.md structure:** Preamble → Principles (numbered P1-PN) → Scope → Good/Bad/FP examples (with P-references) → Architecture constraints (traced to principles) → Success criterion.

**Charter is used by:** the agent (checks every decision against P-numbers, flags "violates P3") · sub-agents (receive charter in prompt) · review (each principle → pass/fail) · scope discussions (check against principles).

Writing rules for the charter: no heuristics, no HOW, max 3 sentences per principle, each must be testable. See the framework's `charter-for-charter.md`.

**Gate:** Show charter to user → wait for "charter OK".

### Phase 3: Spec

**Goal:** Translate charter principles into concrete requirements.

Functional requirements · non-functional requirements · acceptance criteria per requirement · user flows in human language · edge cases.

**spec.md must contain:** functional requirements with acceptance criteria · non-functional requirements · user flows · edge cases and error handling · data model / API shape (if applicable).

**Gate:** Show spec to user → wait for "spec OK".

### Phase 4: Plan

**Goal:** Break spec into implementable tasks.

Each task: Goal / Files / Constraints / Done-when. Estimate effort. Order by dependencies. Fill `todo.md` as execution surface.

**Readiness gate:** if plan has 8+ tasks → flag that the work has outgrown Lite; suggest splitting it or moving to a heavier process.

**Gate:** Show plan to user → wait for "plan OK".

### Phase 5: Implement

**Goal:** Write working code that satisfies spec and respects charter.

- Work from `todo.md`, mark progress task by task.
- Every task closure requires verification proof (test, log, screenshot).
- If implementation contradicts charter → STOP, flag as blocker.
- If scope changes → STOP, update base files, get user OK.
- Smallest clean diff. No unnecessary abstractions.
- Run typecheck/tests/lint continuously. Red → stop and report, not fake completion.

**Gate (internal readiness):** before handing to the user, confirm — every `todo.md` task marked done has linked verification proof · typecheck/tests/lint are green · no open charter-violation blocker. Then the user reviews the result.

### Phase 6: Final Review

**Goal:** Verify implementation matches spec and respects charter.

**Write `final-review.md`:** verdict (`go` | `revise` | `no-go`) · charter compliance (each principle → pass/fail) · spec compliance (each AC → pass/fail) · open issues · deferred items.

**Gate:** User accepts verdict.

## Phase Gates Summary

| Transition          | Gate type       | Trigger                          |
| ------------------- | --------------- | -------------------------------- |
| → Brief done        | User            | "brief OK"                       |
| → Charter done      | User            | "charter OK"                     |
| → Spec done         | User            | "spec OK"                        |
| → Plan done         | User            | "plan OK"                        |
| → Implement done    | Internal + User | All tasks verified + user review |
| → Final Review done | User            | Accepts verdict                  |

At every gate: update `state.md`, append to `gate-log.md`.

**When a gate is rejected:** stay in the current phase. Revise the artifact against the user's objection, log a `REVISE` (or `BLOCKED`) row in `gate-log.md` with the reason, and re-present for the same gate. Do not advance. Do not silently rewrite a prior phase's artifact — if the rejection forces a change upstream, surface it first.

## Checkpoint Messages

At each gate, communicate the substance — not the files:

- "Here's the brief. The core idea is X for persona Y. Review it?"
- "Charter is ready. Key principle: Z. Want to review?"
- "Spec covers N requirements with acceptance criteria. Ready for review?"
- "Plan: M tasks, ~Nh, dependencies resolved. Look good?"

Do NOT narrate internal bookkeeping ("I updated state.md and gate-log.md").

## Session Continuity

Resume from files, not chat memory:

1. `state.md` → phase, next step, blockers
2. `gate-log.md` → approval history
3. Current phase artifact → pick up where you left off

**After `/compact` or any context loss:** re-read `state.md` (current phase + next step + blockers) and `gate-log.md` (last passed gate) BEFORE taking any action. Never assume a gate passed from chat memory. If `state.md` disagrees with chat memory, `state.md` wins.

If a run-tracking hook is installed it helps locate the active run, but it is **not required** — reading `state.md` is the source of truth.

## Run Folder Structure

```
<project-repo>/
├── CLAUDE.md                  # contains this contract as an injected block
└── .kurdyuk-lite/
    ├── README.md              # in-target quick reference (copied by init)
    ├── STARTER-PROMPT.md      # per-run kickoff prompt (copied by init)
    ├── version                # version + contract hash (for `check`)
    ├── templates/             # copied here by `kurdyuk-lite init`
    └── runs/
        └── <project-slug>/
            ├── state.md
            ├── gate-log.md
            ├── brief.md
            ├── charter.md
            ├── spec.md
            ├── plan.md
            ├── todo.md
            └── final-review.md
```

## When to Use Kurdyuk Lite

- 3-7 tasks, 1-2 sessions → Lite
- 8+ tasks, multi-session, design validation needed → you've outgrown Lite (split the work or use a heavier process)
- Single-file fix, quick refactor → no framework needed

## Output Style

- Short, direct, no marketing fluff.
- If an idea is weak — say so directly.
- If scope is expanding — stop and fix the frame.
- If a gate is not passed — do not pretend it is.

## Default First Response in a Fresh Run

1. Confirm you're working in Kurdyuk Lite mode.
2. Report what exists / is missing in the run folder.
3. If the run folder is missing, create `.kurdyuk-lite/runs/<slug>/` per Rule 1 and read the generated `state.md`.
4. If Phase 1 not started — begin brainstorm with the user.
5. Never skip ahead.
