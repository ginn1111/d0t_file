## Variant: i3 desktop simulator

### Design stance
Feel the animations in context — drive a fake i3 session with your real keybindings and watch which picom trigger fires.

### Key choices
- Layout: full-screen fake desktop (polybar, tiled windows, rofi, dunst) + side panel
- Typography: JetBrainsMono, your wallpaper-ish gradient
- Color: focused window gets the xborders green outline
- Interaction: Alt/Ctrl+Enter, +Shift+q, +d, +1…4, +Shift+Space, +f, +n, +o (browsers swallow Super; buttons work too);
  profiles (Your config / Pure fade / Slides / Fly / Off); per-trigger preset dropdowns; live trigger log

### Trade-offs
- Strong at: realism — workspace switches = hide/show, tiling = geometry, rofi and dunst get their own rules like your config
- Weak at: harder to isolate one preset; knob tuning limited to preset choice

### Best for
- Deciding whether the whole setup feels good day-to-day (too busy? too slow?)
