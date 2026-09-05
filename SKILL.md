---
name: anti-slop-design
description: Use this skill whenever building or redesigning any user-facing visual output — landing pages, apps, dashboards, portfolios, UI components, design mockups — even if the user doesn't explicitly ask for something "unique" or "creative." LLMs default to generic, template-like output (purple gradients, text-left/graphic-right, safe centered layouts) because next-token prediction optimizes for the most likely choice, not the most interesting one. This skill counteracts that default. Trigger it especially when the user says things like "make it unique," "avoid the generic AI look," "make this stand out," "don't make it look like every other AI site," or when starting any new visual design from a blank slate. Also trigger when a user asks to critique, polish, or "make this less AI-generated" — that's the Deliver stage below.
---

# Anti-Slop Design

A three-stage process (Discover → Define → Deliver) for pushing AI-generated visual design past the default "design-by-committee" output. Source: Anshu Chimala, "How to turn your AI into a world-class designer" (Lenny's Newsletter, Sep 2026). Six of the article's seven techniques are implemented here; a seventh ("Remove AI tells") was paywalled at time of writing and is not included — don't guess at its content.

**Core principle**: an LLM can't act randomly — it can only predict the most likely token. Asking it to "be creative" or "make random choices" just makes it predict tokens that *sound* random. Real variety has to come from an external source of entropy (a seed string) or from your own specific, deliberately-chosen taste (a concrete reference). Never skip straight to "make it look good" — that's exactly the instruction that produces the beige/purple-gradient default.

Use only the stages relevant to where the user is. A user with an existing design who wants it critiqued only needs Define/Deliver, not Discover.

## Stage 1: Discover — explore the space

Pick ONE of these two techniques per design (or run both in parallel branches and compare):

### Technique 1: Seed strings

Have the agent generate genuine entropy and derive design decisions from it, rather than "randomizing" from its own priors.

Procedure to give the coding agent:
1. Generate a long, random alphanumeric string via shell script (see `scripts/generate_seed.sh`).
2. Derive creative direction (color scheme, layout, typography, imagery, motion) from subpatterns in the string — repeated characters, runs, notable substrings, anything that reads as inspiration. Look beyond the surface.
3. Use judgment to execute that direction well. Don't reveal the string in the output — it's inspiration only, not content.

Run this fresh (new session, new string) for each variant you want to compare. No two runs should converge on the same direction — if they do, the agent is ignoring the string and falling back on defaults; call this out explicitly and re-run.

If existing brand tokens must be preserved (a live product, an established portfolio), constrain the seed's influence to layout/composition/motion only and lock typography + color as hard constraints. Otherwise let it run fully unconstrained — that's the point.

### Technique 2: Ambitious, specific prompts

Instead of entropy, anchor the design to a concrete, deliberately-chosen external reference: a video game, an interior design movement, an art installation, an industrial object. Vague asks ("make it unique") get vague, average output — specificity is what does the work.

Three-step method for finding the reference:
1. Ask the AI for a broad, shallow list of design-language ideas — explicitly ask for breadth over depth, short descriptions only.
2. React to your favorites in your own words — what you like, what feels tacky, what to avoid, what's missing. This is where your taste enters the process; skipping this step is what makes the output generic again.
3. Once refined, ask the AI to write a concise build prompt for a proof-of-concept based on your refined direction.

Save prompts that don't produce good results — models improve, and a prompt that flops today may work well on the next model version.

## Stage 2: Define — deepen the identity

### Technique 3: Critic subagent loop

A coding agent can't objectively evaluate its own design — it's anchored to its own prior decisions and rationale. Use a second, fresh-context agent as a "design critic" that only ever sees a screenshot.

Procedure:
1. Capture a screenshot of the current state.
2. Invoke the critic in a **fresh context** — screenshot only, no code, no implementation history, no prior critiques.
3. Critic evaluates: what aesthetic is this going for, how would a top-tier design studio execute that aesthetic, what's the biggest gap between the two, then a score /10.
4. Iterate until the critic independently scores 9+.

Rules for the critic prompt (see `references/critic-prompt.md` for a ready-to-use template):
- Don't tell the critic what score is "required" — keep its scoring criteria blind to the stopping condition, or scores drift toward whatever the agent wants to hear.
- Objective framing beats subjective framing. "Judge if this looks beautiful, not AI-generated" is weak — scores swing wildly run to run. "Compare against how a top studio would execute this specific aesthetic" is stronger. Strongest: give the critic 3-5 reference images (real professional work, or a moodboard) alongside the current screenshot and ask it to rank by polish/taste — this gives it a concrete visual baseline instead of an abstract standard.
- Cap iterations (2-3 to start) and check for convergence before raising the cap — an unconstrained critic can loop indefinitely and burn tokens without the design actually improving.
- Use your strongest/most expensive model for the critic role only. Use a cheaper/faster model for the implementer. The critic should be a small fraction of total token spend — it's making executive decisions, not doing the work.

### Technique 4: Image generation

Coding agents default to CSS gradients, shapes, and basic patterns because they underuse image tools — this is one of the strongest "AI-generated" tells.

- If the agent has built-in image gen (Codex, Antigravity, Grok Build): explicitly instruct it to use it. It knows how, but won't by default.
- If using Claude Code/similar + a ChatGPT subscription: have it drive the Codex CLI for image generation, billing the subscription rather than a separate API key.
- Otherwise: provide an OpenAI or Gemini API key scoped tightly (separate key, hard spend cap, easily revocable). Store it in a gitignored `.env.agents` file, not pasted inline repeatedly. Document in `CLAUDE.md`/`AGENTS.md` that the key is dev-only and must not ship with the product.
- Combine generated images with shaders/3D effects rather than using them as flat static assets — this is what separates "used image gen" from "looks obviously AI-generated."

### Technique 5: Video generation (for advanced motion)

Use an aggregator (e.g. fal.ai) so the agent can pick the best current model via one API key rather than hardcoding to one provider.

Two patterns:
- **Layerable animated graphics**: generate a looping clip, render it over the actual page background first (so effects like glass refraction bake in correctly), then background-remove with a video matting model. Produces UI-native animation instead of an obvious embedded video.
- **Fluid state transitions**: generate stills for each state, then use keyframe interpolation to create a transition clip between them. Chain transitions by seeding the next clip from the previous one's final frame. Scrub the result frame-by-frame against scroll or gesture input for interactive transitions.

## Stage 3: Deliver — polish

### Technique 6: Subtraction pass

AI adds and rarely removes — overexplaining and decorative elements with no function are the most reliable "this is AI-generated" tell. A design gets more premium by having things removed from it, not added.

Explicit subtraction prompt pattern:
> "Simplify this into [specific structure, e.g. an image-centric grid]. Remove gradients, glows, and unnecessary containers. Replace custom-built components with native [platform] components where a native one exists. Aim for true minimalism — every element should justify its presence."

Checklist to apply manually before/during this pass:
- Decorative glow/gradient effects with no functional purpose → remove
- Color or highlight variation on text with no semantic meaning → remove
- Redundant labels next to content that's already self-explanatory (e.g. a caption under an already-clear image) → remove
- Custom-built buttons/inputs/toggles that look worse than the platform's native equivalents → replace with native components
- Empty/decorative whitespace that isn't doing compositional work → tighten

This step requires taking things away and deleting code, which models are reluctant to do on their own (it reads as risky). Push for it explicitly — don't accept "clean, minimalist" as a first-pass instruction and assume it's handled; verify against the checklist above.

## Using this on an existing/live product

If the target is a shipped product or an established portfolio (not a fresh build), run Discover techniques in a scratch branch/directory first, never against the live target. Decide before starting whether the goal is exploratory (just seeing what a model produces, not meant to ship) or a real redesign candidate (needs brand-token constraints from the start, per the "existing brand tokens" note in Technique 1).
