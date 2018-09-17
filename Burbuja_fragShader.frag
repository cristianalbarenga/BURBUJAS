#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;  //define resolucion
uniform vec3 u_color;  //define el ingreso del color

vec3 colr_ingreso= u_color/2.0; // color ingresado

//----- REFLEJO -----//
//forma del reflejo con 3 circulos
float reflejo(vec2 res){
    	//circulo 1
        float rad_forma1=0.47;
    	vec2 pos_forma1= vec2(0.5);
        float sombra1= smoothstep(rad_forma1, rad_forma1-0.086, distance(res, pos_forma1));
       
	//circulo 2
        float rad_forma2=0.496;
    	vec2 pos_forma2= vec2(0.570,0.570);
        float sombra2= smoothstep(rad_forma2, rad_forma2-0.078, distance(res, pos_forma2));
        
	//circulo 3
        float rad_forma3=0.5;
    	vec2 pos_forma3= vec2(0.150,0.050);
        float sombra3= smoothstep(rad_forma3, rad_forma3-0.230, distance(res, pos_forma3));
        
	//combinacion de circulos
       	float form= (sombra1 - sombra2)*sombra3; 
    	return form;  
}//---------------//


//----- TRANSPARENCIA ------//
float transp(float rad, vec2 res){
	float transparencia= 
		smoothstep(rad,rad-0.0002,distance(res,vec2(0.5)))/1.2; 
	return transparencia;
}//---------------//



//----- PRINCIPAL -----//
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
   
    float x=st.x;	
    float y=st.y;
    
    float mezcla= 1.0 - (x*y/0.540); //forma de la mezcla de colores
    
    vec3  colr_salida = mix(colr_ingreso, colr_ingreso/5.0, mezcla); //mezcla de colores	   
          colr_salida += (colr_ingreso * reflejo(st)/1.520); //se le  suma el reflejo
    
    gl_FragColor = vec4(colr_salida*1.5, transp(0.5, st)); //color final del shader
}//---------------//
