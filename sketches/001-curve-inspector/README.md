## Variant: Curve inspector (light, editorial)

### Design stance
Understand exactly how each preset moves — timing curve, scrubber, and the output variables picom computes per frame.

### Key choices
- Layout: sticky preset nav, stage (mini screen + canvas graph), scrubber, readouts, config snippet + notes, comparison table
- Typography: serif headings, monospace numbers — reads like documentation
- Color: warm paper background; red = old rect, green = new rect (geometry-change)
- Interaction: play / slow-mo 0.15× / scrub (←/→ keys), knobs, click a table row to jump

### Trade-offs
- Strong at: precision — why fly-out "winds up", why appear is scaled before it is opaque, where slide-in crops
- Weak at: one preset at a time; least "fun" to look at

### Best for
- Writing custom animation scripts or debugging why an animation looks off
