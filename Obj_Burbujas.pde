
class PBurbujas{
  
  /*---------------------------
  ********* VARIABLES *********
  ---------------------------*/
  int posicion[]= new int[2];  //posicion del Canvas
  int diametro;   //diametro del canvas
  PGraphics Obj_burbujas; // Objeto/forma de burbujas internas
  PGraphics Obj_mascara; // Objeto/forma de forma circular del canvas
  color color_1; //color principal
  color color_2; //color brillo
  
  /*-----------------------------
  ********* CONSTRUCTOR *********   
  -----------------------------*/
  PBurbujas(int diam){
           diametro= diam; //define el tamaño del canvas
  }

    
  /*-----------------------------
  ********** FUNCIONES **********
  -----------------------------*/
  /*_____Inicio_____
  Incializa los objetos burbuja y mascara*/
  void inicio(){
      Obj_mascara= createGraphics(diametro,diametro); //inicializa la mascara 
      Obj_burbujas= createGraphics(diametro,diametro); //inicializa objeto burbujas  
  }//------------------------//
  
  /*______Muestra en pantalla_____*/ 
  void display(int posX,int posY){
    forma_burbujas(5,diametro/3); //crea la forma
    forma_mascara();  //crea la forma
    Obj_burbujas.mask(Obj_mascara); //aplica mascara a burbujas
    
    pushMatrix();
    translate(posX,posY);
      image(Obj_burbujas,-diametro/2,-diametro/2);  //representa la imagen
     
      noFill();
      stroke(color_1);
      strokeWeight(diametro *0.03);
      ellipse(0,0,diametro,diametro);  //borde   
    popMatrix();
  }//------------------------//
  
  /*______Crea las burbujas_______
  define forma y cantidad de burbujas 
  en el obj_burbujas*/
  
  void forma_burbujas(int cantidad,int tamMax){  //cantidad y tamaño de burbuja
     Obj_burbujas.beginDraw();
     Obj_burbujas.colorMode(HSB,360,100,100);
     Obj_burbujas.background(0);
     for(int i=0;i<cantidad;i++){
         int p_x= (int)random(diametro);  //posicionX
         int p_y= (int)random(diametro);  //posicion Y
         int t= (int)random(tamMax/3,tamMax);  //tamaño de la burbuja
          
         //burbuja: forma de un elipse relleno
         estilo(1,t); //define estilo grafico
         Obj_burbujas.ellipse(p_x,p_y,t,t);
     
         //brillo: forma de una linea con grosor
         estilo(2,t); //define estilo grafico
         Obj_burbujas.arc(p_x, p_y, t * 0.7, t * 0.7, radians(90), radians(190));
     } 
     Obj_burbujas.endDraw();
  }//------------------------//
  
  /*______Crea la Mascara______
  define figua para formar la mascara */
  void forma_mascara(){
       Obj_mascara.beginDraw();
       Obj_mascara.noStroke();
       Obj_mascara.ellipseMode(CENTER);
       Obj_mascara.ellipse(diametro/2,diametro/2,diametro-1,diametro-1);
       Obj_mascara.endDraw();
  }//------------------------//
  
  /*_____Estilo Grafico de burbujas____*/
  void estilo(int e, int tam_burb){
     switch(e){
      case 1: //estilo de burbuja
             Obj_burbujas.noStroke();
             Obj_burbujas.fill(color_1);
             break;
      case 2: //estilo del brillo
             Obj_burbujas.noFill();
             Obj_burbujas.stroke(color_2);
             Obj_burbujas.strokeWeight(tam_burb * 0.1);
     }
  }//------------------------//  
  
  /*_____Definir colores___*/
  void colores(int H){
    color_1=color(H,100,100);
    color_2=color(H,30,100);    
  }//------------------------//
} //fin objrto
