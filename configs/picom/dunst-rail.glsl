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
    if      (near(b, vec3(0x24, 0x15, 0x1a))) { rail = vec3(0xe3, 0x55, 0x35); w = 6.0; } // critical
    else if (near(b, vec3(0x1c, 0x20, 0x27)))   rail = vec3(0xc6, 0x2f, 0x52);              // normal
    else if (near(b, vec3(0x1b, 0x20, 0x29)))   rail = vec3(0x11, 0xb7, 0xd4);              // slack
    else if (near(b, vec3(0x17, 0x1b, 0x21)))   rail = vec3(0x47, 0x52, 0x62);              // low
    else if (near(b, vec3(0x1a, 0x1e, 0x25)))   rail = vec3(0x47, 0x52, 0x62);              // osd
    else return default_post_processing(c);

    if (texcoord.x >= w) return default_post_processing(c);
    return default_post_processing(vec4(rail / 255.0 * c.a, c.a));
}
