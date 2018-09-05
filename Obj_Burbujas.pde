/*La clase PBurbujas define un elemento circular (canvas)
que contiene burbujas en su interior, se utiliza un shader
para definir el gradiente de las burbujas, y un elemento 
para realizar la mascara */

class PBurbujas{
  
  /*---------------------------
  ********* VARIABLES *********
  ---------------------------*/
  int diametro;   //diametro del canvas
  PGraphics Obj_mascara;   //Mascara forma circular del canvas
  PGraphics Obj_canvas;    //Objeto final (canvas)
 
  int[] tam_Burb; //tamaño del aburbuja
  int cant_Burb; //cantidad de burbujas
  PGraphics[] Obj_burbuja;   //Objeto/forma de burbujas internas
  PVector[] pos_Burb;
   
  PShader Burbuja_shader;  //shader de la burbuja
  color Burbuja_color;    //color de la burbuja
 
  /*-----------------------------
  ********* CONSTRUCTOR *********   
  -----------------------------*/
  PBurbujas(int diam, int tam,int cant){
    diametro= diam;  //define el diametro
    cant_Burb= cant; //define la cantidad de burbujas a contener
   
    Obj_burbuja= new PGraphics[cant_Burb]; //crea array de burbujas
    
    tam_Burb= new int[cant_Burb];  //array de tamaños de burbujas
    pos_Burb =new PVector[cant_Burb];  //crea array vctores de posiciont burbuja
    
    for(int i=0;i<cant_Burb;i++){
      tam_Burb[i]=(int)random(tam/3,tam);
      pos_Burb[i]= new PVector(random(diametro),random(diametro));  //crea cada vector
    }
    
    inicio();
  }
  
    
  /*-----------------------------
  ********** FUNCIONES **********
  -----------------------------*/

  /*====== INICIO ====== /
  Incializa los objetos burbuja, mascara y escena*/
  void inicio(){
    Obj_canvas= createGraphics(diametro,diametro,P2D); //inicializa objeto escena
    Obj_mascara= createGraphics(diametro,diametro,P2D);   //inicializa la mascara 
      
      for(int i=0;i<cant_Burb;i++){ 
        Obj_burbuja[i]= createGraphics(tam_Burb[i],tam_Burb[i],P2D);  //inicializa objeto burbujas
      }
           
      Burbuja_shader= loadShader("Burbuja_fragShader.frag");   //carga el shader
      Burbuja_shader.set("u_resolution",float(Obj_burbuja[0].width),float(Obj_burbuja[0].height)); //resolucion de la brubuja          
  }//------------------------//
  
 
  /*====== BURBUJA ====== /
  define forma de la burbuja individual*/
  void forma_burbuja(){
     
   for(int i=0;i<cant_Burb;i++){ 
     Obj_burbuja[i].beginDraw();
       Obj_burbuja[i].smooth();
       Obj_burbuja[i].noStroke();
       Obj_burbuja[i].shader(Burbuja_shader); //aplica el shader con gradiente
       Obj_burbuja[i].ellipse(tam_Burb[i]/2, tam_Burb[i]/2, tam_Burb[i]-2, tam_Burb[i]-2); //genera una forma circular
       Obj_burbuja[i].resetShader();

       Obj_burbuja[i].noFill();
       Obj_burbuja[i].stroke(Burbuja_color);
       Obj_burbuja[i].strokeWeight(tam_Burb[i] * 0.1);
       Obj_burbuja[i].arc(tam_Burb[i]/2, tam_Burb[i]/2, tam_Burb[i] * 0.7, tam_Burb[i] * 0.7, radians(90), radians(190)); //genera la forma del brillo
     Obj_burbuja[i].endDraw();
   } 
  }//------------------------//
      
      
  /*======== MASCARA ======= /
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
  }//------------------------//

  
  /*======= ESCENA ======== /
  forma general con las burbujas adentro*/
  void forma_escena(){
     Obj_canvas.beginDraw();
     Obj_canvas.background(#2C0828); //define color de fondo
      for(int i=0;i<cant_Burb;i++){
         Obj_canvas.image(Obj_burbuja[i],pos_Burb[i].x, pos_Burb[i].y); //coloca burbujsa en escena
      }
     Obj_canvas.endDraw();     
      
     Obj_canvas.mask(Obj_mascara);  //aplicacion la mascara a la escena  
  }//------------------------//
  
  
  /*========= MOVIMIENTO BURBUJA ======== /
    crea el movimento de las burbujas */
  void mov_burbuja(){
    
    for(int i=0;i<cant_Burb;i++){ 
      PVector m= new PVector(random(-2,2),random(-5,0));
      pos_Burb[i].add(m);
    
      if(pos_Burb[i].y<-tam_Burb[i]){ pos_Burb[i].y=Obj_canvas.height; }  //lado superior
      if(pos_Burb[i].x<-tam_Burb[i]){ pos_Burb[i].y=Obj_canvas.width; }  //lado izquierdo
      if(pos_Burb[i].x>Obj_canvas.width+tam_Burb[i]){ pos_Burb[i].y=0; }   //lado derecho

      
    }
    
    
  }//------------------------//
  
  
  /*========= BORDE ======== /
  forma del borde del canvas*/
  void borde(){
      noFill(); 
      stroke(Burbuja_color);
      strokeWeight(diametro* 0.03);
        ellipse(0,0,diametro,diametro);
  }//------------------------//


  /*======== COLOR ======== /
  aplicacion del color a shader y borde*/
  void coloreado(color colr){
    
    Burbuja_color= colr;  //define variable global con el color ingresado
    
    float r= map(red(colr),0,255,0,1); //extrae componente rojo y remapea entre 0 y 1
    float g= map(green(colr),0,255,0,1); //idem componente verde
    float b= map(blue(colr),0,255,0,1);  //idem componente azul
    
    Burbuja_shader.set("u_color",r,g,b); //ingresa valores al shader   
  }//------------------------//

  
  /*====== MUESTRA EN PANTALLA ======*/ 
  void display(int posX,int posY, color colr){
    
    coloreado(colr); //define los colores
    
    forma_burbuja(); //crea la forma de la burbuja
    
    forma_mascara(); //crea la mascara
    
    forma_escena(); //crea la escena
    
    pushMatrix();
    translate(posX,posY);
    
      image(Obj_canvas,-diametro/2,-diametro/2);  //representa la imagen general
      
      borde(); //crea el borde del canvas
    
    popMatrix();
    
    mov_burbuja();//agrega movimiento a la burbuja
  }//------------------------//
  
} //fin objeto
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
