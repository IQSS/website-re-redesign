---
title: "Events"
date: 2026-05-28
draft: false
layout: "events"
# The landing page itself is HTML only; each event below it also publishes an
# .ics so the "Add to calendar" control has a file to hand over.
outputs: ["HTML"]
cascade:
  outputs: ["HTML", "Calendar"]
---
