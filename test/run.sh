#!/usr/bin/env bash
# Kurdyuk Lite — installer test suite (run by CI and by contributors).
# Exercises init/check across every --agent target, idempotency, drift
# detection, and the self-init guard. Exit code = number of failed checks.
#
# Usage: bash test/run.sh
set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$SCRIPT_DIR/.." && pwd)"
KL="$REPO/bin/kurdyuk-lite"

PASS=0
FAIL=0
ok()  { printf '  ok:   %s\n' "$1"; PASS=$((PASS + 1)); }
bad() { printf '  FAIL: %s\n' "$1"; FAIL=$((FAIL + 1)); }
mktmp() { mktemp -d 2>/dev/null || mktemp -d -t kltest; }

echo "Kurdyuk Lite installer test"
echo "  source: $REPO"
echo ""

[ -x "$KL" ] || chmod +x "$KL" 2>/dev/null || true

# 1. --agent matrix writes the right instruction file and verifies clean.
for pair in "claude:CLAUDE.md" "codex:AGENTS.md" "gemini:GEMINI.md"; do
  agent="${pair%%:*}"
  want="${pair##*:}"
  t="$(mktmp)"
  if "$KL" init "$t" --agent "$agent" >/dev/null 2>&1; then
    [ -f "$t/$want" ] && ok "init --agent $agent -> $want" || bad "init --agent $agent: $want missing"
    "$KL" check "$t" 2>&1 | grep -q "UP TO DATE" && ok "check $agent -> UP TO DATE" || bad "check $agent: not UP TO DATE"
  else
    bad "init --agent $agent exited non-zero"
  fi
  rm -rf "$t"
done

# 2. --agent all writes all three files.
t="$(mktmp)"
"$KL" init "$t" --agent all >/dev/null 2>&1
for f in CLAUDE.md AGENTS.md GEMINI.md; do
  [ -f "$t/$f" ] && ok "all -> $f" || bad "all -> $f missing"
done
rm -rf "$t"

# 3. Idempotency: re-running init keeps exactly one marker pair.
t="$(mktmp)"
"$KL" init "$t" >/dev/null 2>&1
"$KL" init "$t" >/dev/null 2>&1
n="$(grep -c 'KURDYUK-LITE-START' "$t/CLAUDE.md" 2>/dev/null || echo 0)"
[ "$n" = "1" ] && ok "idempotent re-init (one marker pair)" || bad "re-init left $n marker pair(s)"
rm -rf "$t"

# 4. Drift detection: a second marker pair makes check report BROKEN.
t="$(mktmp)"
"$KL" init "$t" >/dev/null 2>&1
printf '\n<!-- KURDYUK-LITE-START 9.9.9 -->\nx\n<!-- KURDYUK-LITE-END -->\n' >> "$t/CLAUDE.md"
"$KL" check "$t" 2>&1 | grep -q "BROKEN" && ok "drift -> BROKEN detected" || bad "drift not detected"
rm -rf "$t"

# 5. Self-init guard: refuse to init the framework repo onto itself.
if "$KL" init "$REPO" >/dev/null 2>&1; then
  bad "self-init guard did NOT trigger (framework repo would be corrupted)"
else
  ok "self-init guard refuses the framework repo"
fi

echo ""
echo "RESULT: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit "$FAIL"
