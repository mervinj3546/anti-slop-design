---
name: "Design Audit"
description: "Audit an existing interface for visual quality, usability, and AI-default patterns"
argument-hint: "Name the page, flow, or component to audit"
agent: "agent"
---

Audit the requested interface. Inspect its rendered state when possible and use implementation evidence only to support, not replace, visual judgment.

Score each area from 0 to 5:
- Information hierarchy
- Composition and density
- Typography
- Color and contrast
- Imagery and iconography
- Interaction and state completeness
- Responsive behavior
- Accessibility
- Distinctiveness and product fit
- Restraint

For every score below 4, cite concrete evidence and prescribe one correction. Separate blocking usability defects from taste improvements. Finish with the three highest-impact actions in priority order. Do not edit files unless the user explicitly asks for fixes.