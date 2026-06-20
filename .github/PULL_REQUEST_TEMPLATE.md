## What and why

Briefly: what does this change, and what job does it serve? Link any related issue (`Closes #N`).

## Checklist

- [ ] One focused change; smallest clean diff.
- [ ] If it touches `CLAUDE-contract.md`: bumped `VERSION` and added a `CHANGELOG.md` entry.
- [ ] If it touches a charter doc/template: respects the meta-charter (no heuristics, no HOW, testable, write then cut).
- [ ] Verified the installer end-to-end: `bin/kurdyuk-lite init` into a throwaway dir, then `check` reports `UP TO DATE`.
- [ ] `bin/` stays POSIX-portable (macOS + Linux).
- [ ] No internal/private content; docs stay generic.
