---
description: Run a bounded screenshot, critique, revision, and verification loop on an existing UI
argument-hint: "[runnable page, direction, and optional references]"
disable-model-invocation: true
---

Invoke the `anti-slop-design` skill and improve:

$ARGUMENTS

Run at most three iterations. In each, capture fresh desktop and mobile screenshots, identify the single largest quality gap using the bundled critic criteria, make one coherent correction, run focused checks, and capture new screenshots. Stop at 9/10 or when the score no longer improves. Report initial and final scores honestly.