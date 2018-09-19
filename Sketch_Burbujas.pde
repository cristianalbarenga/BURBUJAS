/*---------------------------
 ********* VARIABLES *********
 ---------------------------*/
int cant= 3;
PContenedor[] Bu= new PContenedor[cant];  //array objeto PContenedor
int[] diam_Cont= new int[cant];  //diametro de cada contenedor
PVector[] pos_Cont=new PVector[cant]; //posicion de cada contenedor

PAros[] Ar= new PAros[cant]; //array de aros concentricos
PVector[] pos_Aros= new PVector[cant]; //posicion de los aros concentricos

PShader Fondo_shader; //shader del background
PGraphics Fondo; //fondo/background

color[] colr= new color[cant]; //array de esquema de colores
/*---------------------------
 ********** SETUP ***********
 ---------------------------*/
void setup(){
   size(600,600,P2D); 
   background(0);
   smooth();
   colorMode(HSB,1.0,1.0,1.0);
   
   Fondo = createGraphics(width,height,P2D); //crea objeto fondo
 
   Fondo_shader= loadShader("Fondo_fragShader.frag");  //carga de shader
   Fondo_shader.set("u_resolution",float(width),float(height)); //define tamaño del fragment
     
   //contenedor central
   diam_Cont[0]=300; //diametro
   Bu[0]= new PContenedor(diam_Cont[0],8); //objeto contenedor central
   pos_Cont[0]= new PVector(0,0); // posicion
   
   //contenedores auxiliares
   for (int i=1;i<cant;i++){
       diam_Cont[i]=(int)random(80,200); //radio de contenedores
       Bu[i]= new PContenedor(diam_Cont[i],4); //contenedores auxiliares 
       pos_Cont[i]= new PVector(1,0); //inicio posicion
       
       pos_Cont[i].setMag(diam_Cont[0]/2); //define posicion sobre radio de contendor principal
       pos_Cont[i].rotate(angulo((cant-1),i)); //rota vector al azar en 360°, se le resta 1 (cont central)        
   }
   
   //aros concentricos
   for (int i=0;i<cant;i++){
       Ar[i]= new PAros(200); //objetos aros radio maximo 200
       pos_Aros[i]= new PVector(1,0);
       pos_Aros[i].setMag(diam_Cont[0]/2);
       pos_Aros[i].rotate(angulo(cant,i));
   }
   
   //esquema de colores
   esquema_col(); 
}


/*---------------------------
 ********* LOOP DRAW ********
 ---------------------------*/
void draw(){
  fondo(colr[0]); //genera el fondo
  
  pushMatrix();
  translate(width/2,height/2);
      //Aros concentricos
      for (int i=0;i<cant;i++){
        Ar[i].display(pos_Aros[i],colr[i]);
      }
      
      //contenedor principal
      Bu[0].display(pos_Cont[0], colr[0]); //genera la forma contenedora de burbujas
      
      //contenedores auxiliares
      for (int i=1;i<cant;i++){
          Bu[i].display(pos_Cont[i], colr[i]); //contenedores auxiliares 
      }           
  popMatrix();
  
  esquema_col();
}


/*-----------------------------
 ********** FUNCIONES **********
 -----------------------------*/

/*====== FONDO ====== /
 define el background*/
void fondo(color col){
   
  float r=red(col);
  float g=green(col);
  float b=blue(col);
    
  Fondo_shader.set("u_color",r,g,b);
   
   Fondo.beginDraw();
   Fondo.noStroke();
   Fondo.shader(Fondo_shader);
   Fondo.rect(0,0,width,height); 
   Fondo.resetShader(); 
   Fondo.endDraw();
   
   image(Fondo,0,0);
}//====================//

/*====== COLORES ====== /
 define el esquema  de colores*/
void esquema_col(){
 float hue=map(mouseX,0,width,0,360); //color de 0 a 360°
 
 float c1=map(abs(hue),0,360,0,1); //se remapea a valores de 0 a 1
 float c2=map(abs(hue+25)%360,0,360,0,1); //suma valor a hue, luego se obtiene modulo para no sobrepasar los 360, y se remapea 
 float c3=map(abs(hue-110)%360,0,360,0,1); 

 colr[0]=color(c1, 1.0, 1.0); 
 colr[2]=color(c2, 1.0, 1.0);
 colr[1]=color(c3, 1.0, 1.0);
}//====================//

/*====== ANGULO ====== /
 calcula el rango angular en 
 el cual posicionar el vector 
 pos de cada elemento*/
float angulo(int cantElem, int i){
  float ang;  
  
  if(i<1){ ang=random(TWO_PI/cantElem); } 
     else{ ang=random(TWO_PI/cantElem*i, TWO_PI/cantElem*(i+1)); }
  return (ang);
}
