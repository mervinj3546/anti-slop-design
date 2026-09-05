---
name: "Design Responsive"
description: "Find and fix responsive layout, overflow, overlap, and hierarchy failures"
argument-hint: "Name the page or flow and any target viewport requirements"
agent: "agent"
---

Audit and fix the requested interface across representative mobile, tablet, desktop, and wide-desktop viewports.

Check for horizontal overflow, clipped text, unstable controls, incoherent overlap, hidden actions, poor touch targets, unreadable line lengths, layout shifts, and desktop composition merely stacked on mobile.

Preserve the intended visual direction while adapting hierarchy and interaction to each viewport. Use stable constraints such as grid tracks, aspect ratios, min/max sizes, and wrapping rules. Do not scale typography directly with viewport width.

Make the smallest implementation changes that solve the failures. Verify with rendered screenshots when available and run the relevant automated checks.