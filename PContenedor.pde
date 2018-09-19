
class PContenedor{
  
  /*-------------------------------------
   ************* VARIABLES *************
  -------------------------------------*/
  int diametro;   //diametro del contenedor
  int diametro_borde;   //diametro del borde
  PGraphics Obj_mascara;   //Mascara para forma circular
  PGraphics Obj_contenedor;  //Objeto contenedor
  PGraphics Obj_borde;  //borde del contenedor
  
  PBurbuja[] bubble; //array burbujas
  int cant_Burb; //cantidad
  int[] diam_Burb; //diametro de burbuja
  PVector[] pos_Burb; //array de posiciones de burbuja 
  PVector[] veloc_Burb; //array de velocidades de burbuja 
  PVector[] acler_Burb; //array de aceleraciones
  
  PVector[] fuerza; //fuerza aplicada a cada burbuja
  
  
  /*---------------------------------------
   ************* CONSTRUCTOR *************   
  ---------------------------------------*/
  PContenedor(int diam,int cant){
    diametro= diam;  //define el diametro
    diametro_borde= int(diam + diam * 0.05);
    
    Obj_contenedor= createGraphics(diametro,diametro,P2D); //inicializa objeto escena
    Obj_mascara= createGraphics(diametro,diametro,P2D);   //inicializa la mascara 
    Obj_borde= createGraphics(diametro_borde,diametro_borde); //inicializa borde
    
    cant_Burb= cant; //define la cantidad de burbujas
    bubble= new PBurbuja[cant_Burb]; //inicializa array
    diam_Burb= new int[cant_Burb];
    pos_Burb= new PVector[cant_Burb];
    veloc_Burb= new PVector[cant_Burb];
    acler_Burb= new PVector[cant_Burb];
    fuerza= new PVector[cant_Burb];
       
    for(int i=0;i<cant_Burb;i++){
        diam_Burb[i]=(int)random(diametro/6,diametro/3); //tamaño maximo de burbuja
        bubble[i]=new PBurbuja(diam_Burb[i]);  //inicializa la burbuja
    
        //rango para posicionar burbujas
        int rangoX= (int)random(diam_Burb[i]/2,Obj_contenedor.width-diam_Burb[i]/2);  
        int rangoY= (int)random(Obj_contenedor.height);
        pos_Burb[i]= new PVector(rangoX,rangoY); //define cada posicion
        
        //velocidades de burbujas
        veloc_Burb[i]= new PVector(0,1); //define velocidad para cada burbuja
        veloc_Burb[i].rotate(PI); //rota 180 grados el vector (hacia arriba)
        acler_Burb[i]=new PVector(); //crea aceleracion 
        
        fuerza[i]=new PVector(); //crea fuerza
    }
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
    
       Obj_mascara.fill(0);  //color negro = transparente
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
        for(int i=0;i<cant_Burb;i++){
          Obj_contenedor.image(bubble[i].render_Burbuja(), -diam_Burb[i]/2 + pos_Burb[i].x, -diam_Burb[i]/2 + pos_Burb[i].y); //coloca objeto burbuja
        } 
     Obj_contenedor.endDraw();     
      
     Obj_contenedor.mask(Obj_mascara);  //aplicacion la mascara a la escena
     Obj_contenedor.clear();
  }//_______________________________//
  
  /*------------ BORDE -------------
  forma del borde del canvas*/
  void forma_borde(color col){
     Obj_borde.beginDraw();
        Obj_borde.clear();
        Obj_borde.stroke(col);
        Obj_borde.strokeWeight(diametro* 0.03);
        Obj_borde.noFill(); 
        Obj_borde.smooth();
        Obj_borde.ellipse(diametro_borde/2,diametro_borde/2,diametro,diametro);
     Obj_borde.endDraw();
  }//_______________________________//

  /*---------- MOVIMIENTO ----------
  genera movimiento de la burbuja*/
  void mov_Burbuja(){    
    for(int i=0;i<cant_Burb;i++){ 
       acler_Burb[i].add(fuerza[i]); //a cada aceleracion se le aplica una fuerza
       
       veloc_Burb[i].add(acler_Burb[i]); //agrega aceleracion a la velocidad
       veloc_Burb[i].limit(map(diam_Burb[i], diametro/6,diametro/3, 10,3)); //limita la velocidad en base al diametro de la burbuja
       
       pos_Burb[i].add(veloc_Burb[i]); //agrega velocidad a la posicion
        
       acler_Burb[i].mult(0); //vuelve cero la aceleracion, para que no se sume
       eval_Limites(i); //evalua limites para el movimiento          
    }   
  }//------------------------------//
  
  /*---- LIMITES DE MOVIMIENTO -----
  evalua limites para contener el movimiento*/
  void eval_Limites(int n){
        //----- Evaluacion de Limites
        //lado superior
        if(pos_Burb[n].y < (-diam_Burb[n]/2)){ pos_Burb[n].y= Obj_contenedor.height + diam_Burb[n]/2; } //aparece abajo
        
        //margen izquierdo
        if(pos_Burb[n].x < (diam_Burb[n]/2)){
             pos_Burb[n].x= diam_Burb[n]/2; //si pasa el margen lo coloca sobre el borde
             veloc_Burb[n].x *= -1;  //si llega a los limites laterales su velocidad se invierte (rebota)       
        }
        //margen derecho
        if(pos_Burb[n].x > (Obj_contenedor.width - diam_Burb[n]/2)){
            pos_Burb[n].x=Obj_contenedor.width - diam_Burb[n]/2;
            veloc_Burb[n].x *= -1;  
        }      
  }//------------------------------//
  
  /*----- MUESTRA EN PANTALLA ------ 
  muestra las burbujas contenidas en el circulo*/
  void display(PVector pos, color colr){
    
    for(int i=0;i<cant_Burb;i++){
        bubble[i].genera_Burbuja(colr);
    }
    
    forma_mascara(); //crea la mascara
    forma_contenedor(); //crea la escena
    forma_borde(colr); //crea el borde del canvas
    
    pushMatrix();
    translate(pos.x,pos.y);
      image(Obj_contenedor,-diametro/2,-diametro/2);  //representa la imagen general
      image(Obj_borde,-diametro_borde/2,-diametro_borde/2);
    popMatrix();
    
    for(int i=0;i<cant_Burb;i++){  //en cada pasada varia la fuerza aplicada
      if((frameCount+i*5) % 10 == 5){ fuerza[i].x= random(-0.5,0.5); }
     fuerza[i].y=-0.5;
    } 
    
    mov_Burbuja();
  }//------------------------------//
  
} //fin de CLASS
