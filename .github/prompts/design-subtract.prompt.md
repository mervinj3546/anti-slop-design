---
name: "Design Subtract"
description: "Simplify an existing interface by removing decorative excess and generic AI patterns"
argument-hint: "Name the page or component to simplify"
agent: "agent"
---

Apply the anti-slop-design subtraction pass to the requested implementation.

1. Inspect the current rendered UI and its owning code.
2. Remove gradients, glows, decorative shapes, unnecessary containers, nested cards, redundant labels, and meaningless color variation unless each has a clear functional role.
3. Replace custom controls with established project or platform controls where appropriate.
4. Tighten spacing and hierarchy without making the interface cramped.
5. Preserve required content, accessibility, product identity, and working behavior.
6. Compare before and after at mobile and desktop widths, then run focused checks.

Make the edits. In the final response, name only the meaningful removals and validation performed.