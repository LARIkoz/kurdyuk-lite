# Security Policy

## Supported versions

Kurdyuk Lite ships from `main`; the latest tagged release is the supported version. Older tags are not patched — update to the latest.

## Reporting a vulnerability

Please report security issues **privately**, not in a public issue.

- Preferred: open a [private security advisory](https://github.com/LARIkoz/kurdyuk-lite/security/advisories/new) on this repository.
- We aim to acknowledge a report within a few days and will keep you updated on the fix.

## Scope

Kurdyuk Lite is Bash + Markdown with no network calls and no runtime services. The realistic surface is the installer (`bin/kurdyuk-lite`, `bin/kurdyuk-install`): how it writes into a target repo's `CLAUDE.md`/`.gitignore`, handles paths, and runs `git`. Reports about that — or about anything the framework instructs an agent to execute — are in scope.

Out of scope: vulnerabilities in Claude Code itself, in your shell, or in third-party tools you run alongside the framework.
