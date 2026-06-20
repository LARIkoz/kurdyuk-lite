# Contributing to Kurdyuk Lite

Thanks for your interest — contributions are welcome. Kurdyuk Lite is intentionally small (Bash + Markdown), so most changes are quick to make and review.

## Ways to contribute

- **Report a bug** or **request a feature** → open an [issue](https://github.com/LARIkoz/kurdyuk-lite/issues) using the templates.
- **Improve the docs** (README, concept, examples) → a PR is perfect.
- **Refine the contract or a template** → see the discipline below.

## Before you start

For anything beyond a typo, open an issue first so we can agree on the shape. The framework values a small, sharp surface over breadth — a change that adds a file or a phase needs a clear reason.

## Editing the contract or a charter

`CLAUDE-contract.md` is the single source of the pipeline contract; `CLAUDE.md` is only a thin wrapper that points at it. **Never copy contract rules into `CLAUDE.md`** — that divergence is the bug this layout prevents.

If your change touches a charter (`charter-for-charter.md`, `templates/charter.md`, or an example), obey the meta-charter: **no heuristics, no HOW, every principle is a test, write then cut.**

After editing `CLAUDE-contract.md`, bump `VERSION` (the contract is hash-anchored — `bin/kurdyuk-lite check` detects drift) and add a `CHANGELOG.md` entry.

## Test your change

There is no build step. Verify the installer end-to-end against a throwaway directory:

```bash
TMP="$(mktemp -d)"
bash bin/kurdyuk-lite init "$TMP"
bash bin/kurdyuk-lite check "$TMP"     # expect: Status: UP TO DATE
# re-run init to confirm idempotency: exactly one KURDYUK-LITE-START marker pair
```

Keep `bin/` POSIX-portable (no `sed -i`, no Bash 4-isms) so it works on macOS and Linux.

## Maintainer notes

- **Version badge** reads the latest Git tag (`github/v/tag`) — cut a `vX.Y.Z` tag on release and the README badge updates itself; no manual edit.
- **The phase-pipeline string** ("Brainstorm+Research+Brief → … → Final Review") is restated for humans in `README.md`, `BOOTSTRAP.md`, `concept.md`, `.kurdyuk-lite/STARTER-PROMPT.md`, and `templates/state.md`. `CLAUDE-contract.md` is the source of truth; if the phases ever change, update those restatements too.

## Pull requests

- One focused change per PR; use the PR template.
- Smallest clean diff. No decorative files outside the documented layout.
- Be kind and direct in review — same as the framework's own output style.

By contributing, you agree your work is licensed under the repository's [MIT License](LICENSE).
