# Kurdyuk Lite — Agent Self-Install

This file is a **runbook an AI agent executes**, not a manual for a human. Hand it to your agent and it installs Kurdyuk Lite into your project and reports the result.

## The one line

Paste this into any AI coding agent (Claude Code, Codex, Gemini CLI, …) open in your project:

> **Install Kurdyuk Lite in this repo: follow `https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/BOOTSTRAP.md` — pick the `--agent` that matches you, then run `check` and report the Status line.**

That is the whole install. Everything below is what the agent does — you don't need to read it.

---

## Runbook (the agent follows this)

You are an AI coding agent. Install Kurdyuk Lite into the **current project** and report its health. Do **not** start any product work yet — install and verify only.

### 1. Identify yourself → pick `--agent`

Choose the value that matches the agent you are:

| You are…                                    | `--agent` | File it writes |
| ------------------------------------------- | --------- | -------------- |
| Claude Code                                 | `claude`  | `CLAUDE.md`    |
| Codex — or any agent that reads `AGENTS.md` | `codex`   | `AGENTS.md`    |
| Gemini CLI                                  | `gemini`  | `GEMINI.md`    |
| Genuinely can't tell                        | `all`     | all three      |

### 2. Preflight

```bash
git --version
```

If `git` is missing, stop and tell the user: macOS → `xcode-select --install`; Linux → `sudo apt install git`.

### 3. Install — clone + inject + verify, one command

Substitute your `--agent` from step 1:

```bash
curl -fsSL https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/bin/kurdyuk-install | bash -s -- --agent <YOUR-AGENT> .
```

If `curl` is unavailable or piping to `bash` is not allowed in your environment, do the same by hand:

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
chmod +x ~/.kurdyuk-lite/bin/kurdyuk-lite ~/.kurdyuk-lite/bin/kurdyuk-install
~/.kurdyuk-lite/bin/kurdyuk-lite init . --agent <YOUR-AGENT>
~/.kurdyuk-lite/bin/kurdyuk-lite check .
```

If the clone fails (404 / network), tell the user to check the repo URL and their connection, then retry.

### 4. Report health

The installer ends with a line like:

```
HEALTH: UP TO DATE — Kurdyuk Lite is installed and verified.
```

Show the user that verdict **verbatim**. If it is anything other than `UP TO DATE`, show the full `check` output and stop — do not start Phase 1 on a broken install.

### 5. Hand off to the pipeline

On a clean `UP TO DATE`, tell the user:

> Kurdyuk Lite installed — contract written to `<the agent file>`, health: UP TO DATE. What are we building?

Then read the contract block now in your instructions file and start **Phase 1 (Brainstorm + Research + Brief)**. The pipeline is strict — `Brief → Charter → Spec → Plan → Implement → Final Review`, each phase gated by an explicit user "OK". The Charter (Phase 2) is the product's constitution; every later decision is checked against it. Do not skip ahead.

Kurdyuk Lite runs single-context — no extra CLI agents, no additional setup.
