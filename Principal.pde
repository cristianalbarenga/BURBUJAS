/*---------------------------
 ********* VARIABLES *********
 ---------------------------*/
PContenedor Bu1;  //objeto PContenedor
PShader Fondo_shader; //shader del background
PGraphics Fondo;

/*---------------------------
 ********** SETUP ***********
 ---------------------------*/
void setup(){
 size(600,600,P2D); 
 background(255);
 smooth();
 
 Fondo = createGraphics(width,height,P2D); //crea objeto fondo
 
 Fondo_shader= loadShader("Fondo_fragShader.frag");  //carga de shader
 Fondo_shader.set("u_resolution",float(width),float(height)); //define tamaño del fragment
 
 Bu1= new PContenedor(300); //crea objeto Contenedor
}


/*---------------------------
 ********* LOOP DRAW ********
 ---------------------------*/
void draw(){
  
  color colr= #FF0077;
  fondo(colr); //genera el fondo

  pushMatrix();
  translate(width/2,height/2);
    Bu1.display(0,0,colr); //genera la forma contenedora de burbujas
  popMatrix();
}


/*-----------------------------
 ********** FUNCIONES **********
 -----------------------------*/

/*====== FONDO ====== /
 define el background*/
void fondo(color col){
   
   float r=map(red(col),0,255,0,1);
   float g=map(green(col),0,255,0,1);
   float b=map(blue(col),0,255,0,1);
    
   Fondo_shader.set("u_color",r,g,b);
   
   Fondo.beginDraw();
   Fondo.noStroke();
   Fondo.shader(Fondo_shader);
   Fondo.rect(0,0,width,height); 
   Fondo.resetShader(); 
   Fondo.endDraw();
   
   image(Fondo,0,0);
}
