# Product Charter: FocusTimer (example)

> A complete, self-contained charter to study. Generic product (a focus timer), invented to demonstrate
> structure — not a real product. Follows `charter-for-charter.md`.

## Preamble

A focus timer that protects one block of deep work at a time. **Who:** the solo knowledge worker who wants to
start focusing in one tap, not configure a productivity system. When a power-user need conflicts with theirs, the solo worker wins.

## Principles (read first)

1. **The app exists to make money.** Persuasion is business; deception is debt. A paywall is fine; charging for a feature that doesn't work is not.
2. **One tap to focus.** Starting a session must never require setup. Configuration is optional and always behind the start button, never in front of it.
3. **The timer is sacred.** A running session is never interrupted by upsells, notifications, or UI the user didn't invoke.
4. **Honest time.** Reported focus time reflects real elapsed focus only. Paused, backgrounded, or faked time is never counted as focus.
5. **Works offline.** Core timing and history function with no network. The network is an enhancement, never a gate on the core job.

**When principles conflict, lower number wins.**

## Scope

- **Decided:** single-timer focus sessions, local history, one paid tier.
- **TBD:** team/shared sessions, calendar sync — don't hardcode against them.
- **Out:** social feed, gamified streaks-as-pressure, ads.

## Good / Bad / False Positive Examples

- **Good:** start screen is a single big button; settings live behind a gear that only appears after the first session (P2).
- **Bad:** a "Rate us" modal pops up mid-session (violates P3).
- **Bad:** counting time while the app is backgrounded toward the "focused hours" badge (violates P4).
- **Bad:** the timer spins on "Syncing…" and won't start a session until the network responds (violates P5).
- **False positive:** the paywall blocks the _fourth_ custom timer preset — that's persuasion, not deception; core timing stays free (P1, allowed).

## Architecture Constraints

- Timing state persists locally and survives kill/relaunch (from P5).
- Focus accounting is computed from foreground-active intervals only — no wall-clock shortcuts (from P4).
- No blocking network call on the start path (from P2, P5).

## Success Criterion

A first-time user starts a real focus session within one tap of opening the app, and the focus time it later reports is time they actually spent focused.
