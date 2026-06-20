# Kurdyuk Lite — Framework Concept

## What is Kurdyuk Lite

A lightweight product development framework for Claude Code. Designed for projects with 3-7 tasks that fit in a single context window (no subagent-per-task orchestration).

Kurdyuk Lite enforces a strict phase pipeline: every product goes through brainstorm, charter, spec, plan, implementation, and review — in order, with gates between phases. No skipping.

**Not for:** single-file fixes, quick refactors, one-off scripts. Those don't need a framework.
**You've outgrown Lite when:** 8+ tasks, multi-session work, or you need dedicated design-validation gates.

## Core Philosophy

1. **Charter is the soul.** Every product gets a charter (constitution) before any code. The charter defines WHY, for WHOM, and WHAT MATTERS — not what to build, but what principles guide every decision. All subsequent artifacts (spec, plan, code) are checked against the charter.

2. **Phases are non-negotiable.** The agent cannot skip phases or combine them. Brief before charter. Charter before spec. Spec before plan. Plan before code. Each phase produces a concrete artifact. Each transition requires a gate.

3. **Artifacts over chat.** Decisions live in files, not in conversation history. A new session reads `state.md` and picks up where the last one left off. Chat is ephemeral; artifacts are permanent.

4. **User gates at every phase.** The agent proposes; the user approves. No silent transitions. The agent says "brief is ready, review it" and waits. Not "I wrote the brief and moved on to charter."

5. **Lite means focused, not shallow.** Few templates, but each one matters. No decorative docs. Every file in the run folder earns its place.

## The Pipeline

```
Brainstorm + Research + Brief  →  Charter  →  Spec  →  Plan  →  Implement  →  Final Review
         Phase 1                  Phase 2     Phase 3   Phase 4    Phase 5       Phase 6
```

Phase details (goal, process, artifact, gate) → see `CLAUDE-contract.md` § Phase Pipeline. Not duplicated here.

## Charter for Charter

Core principles for writing charters → `charter-for-charter.md` (SSOT, 4 rules).

### Structure rules

How to assemble a charter once the principles are written:

1. **Revenue near the top.** Product exists to make money. If charter doesn't say this — agents will optimize for free UX and kill the business.
2. **Close the Murphy loophole.** For every principle, ask: "how will someone misuse this to justify a bad decision?" If the answer is obvious — add one sentence that closes it.
3. **Examples cite principles.** Every Good/Bad/FP example references P-numbers. "(P3, P5)" or "(violates P4)." Examples without P-references are decoration.
4. **Architecture traces to principles.** Every constraint says where it came from: "(from P1, P5)." Orphan constraint = either missing principle or unnecessary constraint.
5. **One success criterion.** One sentence. Testable. If this is true — the product works.

### Charter structure

```
Preamble          — one sentence + who (primary persona, who wins on conflict)
Principles        — numbered, ordered, 5-21
Scope             — decided / TBD / out
Good/Bad/FP       — concrete cases with P-references
Arch Constraints  — from principles, traced
Success Criterion — one testable statement
```

Optional: Key Terms, Does NOT Do, Relationship to Siblings.

### How charter is used

- **Agent:** checks every decision against P-numbers. Flags blockers as "violates P3."
- **Sub-agents:** receive charter in prompt. Check output against principles.
- **Review:** final review = each principle → pass/fail.
- **Scope:** "does this align?" = check against principles, not feelings.

### Reference charters

See `reference/examples.md` for full descriptions.

- `reference/example-charter.md` — a complete worked example (read this first)
- `charter-for-charter.md` — the meta-charter (4 rules)
- `reference/charter-product-discovery-example.md` — the research-pipeline charter variant

Run folder structure and session continuity → see `CLAUDE-contract.md` §§ Run Folder Structure, Session Continuity.

## When You Outgrow Lite

Lite is deliberately small. When the work gets bigger, here's what "bigger" looks like — split the work, or move to a heavier process.

|               | Kurdyuk Lite                 | A heavier process                |
| ------------- | ---------------------------- | -------------------------------- |
| Scope         | 3-7 tasks, 1-2 sessions      | 8+ tasks, multi-session          |
| Key artifact  | Charter                      | Charter + design + validation    |
| Research      | Single pass (in brief phase) | Deep (tech + market + synthesis) |
| Design        | Embedded in spec             | Separate phase + validation gate |
| Orchestration | Single context               | Subagent per task                |
