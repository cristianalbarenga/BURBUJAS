#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;  //define resolucion
uniform vec3 u_color;  //define el ingreso del color

void main() {
    vec2 res = gl_FragCoord.xy/u_resolution;
    
    vec3 colrShadow = u_color / 1.5;  

    vec3 colrMix= mix(u_color,colrShadow,(res.x+res.y)/2.5);

    gl_FragColor = vec4(colrMix, 1.0);
}
