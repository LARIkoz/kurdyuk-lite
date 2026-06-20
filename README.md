# Kurdyuk Lite

**A charter-driven product-development framework for Claude Code.**

Stop _chatting_ with your AI agent. Start _directing_ it — through a strict six-phase pipeline with a written constitution at its core.

```
Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review
```

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) [![Version](https://img.shields.io/badge/version-3.1.0-blue.svg)](CHANGELOG.md) [![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md) [![Built for Claude Code](https://img.shields.io/badge/built%20for-Claude%20Code-8A63D2.svg)](https://claude.com/claude-code)

_Bash + Markdown · zero dependencies · works in any repo_

---

## The problem

You open Claude Code with a real product idea. Three hours later you have a pile of half-built features, a goalpost that quietly moved, and an agent that "improved" something you never asked for. The context is gone. The decision you made at 2pm lives nowhere — not in a file, not in the agent's memory after a compaction. You're redoing work the AI already did, because it drifted.

Free-form chat with a capable agent is fast and seductive — and it taxes you: **lost context, scope creep, silent drift, and no trace of _why_ anything was decided.**

## What Kurdyuk Lite does

It puts a **rail** under the work. Six phases, each producing one artifact, each gated by your explicit "OK" before the next begins. No skipping. No combining. No "I'll just start coding."

At the center sits the **Charter** — a short, numbered constitution for the product. Not a spec, not a backlog: the _principles_. Order = priority. Every design and implementation decision is checked against it; a violation is a **blocker**, not a debate.

The agent resumes from **files, not chat memory** — so a `/compact`, a new session, or a week-long gap never loses the thread.

---

## The job this closes

We designed Kurdyuk Lite around one **Big Job** (in the Jobs-to-be-Done sense — the higher goal you're really hiring it for):

> **"Ship a product I can stand behind — built largely with an AI agent — without losing control of it or burning myself out."**

That job has three layers, and the framework serves all three:

- **Functional** — turn an idea into working, coherent software with an agent.
- **Emotional** — feel _in control_, instead of anxious that the agent is quietly wandering off.
- **Social** — produce work you can show a teammate or user and **defend**: "here's _why_ it's built this way."

A Big Job is never fully done by one tool. Under it is the **Core Job** Kurdyuk Lite actually closes:

> **Run a disciplined idea → review process with an AI agent, so nothing important is improvised or lost.**

And the **critical sequence** — the steps you can't skip without the whole thing failing — _are_ the six phases:

| Phase            | The job each phase closes                                              |
| ---------------- | ---------------------------------------------------------------------- |
| **Brief**        | Agree what we're building, for whom, and what's out of scope           |
| **Charter**      | Decide the principles every later call is judged against               |
| **Spec**         | Turn principles into concrete, testable requirements                   |
| **Plan**         | Break the spec into ordered, verifiable tasks                          |
| **Implement**    | Build it, proving each task done — never faking completion             |
| **Final Review** | Verify against charter + spec; deliver a `go / revise / no-go` verdict |

Drop the Charter and the agent optimizes in a vacuum. Drop the gates and scope walks. Each file earns its place.

### Why you'd switch (the four forces)

Moving from _"just chat with the agent"_ to _"direct it through a pipeline"_ is a behavioral switch — and switches obey four forces:

- **Push** — what hurts today: context evaporates, the agent drifts off-task, scope creeps, no record of _why_. Every one is extra work you never planned for.
- **Pull** — what draws you over: context that survives between phases and compactions, decisions pinned in a Charter you can point at, drift caught the instant a choice violates a principle.
- **Habit** — what keeps you on chat: the reflex to start coding immediately, the "I'll just ask the agent" muscle memory, the belief that you'll remember everything.
- **Anxiety** — what makes you hesitate: _will this slow me down? will the Charter turn into bureaucracy? can the agent even follow a process?_

Kurdyuk Lite is deliberately **Lite** to beat the last two: one context, eight Markdown templates, gates that take seconds. The discipline is real; the overhead is not.

> **Honest note.** This is the _design hypothesis_ we built against, framed in the language of Jobs-to-be-Done (the AJTBD school) — **not** validated user research. If you use it, your reality is the real test.

---

## How a run looks

1. **Brief** — you brainstorm with the agent; it converges to `brief.md` (one-line definition, who it's for, what's _not_ in scope) and waits for your "brief OK".
2. **Charter** — it synthesizes numbered principles into `charter.md`. You review the soul of the product before a line of spec exists.
3. **Spec** — principles become functional/non-functional requirements with acceptance criteria, each traced back to a principle.
4. **Plan** — the spec becomes ordered tasks with "done-when" conditions in `plan.md` / `todo.md`.
5. **Implement** — the agent works task by task, proving each one done. If a choice violates the Charter, it stops and flags it.
6. **Final Review** — a verdict against every principle and every acceptance criterion.

Every phase updates `state.md` (the project's truth) and appends to `gate-log.md` (the approval trail). Resume any time by reading those two files.

## The Charter, specifically

A charter is a constitution, written under four rules (see [`charter-for-charter.md`](charter-for-charter.md)): **no heuristics, no HOW, every principle is a test, write then cut.** Numbered, priority-ordered, ≤3 sentences each. A taste, from the worked [`reference/example-charter.md`](reference/example-charter.md):

```
1. The app exists to make money. Persuasion is business; deception is debt.
2. One tap to focus. Starting a session must never require setup.
3. The timer is sacred. A running session is never interrupted by upsells.
4. Honest time. Reported focus time reflects real elapsed focus only.
5. Works offline. Core timing functions with no network.

When principles conflict, lower number wins.
```

Now "should we gate the start screen behind a paywall?" has an answer — _violates P2_ — instead of a meeting.

## Install

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
~/.kurdyuk-lite/bin/kurdyuk-lite init .      # injects the contract into ./CLAUDE.md + copies templates
~/.kurdyuk-lite/bin/kurdyuk-lite check .     # → Status: UP TO DATE
```

`init` is idempotent and non-destructive: it injects a marked block into your project's `CLAUDE.md` (backing up any existing one), drops the templates into `.kurdyuk-lite/`, and updates `.gitignore`. Re-run it to upgrade. Prefer one paste into a fresh chat? See [`BOOTSTRAP.md`](BOOTSTRAP.md).

## Quick start

Open Claude in your repo and either paste `.kurdyuk-lite/STARTER-PROMPT.md` or just say what you want to build. The agent confirms Kurdyuk Lite mode, creates the run folder, and starts Phase 1.

## When to use it

- **3–7 tasks, 1–2 sessions** → Kurdyuk Lite is the sweet spot.
- **8+ tasks, multi-session, design-validation gates** → you've outgrown Lite; split the work or use a heavier process.
- **A one-line fix or quick refactor** → no framework needed. Don't bring a constitution to a typo.

## What's in the box

```
kurdyuk-lite/
├── CLAUDE.md              # thin wrapper → points at the contract
├── CLAUDE-contract.md     # the canonical operating contract (injected into your project)
├── concept.md             # full methodology + charter deep dive
├── charter-for-charter.md # the 4 rules for writing a charter
├── BOOTSTRAP.md           # one-paste installer · MIGRATION.md — upgrade notes
├── bin/                   # kurdyuk-lite (init/check) · kurdyuk-install (bootstrap)
├── reference/             # worked charter examples + optional discovery toolkit (not copied into your project)
└── templates/             # the 8 phase templates init copies into .kurdyuk-lite/templates/
```

## Requirements

[Claude Code](https://claude.com/claude-code) — the CLI, desktop app, or IDE extension. Nothing else: Kurdyuk Lite is just Bash + Markdown.

## Acknowledgements

Kurdyuk Lite is assembled from established methods — named separately so you can go to each source:

- **Jobs-to-be-Done** (Clayton Christensen) — the Big/Core Job framing this README runs on. The applied **AJTBD** synthesis behind the optional Phase-1 scaffolds: **Ivan Zamesin**.
- **Four Forces of switching** (Push / Pull / Habit / Anxiety) — Bob Moesta and the JTBD "switch" school.
- **Riskiest Assumption Test** — lean / MVP practice.
- **Annotation cycle** — the plan-reviewed-in-passes loop (and several Claude Code working patterns) come from **Boris Tane**, ["How I use Claude Code"](https://boristane.com/blog/how-i-use-claude-code/).

Optional Phase-1 discovery scaffolds distilled from the JTBD methods live in [`reference/discovery-toolkit.md`](reference/discovery-toolkit.md) — rewritten in our own words, opt-in, never copied into your project.

## FAQ

**What is Kurdyuk Lite?**
A charter-driven product-development framework for Claude Code. It runs your AI coding agent through six gated phases — Brief → Charter → Spec → Plan → Implement → Final Review — with a numbered "Charter" (the product's constitution) at the center.

**How is it different from just using Claude Code normally?**
Plain chat is open-ended: the agent can skip ahead, drift, and forget. Kurdyuk Lite adds gates (each phase needs your "OK"), a Charter (every decision is checked against written principles), and file-based state (work survives a `/compact` or a new session).

**Does it work with Cursor, Copilot, or other AI agents?**
It's built for Claude Code — `init` injects the contract into your `CLAUDE.md`. The _method_ (phases + charter) is portable, but the installer and templates target Claude Code today.

**Won't the process slow me down?**
The gates take seconds; the Charter is a few lines. The time it saves — not re-doing work the agent drifted away from — is the point. For a one-line fix, skip it.

**Can I add it to an existing project?**
Yes. `init` is non-destructive: it injects a marked block into your existing `CLAUDE.md` (backing it up first) and adds a `.kurdyuk-lite/` folder. Re-run it any time to upgrade.

**Is my code or data sent anywhere?**
No. Kurdyuk Lite is Bash + Markdown with no network calls and no telemetry. It only writes files in your repo; everything else happens inside your own Claude Code session.

**What's a Charter, in one line?**
A short, numbered constitution for your product — order = priority — that turns "should we do X?" into a checkable answer ("violates P2") instead of a debate.

## Contributing

Issues and PRs are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md), the [Code of Conduct](CODE_OF_CONDUCT.md), and the [security policy](SECURITY.md). Version history is in [CHANGELOG.md](CHANGELOG.md).

## License

MIT — see [LICENSE](LICENSE). Use it, fork it, ship with it.
