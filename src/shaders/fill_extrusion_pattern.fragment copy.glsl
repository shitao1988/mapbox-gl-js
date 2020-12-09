uniform vec2 u_texsize;
uniform float u_fade;
uniform sampler2D u_image;
uniform int u_type;
varying vec2 v_pos_a;
varying vec2 v_pos_b;
varying vec4 v_lighting;
varying vec3 v_point_y;
varying vec4 v_normal_ed;
#pragma mapbox: define lowp float base
#pragma mapbox: define lowp float height
#pragma mapbox: define lowp vec4 pattern_from
#pragma mapbox: define lowp vec4 pattern_to
#pragma mapbox: define lowp float intensity 

void main() {
#pragma mapbox: initialize lowp float base
#pragma mapbox: initialize lowp float height
#pragma mapbox: initialize mediump vec4 pattern_from
#pragma mapbox: initialize mediump vec4 pattern_to
#pragma mapbox: initialize lowp float intensity 
    vec2 pattern_tl_a = pattern_from.xy;
    vec2 pattern_br_a = pattern_from.zw;
    vec2 pattern_tl_b = pattern_to.xy;
    vec2 pattern_br_b = pattern_to.zw;

    vec2 imagecoord = mod(v_pos_a, 1.0);
    vec2 pos = mix(pattern_tl_a / u_texsize, pattern_br_a / u_texsize, imagecoord);
    vec4 color1 = texture2D(u_image, pos);

    vec2 imagecoord_b = mod(v_pos_b, 1.0);
    vec2 pos2 = mix(pattern_tl_b / u_texsize, pattern_br_b / u_texsize, imagecoord_b);
    vec4 color2 = texture2D(u_image, pos2);

    vec4 mixedColor = mix(color1, color2, u_fade);


    if (u_type === 1) {
        // float edgedistance = v_normal_ed.w;
        // if (edgedistance > 0.0) {
        //     float z = v_point_y.x;
        //     float b = v_point_y.y;
        //     float h = v_point_y.z;
        //     float y = clamp((z - b) / (h - b), 0.0, 1.0);
        //     mixedColor = texture2D(u_image, vec2(0.5, 1.0 - y));
        //     if (intensity > 0.0) {
        //         mixedColor *= mix(1.0, abs(intensity), y);
        //     }
        //     if (intensity < 0.0) {
        //         mixedColor *= mix(abs(intensity), 1.0, y);
        //     }
        // } else {
        //     mixedColor = texture2D(u_image, vec2(0.5, 1.0));
        // }
    }

    gl_FragColor = mixedColor * v_lighting;
    #ifdef OVERDRAW_INSPECTOR 
    gl_FragColor = vec4(1.0);
    #endif
}