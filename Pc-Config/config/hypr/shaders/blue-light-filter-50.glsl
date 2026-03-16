precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    // Reduce blue light by 50%
    color.b *= 0.8;
    color.g *= 0.97;
    gl_FragColor = color;
}
