# redesign-director

A [Claude Code](https://claude.com/claude-code) **skill** that directs a full, disciplined
UI/UX **redesign** — screen by screen — instead of ad-hoc UI tweaks.

It orchestrates a repeatable process: **map** the app → build **token foundations** →
produce principled, self-contained **HTML mockups for every screen and every state** →
gather **cited evidence** when it's worth the cost → **revise** → record decisions as
**versioned ADRs** → **iterate with you** one screen at a time, committing each step.

It is a *director*: it composes other skills (reasoning, craft, evidence) rather than
reinventing them, and it stops to **guide you** at every fork instead of guessing.

---

## What's in this repo

| Path | What it is |
|------|-----------|
| `skills/redesign-director/SKILL.md` | The methodology skill (phases, prime directives, house rules) |
| `skills/redesign-director/references/mockup-template.md` | The per-screen mockup contract |
| `hooks/deep-research-cost-guard.sh` | A `PreToolUse` hook that warns + asks before the token-heavy `deep-research` workflow |
| `agents/mockup-designer.md` | Optional subagent: produces one screen mockup (keeps the director's context clean) |
| `settings.snippet.json` | Hook config to merge into your Claude settings |
| `scripts/install.sh` | Copies everything into `~/.claude/` |

Everything here is **original**. No third-party skills or copyrighted book text are bundled
(see [Requirements](#requirements) and [CREDITS](CREDITS.md)).

---

## Requirements

- **Claude Code.** This is a Claude Code skill; it runs inside Claude Code.
- **Built-in skills (nothing to install):** it composes Claude Code's `artifact-design`
  (visual craft) and `deep-research` (evidence). These ship with Claude Code.
- **Optional external skill:** a UX-principles skill (e.g. one grounded in Norman/Cooper/
  Lupton/Lidwell/…) adds a *named-principle citation* layer. **It is not included here and not
  required** — `redesign-director` degrades gracefully and runs without it. Install one
  separately if you have one you're licensed to use.

---

## Install

```bash
./scripts/install.sh
```

This copies:
- `skills/redesign-director/` → `~/.claude/skills/redesign-director/`
- `agents/mockup-designer.md` → `~/.claude/agents/`
- `hooks/deep-research-cost-guard.sh` → `~/.claude/hooks/` (made executable)

Then add the cost-guard hook to your settings (`~/.claude/settings.json` for all projects,
or a project's `.claude/settings.json`) by merging `settings.snippet.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Workflow",
        "hooks": [ { "type": "command", "command": "$HOME/.claude/hooks/deep-research-cost-guard.sh" } ] }
    ]
  }
}
```

> The hook only intercepts the `deep-research` workflow and asks you to confirm (it's
> token-heavy). All other workflows pass through untouched.

---

## Use

In Claude Code, invoke it explicitly:

```
/redesign-director
```

…or just describe the work ("let's redesign these screens") — Claude auto-triggers it from
the skill description.

### The flow

```
0 · Orient      pick branch (redesign vs greenfield) + pin the immutable core (never guess)
1 · Map         inventory screens, IA, existing design system
2 · Foundations tokens, type pairing, component library + a one-line design thesis
3 · Mockups     one principled HTML file per screen, with inline rationale
4 · States      the missing states (empty, interruption, error, a11y, product-specific arcs)
5 · Evidence    OPT-IN, expensive: offer deep-research with a cost estimate; don't auto-run
6 · Revise      fold verified findings in; drop refuted ones; flag judgment vs proven
7 · ADRs        versioned decision records
8 · Iterate     1–2 cheap alternatives per contested control; commit each step
```

**Redesign vs greenfield:** it assumes there's something to redesign. For an empty project it
switches to a *Frame branch* (goals/personas/posture/core idea with you) before Foundations.
It is **not** meant to auto-run on project open — invoke it when you want a design pass.

**Thin docs?** It doesn't guess the core: it asks you 2–3 framing questions, reads the code as
source of truth, drafts the core and confirms it, and (if there are no decision records) writes
a lightweight product-brief / `ADR-0000` first.

---

## Credits & license

- Methodology & inspiration: see [CREDITS.md](CREDITS.md).
- License: [MIT](LICENSE) — covers the original files in this repo only.
