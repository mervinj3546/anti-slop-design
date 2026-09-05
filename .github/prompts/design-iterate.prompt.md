---
name: "Design Iterate"
description: "Run a bounded screenshot, critique, revision, and verification loop on an existing UI"
argument-hint: "Name the runnable page and desired direction; optional references can set the quality bar"
agent: "agent"
---

Improve the requested runnable interface through a maximum of three focused iterations.

For each iteration:
1. Capture fresh desktop and mobile screenshots.
2. Evaluate them with the anti-slop-design critic criteria. Treat supplied references as an optional comparative baseline.
3. Identify the single largest quality gap.
4. Make one coherent set of edits that addresses that gap.
5. Run the narrowest relevant behavior check and capture new screenshots.

Stop early when the design scores at least 9 out of 10 or when a new iteration does not improve the score. Do not conceal non-convergence or inflate scores. Finish with the initial and final scores, the changes that mattered, and validation results.