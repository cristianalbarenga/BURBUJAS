
class PContenedor{
  
  /*-------------------------------------
   ************* VARIABLES *************
  -------------------------------------*/
  int diametro;   //diametro del contenedor
  PGraphics Obj_mascara;   //Mascara para forma circular
  PGraphics Obj_contenedor;  //Objeto contenedor
  
  color color_principal;  //color del elemento

  PBurbuja bubble;
  int diam_Burb; //diametro de burbuja
  PVector pos_Burb;  
  
  /*---------------------------------------
   ************* CONSTRUCTOR *************   
  ---------------------------------------*/
  PContenedor(int diam){
    diametro= diam;  //define el diametro
    diam_Burb= diametro/3; //tamaño maximo de burbuja
    
    Obj_contenedor= createGraphics(diametro,diametro,P2D); //inicializa objeto escena
    Obj_mascara= createGraphics(diametro,diametro,P2D);   //inicializa la mascara 
    
    bubble= new PBurbuja(diam_Burb);  //inicializa la burbuja
    pos_Burb= new PVector(diametro/2,diametro/2);
  }
  
    
  /*---------------------------------------
   ************** FUNCIONES **************
  ---------------------------------------*/
            
  /*----------- MASCARA -------------
  crea la mascara contenedora de las burbujas*/
  void forma_mascara(){
     Obj_mascara.beginDraw();
       Obj_mascara.smooth();
       Obj_mascara.noStroke();
    
       Obj_mascara.fill(150);  //color negro = transparente
       Obj_mascara.rect(0,0,diametro,diametro); //cuadrado 
    
       Obj_mascara.fill(255); //color blano = opaco
       Obj_mascara.ellipse(diametro/2,diametro/2,diametro,diametro); //elipse
     Obj_mascara.endDraw();
  }//_______________________________//
    
  /*--------- CONTENEDOR -----------
  forma contenedora de burbujas */
  void forma_contenedor(){
     Obj_contenedor.beginDraw();
       Obj_contenedor.background(#2C0828); //define color de fondo
       Obj_contenedor.image(bubble.render_Burbuja(),-diam_Burb/2+pos_Burb.x,-diam_Burb/2+pos_Burb.y); //coloca objeto burbuja
     Obj_contenedor.endDraw();     
      
     Obj_contenedor.mask(Obj_mascara);  //aplicacion la mascara a la escena  
  }//_______________________________//
  
  /*------------ BORDE -------------
  forma del borde del canvas*/
  void forma_borde(color col){
      noFill(); 
      stroke(col);
      strokeWeight(diametro* 0.03);
        ellipse(0,0,diametro,diametro);
  }//_______________________________//

  /*---------- MOVIMIENTO ----------
  genera movimiento de la burbuja*/
  void mov_Burbuja(){
      
      PVector m= new PVector(random(-10,10),random(-20,0)); //vector m de mov
      pos_Burb.add(m); //a posicion se agrega vector mov
    
      //evaluacion de limites
      if(pos_Burb.y < (-diam_Burb/2)){ pos_Burb.y= Obj_contenedor.height + diam_Burb/2; }  //lado superior
     
      if(pos_Burb.x < (-diam_Burb/2)){ pos_Burb.x= Obj_contenedor.width + diam_Burb/2; }  //lado izquierdo
      
      if(pos_Burb.x > (Obj_contenedor.width + diam_Burb/2)){ pos_Burb.x= -diam_Burb/2; }   //lado derecho
  }//------------------------------//
  
  /*----- MUESTRA EN PANTALLA ----*/ 
  void display(int posX,int posY, color colr){
    color_principal= colr; //define el color principal
    bubble.genera_Burbuja(colr);
   
    forma_mascara(); //crea la mascara
    forma_contenedor(); //crea la escena
    
    pushMatrix();
    translate(posX,posY);
      image(Obj_contenedor,-diametro/2,-diametro/2);  //representa la imagen general
      forma_borde(colr); //crea el borde del canvas
    popMatrix();

    mov_Burbuja();
  }//------------------------------//
  
} //fin objeto