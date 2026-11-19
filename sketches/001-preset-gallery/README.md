## Variant: Preset gallery (dark, card grid)

### Design stance
See every picom v12.5 animation at once, side by side, looping — compare by eye.

### Key choices
- Layout: 8 cards (6 built-in presets + geometry-change + your custom opacity script), each with a mini monitor
- Typography: JetBrainsMono, dark i3-ish palette, xborders green accent
- Color: green border = used in `configs/picom/picom.conf`; sliders start at your config values
- Interaction: per-card duration/scale/direction knobs, global 1× / 0.5× / 0.2× speed, loop, `{ } Config` + Copy picom.conf snippet

### Trade-offs
- Strong at: overview, quick "which one do I like?" comparison, copy-paste config
- Weak at: no real context — a single window in a tiny box; can't see how triggers combine

### Best for
- Picking presets and tuning duration/scale before editing picom.conf
