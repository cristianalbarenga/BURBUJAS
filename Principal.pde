/*---------------------------
 ********* VARIABLES *********
 ---------------------------*/
PBurbujas Bu1,Bu2,Bu3;  //objeto PBurbujas
PShader Fondo_shader; //shader del background
PGraphics Fondo;

/*---------------------------
 ********** SETUP ***********
 ---------------------------*/
void setup(){
 size(600,600,P2D); 
 background(255);
 smooth();
// frameRate(25);
 
 Fondo = createGraphics(width,height,P2D);
 
 Fondo_shader= loadShader("Fondo_fragShader.frag");  //carga de shader
 Fondo_shader.set("u_resolution",float(width),float(height)); //define tamaño del fragment
 
 Bu1= new PBurbujas(300,100,9); //objeto Burbujas
 Bu2= new PBurbujas(150,50,6); //objeto Burbujas
 Bu3= new PBurbujas(150,50,4); //objeto Burbujas

}


/*---------------------------
 ********* LOOP DRAW ********
 ---------------------------*/
void draw(){
  
  color colr= #C3FF00;
  
  fondo(colr); //genera el fondo

//  float ang1= random(360); 
//  float ang2= random(360); 
  
  pushMatrix();
  translate(width/2,height/2);

    Bu3.display(int(sin(radians(45))*170), int(cos(radians(45))*170), #00FFEC); //genera la forma contenedora de burbujas
    Bu1.display(0,0,colr); //genera la forma contenedora de burbujas
    Bu2.display(int(sin(radians(245))*150), int(cos(radians(245))*150), #FF00E6); //genera la forma contenedora de burbujas
  
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
