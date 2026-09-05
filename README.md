# Anti-Slop Design

A skill/instruction set that pushes AI coding agents (Claude Code, Claude Design, GitHub Copilot) past the generic "AI-generated" visual default — purple gradients, text-left/graphic-right, safe centered layouts — using six techniques for injecting real variety, taste, and polish into agent-built UI.

Based on [Anshu Chimala, "How to turn your AI into a world-class designer"](https://www.lennysnewsletter.com/p/how-to-turn-your-ai-into-a-world) (Lenny's Newsletter, Sep 2026). Six of the article's seven techniques are implemented here. A seventh ("Remove AI tells") is behind Lenny's paywall and is intentionally excluded rather than guessed at — go read the original if you have access.

## Why this exists

LLMs are next-token predictors: at every design decision, they pick the token most likely to please everyone, which is exactly why AI-generated UI looks the same everywhere. Asking a model to "be creative" or "randomize your choices" doesn't fix this — it just predicts tokens that *sound* random. Real variety has to come from outside the model: either genuine entropy (a random seed string) or your own specific, deliberately-chosen taste (a concrete reference). This repo operationalizes both paths, plus a review loop and a polish pass, as reusable instructions.

## What's in here

```
.
├── SKILL.md                          # Native skill for Claude Code / Claude Design
├── scripts/
│   └── generate_seed.sh              # Generates a random alphanumeric seed string
├── references/
│   └── critic-prompt.md              # Reusable design-critic subagent prompt
├── .github/prompts/                   # Copilot slash commands
│   ├── design-discover.prompt.md
│   ├── design-build.prompt.md
│   ├── design-critique.prompt.md
│   ├── design-subtract.prompt.md
│   ├── design-audit.prompt.md
│   ├── design-iterate.prompt.md
│   ├── design-moodboard.prompt.md
│   └── design-responsive.prompt.md
├── .claude/commands/                  # Claude Code slash commands
│   ├── design-discover.md
│   ├── design-build.md
│   ├── design-critique.md
│   ├── design-subtract.md
│   ├── design-audit.md
│   ├── design-iterate.md
│   ├── design-moodboard.md
│   └── design-responsive.md
└── LICENSE                            # MIT license for this repository
```

## The six techniques

| # | Technique | Stage | What it does |
|---|---|---|---|
| 1 | Seed strings | Discover | Agent generates a random string and derives color/layout/typography from patterns in it — genuine entropy instead of fake "randomness" |
| 2 | Ambitious, specific prompts | Discover | Anchor the design to a concrete reference (a video game, an art movement, an industrial object) instead of vague "make it unique" asks |
| 3 | Critic subagent loop | Define | A second agent, shown only a screenshot (no code/history), scores the design against a studio-quality bar; iterate until it independently hits 9/10+ |
| 4 | Image generation | Define | Explicitly route the agent to image-gen tools instead of letting it default to CSS gradients and shapes |
| 5 | Video generation | Define | Use looping/matted video clips for richer motion, or keyframe interpolation for fluid state transitions |
| 6 | Subtraction pass | Deliver | Explicitly strip decorative elements, redundant labels, and non-native components — AI adds, rarely removes, and restraint reads as premium |

Full procedures, ready-to-paste prompts, and tuning notes for each are in `SKILL.md`.

---

## Install: Claude Code / Claude Design

**Option A — from this repo directly:**
```bash
git clone https://github.com/mervinj3546/anti-slop-design.git
```
Claude Code will pick up `SKILL.md` automatically if it's present in your project, or you can copy the whole folder into your global skills directory.

**Option B — package as an installable `.skill` file** (if you're using Claude.ai/Claude Design's skill installer):
```bash
python -m scripts.package_skill /path/to/anti-slop-design
```
This produces `anti-slop-design.skill` — install it via the "Save skill" button when Claude presents the file.

**Usage** — once installed, just ask normally:
> "Build me a landing page for my productivity app."

The skill triggers automatically on design/UI requests. To be explicit:
> "Use the anti-slop-design skill's seed-string technique to build this landing page."

For the critic loop specifically:
> "Improve this design using a Fable/Opus subagent as a critic, per the critic-prompt template in references/."

---

## Install: GitHub Copilot

Install the repository as a workspace skill:

```bash
mkdir -p /path/to/your-project/.github/skills/anti-slop-design
cp -R SKILL.md scripts references /path/to/your-project/.github/skills/anti-slop-design/
mkdir -p /path/to/your-project/.github/prompts
cp .github/prompts/*.prompt.md /path/to/your-project/.github/prompts/
```

Restart or reload VS Code after installation. Copilot discovers the skill from its `SKILL.md` description and loads it for relevant UI and design requests.

For Claude Code, install the shared skill and native command files:

```bash
mkdir -p /path/to/your-project/.claude/skills/anti-slop-design
cp -R SKILL.md scripts references /path/to/your-project/.claude/skills/anti-slop-design/
mkdir -p /path/to/your-project/.claude/commands
cp .claude/commands/*.md /path/to/your-project/.claude/commands/
```

Restart Claude Code after creating `.claude/commands/`. Claude Code loads the skill automatically when relevant, and each command accepts its target and constraints as trailing text, for example `/design-audit dashboard`.

### Slash commands

Type `/` in Copilot Chat or Claude Code and select one of these focused workflows:

| Command | Purpose | External input |
|---|---|---|
| `/design-discover` | Produce three distinct creative directions | Optional references or constraints |
| `/design-moodboard` | Turn references or a named aesthetic into a build brief | Optional; can start from a product description |
| `/design-build` | Implement one approved direction | Direction or target description |
| `/design-critique` | Identify the largest visual quality gap | Rendered page or screenshot; references optional |
| `/design-audit` | Score the current UI across core design dimensions | Rendered page preferred |
| `/design-subtract` | Remove decorative excess and generic AI patterns | Existing implementation |
| `/design-responsive` | Find and fix layout failures across viewports | Existing implementation |
| `/design-iterate` | Run up to three screenshot, critique, and revision cycles | Existing runnable implementation |

External URLs and moodboards are never runtime dependencies. When supplied, they sharpen the target; otherwise the commands derive direction from the product, audience, content, existing design system, and the skill's bundled guidance.

---

## Quick start: seed-string technique

The fastest way to see this work. In any agent with shell access:

```bash
chmod +x scripts/generate_seed.sh
./scripts/generate_seed.sh 64
```

Then prompt your agent:
> "I want you to build me a landing page for my productivity app. Follow this procedure: 1) Generate a long, random alphanumeric string using a shell script. 2) Define the creative direction (color scheme, layout, typography, etc.) based on the string — look beyond the surface for subpatterns, special numbers, anything that inspires you. 3) Use your judgment to bring this direction to life and make it look great. Don't reveal the string in the design — it's only for your inspiration."

Run it again in a fresh session and you'll get a genuinely different direction each time — that's the test that it's working. If two runs converge on the same look, the agent is ignoring the string and falling back on its defaults.

## Quick start: critic loop

Paste the template from `references/critic-prompt.md` verbatim as your critic's system prompt. Tell your implementing agent:

> "Improve this design. To figure out what to focus on, use a subagent as a design critic. At each iteration: capture a screenshot, invoke the critic in a fresh context with just the screenshot, get its critique and score. Your work is only complete when the critic independently scores 9/10 or higher. Use the same critic prompt every time."

Use your strongest available model for the critic role and a cheaper/faster model for the implementer — the critic should account for a small fraction of total token spend since it's making judgment calls, not doing the build work.

## Notes on live/production use

If you're applying this to a shipped product or an established design system (not a greenfield build), don't run the Discover-stage techniques directly against production:

- Work in a scratch branch or directory first.
- If brand tokens (typography, color) must be preserved, constrain the seed string's influence to layout/composition/motion only and lock the tokens as hard constraints in the prompt.
- Decide up front whether the exercise is exploratory (just seeing what comes out, not meant to ship) or a real redesign candidate — this changes how tightly you should constrain step 1.

## Credit

All techniques and framing are from Anshu Chimala's [original article](https://www.lennysnewsletter.com/p/how-to-turn-your-ai-into-a-world), reformatted here as portable agent instructions. Anshu led AI design R&D at Apple for 12 years; follow him on [X](https://x.com/anshuc) or [Substack](https://substack.com/@anshuc) for more.

## License

The original code and documentation in this repository are available under the MIT License — see `LICENSE`.

The cited article, its text, and any linked third-party material remain the property of their respective owners. This repository is an independently written implementation and summary of the credited techniques; the MIT License does not grant rights to reproduce third-party content.
