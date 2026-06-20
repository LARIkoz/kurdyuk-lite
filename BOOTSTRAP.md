# Kurdyuk Lite — Bootstrap Prompt

Copy the text between the lines and paste it into any Claude Code session. Claude will do everything.

---

Install Kurdyuk Lite — a framework for structured, charter-driven AI development.

First check git is installed:

```bash
git --version
```

If git is missing — tell the user: "git is required. macOS: `xcode-select --install`. Linux: `sudo apt install git`."

If git is present — run in order:

1. Clone the framework:

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
```

If it fails (404, network) — tell the user to check the repo URL and their connection, then retry.

2. Make the scripts executable:

```bash
chmod +x ~/.kurdyuk-lite/bin/kurdyuk-lite ~/.kurdyuk-lite/bin/kurdyuk-install
```

3. Initialize the current project:

```bash
~/.kurdyuk-lite/bin/kurdyuk-lite init .
```

4. Verify:

```bash
~/.kurdyuk-lite/bin/kurdyuk-lite check .
```

Should print "Status: UP TO DATE".

After install:

- Read `CLAUDE.md` — it now contains the pipeline contract as a marked block.
- Tell the user: "Kurdyuk Lite installed. What are we building?" — and start **Phase 1 (Brainstorm + Research + Brief)**.
- Do NOT skip ahead. The pipeline is strict: Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review. Each phase is gated by an explicit user "OK".
- The charter (Phase 2) is the product's constitution — every later decision is checked against it.

That's it. Kurdyuk Lite runs single-context on Claude Code alone — no extra CLI agents, no additional setup.
