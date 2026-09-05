---
name: "Design Critique"
description: "Critique a rendered interface against a studio-quality visual bar"
argument-hint: "Name the page or attach a screenshot; optional reference images are welcome"
agent: "agent"
---

Critique the current rendered interface using the bundled anti-slop-design critic method.

Prefer a fresh screenshot of the named page. If the project can run locally, render it and capture the relevant desktop and mobile views. If no rendered view or screenshot is available, ask for one instead of pretending code inspection is a visual critique.

Evaluate:
1. The intended aesthetic and product character
2. How a top-tier studio would execute that specific direction
3. The single largest gap in the current result
4. AI-default patterns, decorative excess, weak hierarchy, and generic composition
5. Accessibility-visible issues such as contrast, focus clarity, and text sizing

Use supplied references as a comparative baseline, not as material to copy. Return a direct critique, one prioritized corrective action, and a strict score from 0 to 10. Do not edit files.