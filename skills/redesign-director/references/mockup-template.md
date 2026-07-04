# Per-screen mockup contract

Each screen is ONE self-contained HTML file under the redesign folder. It is a static
mockup (no live JS prototype unless asked) that a person opens in a browser.

## Structure

- **No build step.** Inline all CSS in a `<style>` block. These are repo docs, not
  published Artifacts, so webfonts via `<link>` are fine (note: inline as data-URI if you
  later publish to claude.ai — the CSP blocks font CDNs there).
- **Token block first.** A `:root { --token: value }` block that matches the 00-foundations
  system exactly. Every color/space/radius/motion value comes from a token, never a magic literal.
- **Theme:** design both light and dark, OR deliberately commit to one world (a nocturnal
  aquatic app can be dark-only) — make it a stated choice, not an omission.
- **Phone frame.** Render the screen inside a device frame (`~290×600`, rounded, status bar)
  so proportions read true. Use a `.rack` (flex, wrap) when showing 2+ phones (states/alternatives).
- **Real copy.** Never lorem. Warm, honest, product-voice microcopy in the product's language.
- **Inline rationale.** Beside/under each phone, a notes column citing the principle behind
  each decision (`Cooper · sovereign posture`, `Norman · Gulf of Evaluation`, `RESEARCH #6`).
  This is what separates a redesign from a reskin.

## Every screen must design its states

Not just the happy path. For the screen's role, cover the relevant ones:
`first-run / empty · loading / partial · running / in-progress · success · error ·
interruption + recovery · edge (offline, permission-deny) · reduced-motion + a11y fallback`.
Group them; one card per state with a one-line rationale.

## Accessibility baseline (from the first mockup)

- Body ≥16px, line-height ~1.4–1.6, measure ~45–75ch, contrast ≥4.5:1 (state the real ratios).
- Targets ≥44px; visible focus; don't rely on color alone (add shape/label/number).
- Reduced-motion: replace morph with crossfade; convey state as line + number + screen-reader
  label, not just animation. Provide an in-app "reduce motion" toggle, not only the OS flag.

## Quality guards

- One clear primary action per screen. Remove controls that serve the tool, not the user (excise).
- Watch selector specificity and overlapping elements — visual bugs hide between source and output.
- Wide content (tables, rows) scrolls inside its own container; the page body never scrolls sideways.
- `font-variant-numeric: tabular-nums` wherever digits line up (timers, stats).

## The index

Maintain an `index.html` that links every screen with a thumbnail + one-line description,
plus the design thesis, the immutable-core list, and the skill/evidence stack used.
