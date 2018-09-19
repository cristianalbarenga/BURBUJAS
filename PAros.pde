
class PAros{
  
   /*-------------------------------------
   ************* VARIABLES *************
   -------------------------------------*/
   int grosor_Aros; //grosor de linea
   int diam_Aros; //diametro maximo
   
   PGraphics Obj_aros; //objeto 
  /*---------------------------------------
   ************* CONSTRUCTOR *************   
  ---------------------------------------*/
  PAros(int tam){
    diam_Aros=(int) random(tam/2,tam); //tamaño total
    grosor_Aros= (int)random(2,6); //grosor de linea
        
    Obj_aros= createGraphics(diam_Aros,diam_Aros); //crea el objeto
  }
  
  /*---------------------------------------
   ************** FUNCIONES **************
  ---------------------------------------*/
  
  /*------------ FORMA ---------------
  se genera la forma de la burbuja. */
  void forma_aros(color color_Aros){
     Obj_aros.beginDraw();
         Obj_aros.clear();  //limpia el grafico/lo borra 
         Obj_aros.stroke(color_Aros);
         Obj_aros.strokeWeight(grosor_Aros);
         Obj_aros.noFill();
         Obj_aros.smooth();
  
         for(int i=diam_Aros;i>0;i-=(grosor_Aros*7)){        
           Obj_aros.ellipse(diam_Aros/2,diam_Aros/2,i-grosor_Aros,i-grosor_Aros); //elipses concentricas
         }
     Obj_aros.endDraw();
  }//-----------------------------//
 
  /*----- MUESTRA EN PANTALLA ------ 
  muestra los aros concentricos */
  void display(PVector pos_Aros,color col){
    forma_aros(col); //crea la forma de los aros
    int posX=int(pos_Aros.x - diam_Aros/2); //posicion del centro en eje x
    int posY=int(pos_Aros.y - diam_Aros/2); //posicion del centro en eje y
      image(Obj_aros,posX,posY); //representa en pantalla    
  }
}