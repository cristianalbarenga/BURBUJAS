#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec3 u_color;

void main() {
    vec2 res = gl_FragCoord.xy/u_resolution;

    float d= smoothstep(distance(res,vec2(0.5)),1.0,0.52);

    gl_FragColor = vec4(u_color.r * d, 
			u_color.g * d, 
			u_color.b * d, 1.0);

}