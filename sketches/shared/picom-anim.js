/*
 * picom-anim.js — browser re-implementation of picom v12.5 animation presets.
 *
 * Source of truth: data/animation_presets.conf from picom v12.5
 * (copied next to this file as animation_presets.v12.5.conf).
 * Curves, start/end expressions, crop and opacity behaviour are ported 1:1.
 * Not ported: blur, saved-image-blend pixels (we fade a ghost instead).
 *
 * Coordinates are "screen" pixels: win = {x, y, w, h} relative to the
 * monitor element that contains the window (picom uses the whole X screen).
 */
(function (global) {
  "use strict";

  // ---- cubic-bezier(x1,y1,x2,y2) like CSS / picom -------------------------
  function bezier(x1, y1, x2, y2) {
    const cx = 3 * x1, bx = 3 * (x2 - x1) - cx, ax = 1 - cx - bx;
    const cy = 3 * y1, by = 3 * (y2 - y1) - cy, ay = 1 - cy - by;
    const sx = t => ((ax * t + bx) * t + cx) * t;
    const sy = t => ((ay * t + by) * t + cy) * t;
    const dx = t => (3 * ax * t + 2 * bx) * t + cx;
    const f = x => {
      if (x <= 0) return 0;
      if (x >= 1) return 1;
      let t = x;
      for (let i = 0; i < 8; i++) {           // Newton
        const e = sx(t) - x, d = dx(t);
        if (Math.abs(e) < 1e-6) return sy(t);
        if (Math.abs(d) < 1e-6) break;
        t -= e / d;
      }
      let lo = 0, hi = 1; t = x;              // bisection fallback
      for (let i = 0; i < 40; i++) {
        const v = sx(t);
        if (Math.abs(v - x) < 1e-6) break;
        if (v < x) lo = t; else hi = t;
        t = (lo + hi) / 2;
      }
      return sy(t);
    };
    f.points = [x1, y1, x2, y2];
    return f;
  }
  const linear = x => Math.min(1, Math.max(0, x));
  linear.points = [0, 0, 1, 1];

  // Curves exactly as in animation_presets.conf (v12.5)
  const CURVES = {
    "appear / slide-in":      bezier(0.24, 0.64, 0.79, 0.98),
    "disappear / slide-out":  bezier(0.21, 0.02, 0.76, 0.36),
    "fly-in":                 bezier(0.17, 0.67, 0.68, 1.03),
    "fly-out":                bezier(0.05, 0, 0.69, -0.05),
    "geometry-change":        bezier(0.07, 0.65, 0, 1),
    "linear (opacity)":       linear,
  };
  const C = {
    in: CURVES["appear / slide-in"],
    out: CURVES["disappear / slide-out"],
    flyIn: CURVES["fly-in"],
    flyOut: CURVES["fly-out"],
    geom: CURVES["geometry-change"],
    lin: linear,
    custom: bezier(0.25, 0.1, 0.25, 1), // our opacity script in picom.conf
  };

  // direction placeholder tables (up, down, left, right) from presets.conf
  const DIR = { up: 0, down: 1, left: 2, right: 3 };
  const P1 = [0, 0, -1, 1];   // X sign
  const P2 = [-1, 1, 0, 0];   // Y sign
  const P3 = [0, 0, 1, 1];    // axis: 0 = Y, 1 = X
  const P4 = [0, 0, -1, 0];   // fly: add window-x
  const P5 = [-1, 0, 0, 0];   // fly: add window-y

  const lerp = (a, b, p) => a + (b - a) * p;

  // Preset metadata: defaults are picom's *knobs*
  const PRESETS = {
    "appear":          { kind: "in",   knobs: { duration: 0.2, scale: 0.95 }, triggers: ["open", "show"] },
    "disappear":       { kind: "out",  knobs: { duration: 0.2, scale: 0.95 }, triggers: ["close", "hide"] },
    "slide-in":        { kind: "in",   knobs: { duration: 0.2, direction: "down" }, triggers: ["open", "show"] },
    "slide-out":       { kind: "out",  knobs: { duration: 0.2, direction: "down" }, triggers: ["close", "hide"] },
    "fly-in":          { kind: "in",   knobs: { duration: 0.2, direction: "up" }, triggers: ["open", "show"] },
    "fly-out":         { kind: "out",  knobs: { duration: 0.2, direction: "up" }, triggers: ["close", "hide"] },
    "geometry-change": { kind: "geom", knobs: { duration: 0.4 }, triggers: ["geometry"] },
    "opacity-fade":    { kind: "opacity", custom: true, knobs: { duration: 0.15 },
                         triggers: ["increase-opacity", "decrease-opacity"] },
  };

  /**
   * Evaluate one frame.
   * @param name   preset name
   * @param o      knobs {duration, scale, direction, from, to}
   * @param t      seconds since start
   * @param win    {x,y,w,h, before:{x,y,w,h}}
   * @returns {ox, oy, sx, sy, opacity, crop, blend, p}
   */
  function frame(name, o, t, win) {
    const d = Math.max(1e-6, o.duration);
    const p = Math.min(1, Math.max(0, t / d));
    const f = { ox: 0, oy: 0, sx: 1, sy: 1, opacity: 1, crop: false, blend: 0, p };
    const i = DIR[o.direction] ?? 0;
    switch (name) {
      case "appear": {
        const s = lerp(o.scale, 1, C.in(p));
        Object.assign(f, { sx: s, sy: s, ox: (1 - s) / 2 * win.w, oy: (1 - s) / 2 * win.h,
                           opacity: lerp(0, 1, C.lin(p)) });
        break;
      }
      case "disappear": {
        const s = lerp(1, o.scale, C.out(p));
        Object.assign(f, { sx: s, sy: s, ox: (1 - s) / 2 * win.w, oy: (1 - s) / 2 * win.h,
                           opacity: lerp(1, 0, C.lin(p)) });
        break;
      }
      case "slide-in": {
        const v = lerp(win.w * P1[i] + win.h * P2[i], 0, C.in(p));
        Object.assign(f, { ox: v * P3[i], oy: v * (1 - P3[i]), crop: true });
        break;
      }
      case "slide-out": {
        const v = lerp(0, win.w * P1[i] + win.h * P2[i], C.out(p));
        Object.assign(f, { ox: v * P3[i], oy: v * (1 - P3[i]), crop: true });
        break;
      }
      case "fly-in": {
        const s = win.h * P2[i] + win.y * P5[i] + win.w * P1[i] + win.x * P4[i];
        const v = lerp(s, 0, C.flyIn(p));
        Object.assign(f, { ox: v * P3[i], oy: v * (1 - P3[i]) });
        break;
      }
      case "fly-out": {
        const e = win.h * P2[i] + win.y * P5[i] + win.w * P1[i] + win.x * P4[i];
        const v = lerp(0, e, C.flyOut(p));
        Object.assign(f, { ox: v * P3[i], oy: v * (1 - P3[i]) });
        break;
      }
      case "geometry-change": {
        const b = win.before || win;
        const g = C.geom(p);
        Object.assign(f, {
          sx: lerp(b.w / win.w, 1, g), sy: lerp(b.h / win.h, 1, g),
          ox: lerp(b.x - win.x, 0, g), oy: lerp(b.y - win.y, 0, g),
          blend: lerp(1, 0, C.lin(p)),
        });
        break;
      }
      case "opacity-fade": {
        Object.assign(f, { opacity: lerp(o.from ?? 0.4, o.to ?? 1, C.custom(p)) });
        break;
      }
    }
    return f;
  }

  /** Apply a frame to a window: outer = positioned box, inner = visual body. */
  function apply(outer, inner, f) {
    outer.style.overflow = f.crop ? "hidden" : "visible";
    inner.style.transformOrigin = "0 0";
    inner.style.transform = `translate(${f.ox}px, ${f.oy}px) scale(${f.sx}, ${f.sy})`;
    inner.style.opacity = f.opacity;
    inner.style.setProperty("--blend", f.blend);
  }
  function reset(outer, inner) {
    outer.style.overflow = "visible";
    inner.style.transform = "";
    inner.style.opacity = "";
    inner.style.setProperty("--blend", 0);
  }

  /** Run an animation with requestAnimationFrame. Returns {cancel, promise}. */
  function run(outer, inner, name, o, win, opts = {}) {
    const speed = opts.speed ?? 1;
    let raf, cancelled = false, resolve;
    const promise = new Promise(r => (resolve = r));
    const t0 = performance.now();
    const tick = now => {
      if (cancelled) return resolve(false);
      const t = ((now - t0) / 1000) * speed;
      const f = frame(name, o, t, win);
      apply(outer, inner, f);
      opts.onFrame && opts.onFrame(f, t);
      if (f.p < 1) raf = requestAnimationFrame(tick);
      else resolve(true);
    };
    raf = requestAnimationFrame(tick);
    return { cancel() { cancelled = true; cancelAnimationFrame(raf); }, promise };
  }

  /** picom.conf snippet for a preset + knobs. */
  function snippet(name, o, triggers) {
    const tr = (triggers || PRESETS[name].triggers).map(x => `"${x}"`).join(", ");
    if (name === "opacity-fade") {
      return `{ triggers = [ ${tr} ];\n  opacity = { duration = ${o.duration}; curve = "cubic-bezier(0.25, 0.1, 0.25, 1)";\n              start = "window-raw-opacity-before"; end = "window-raw-opacity"; };\n  shadow-opacity = "opacity"; },`;
    }
    const lines = [`{ triggers = [ ${tr} ];`, `  preset = "${name}";`];
    if ("direction" in PRESETS[name].knobs) lines.push(`  direction = "${o.direction}";`);
    if ("scale" in PRESETS[name].knobs) lines.push(`  scale = ${o.scale};`);
    lines.push(`  duration = ${o.duration}; },`);
    return lines.join("\n");
  }

  global.Picom = { frame, apply, reset, run, snippet, PRESETS, CURVES, DIRS: Object.keys(DIR), bezier };
})(window);
