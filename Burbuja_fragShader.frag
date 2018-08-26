#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

void main() {
    vec2 resolucion = gl_FragCoord.xy/u_resolution;

    float r= 1.0 - (resolucion.x+resolucion.y )/ 4.5;
    float g= 0.0;
    float b= 0.752;

    gl_FragColor = vec4(r, g, b, 1.0);
}