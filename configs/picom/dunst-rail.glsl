#version 330
// picom window shader for Dunst — paints the "accent rail" (sketch variant 002).
// dunst can only frame all 4 sides, so the left rail is drawn here.
// For each row we sample the card background at x = SAMPLE_X; its colour says
// which notification type the row belongs to. Background colours are set per
// urgency/app in ~/.config/dunst/dunstrc — keep the table below in sync.
// Transparent pixels (gaps between cards, rounded corners) are left untouched.

in vec2 texcoord;
uniform sampler2D tex;

vec4 default_post_processing(vec4 c);

const float SAMPLE_X = 10.5;

bool near(vec3 a, vec3 hex) {
    return all(lessThan(abs(a - hex / 255.0), vec3(1.5 / 255.0)));
}

vec4 window_shader() {
    vec2 ts = textureSize(tex, 0);
    vec4 c = texture2D(tex, texcoord / ts, 0);
    if (texcoord.x >= 6.0 || c.a < 0.01)
        return default_post_processing(c);

    vec4 bg = texture2D(tex, vec2(SAMPLE_X, texcoord.y) / ts, 0);
    if (bg.a < 0.01) return default_post_processing(c);
    vec3 b = bg.rgb / bg.a;                               // un-premultiply

    vec3 rail; float w = 4.0;
    if      (near(b, vec3(0x2e, 0x21, 0x1e))) { rail = vec3(0xcf, 0x6b, 0x6b); w = 6.0; } // critical: alert_card -> err
    else if (near(b, vec3(0x2a, 0x25, 0x20)))   rail = vec3(0xd9, 0xa0, 0x5b);              // normal: surface -> accent
    else if (near(b, vec3(0x26, 0x22, 0x1d)))   rail = vec3(0x8f, 0xb3, 0xb0);              // slack: card_raised -> info
    else if (near(b, vec3(0x21, 0x1e, 0x1a)))   rail = vec3(0x5c, 0x54, 0x47);              // low: card -> ghost
    else if (near(b, vec3(0x24, 0x20, 0x1c)))   rail = vec3(0x5c, 0x54, 0x47);              // osd: card_muted -> ghost
    else return default_post_processing(c);

    if (texcoord.x >= w) return default_post_processing(c);
    return default_post_processing(vec4(rail / 255.0 * c.a, c.a));
}
