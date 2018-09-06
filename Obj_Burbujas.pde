
class PBurbuja{
  
  /*-------------------------------------
   ************* VARIABLES *************
  -------------------------------------*/
  PGraphics Obj_burbuja; //objeto grafico burbuja
  int tam_Burb; //tamaño de la burbuja  
  
  PShader Burbuja_shader; //shader de relleno
  color color_Burb; //color
  
  /*---------------------------------------
   ************* CONSTRUCTOR *************   
  ---------------------------------------*/
  PBurbuja(int tam){
    tam_Burb= tam;  //ingresa el tamaño
    Obj_burbuja= createGraphics(tam_Burb,tam_Burb,P2D);  //crea el objeto gráfico
    Burbuja_shader= loadShader("Burbuja_fragShader.frag");   //carga el shader
    Burbuja_shader.set("u_resolution", float(tam_Burb), float(tam_Burb)); //define resolucion de shader          
  }
  
  
  /*---------------------------------------
   ************** FUNCIONES **************
  ---------------------------------------*/
  
  /*------------ FORMA ---------------
  se genera la forma de la burbuja. */
  void forma_Burbuja(){
      Obj_burbuja.beginDraw();
       Obj_burbuja.smooth();
       Obj_burbuja.noStroke();
       Obj_burbuja.shader(Burbuja_shader); //aplica el shader
       Obj_burbuja.ellipse(tam_Burb/2, tam_Burb/2, tam_Burb-2, tam_Burb-2); //genera una forma circular
       Obj_burbuja.resetShader(); 

       Obj_burbuja.noFill();
       Obj_burbuja.stroke(255);
       Obj_burbuja.strokeWeight(tam_Burb * 0.1);
       Obj_burbuja.arc(tam_Burb/2, tam_Burb/2, tam_Burb * 0.7, tam_Burb * 0.7, radians(90), radians(190)); //genera la forma del brillo
     Obj_burbuja.endDraw();    
  }//_______________________________//
  
  /*----------- COLOR ---------------
  envia al shader el color de la burbuja*/
  void color_Burbuja(){
   
    float r= map(red(color_Burb),0,255,0,1); //extrae componente rojo y remapea entre 0 y 1
    float g= map(green(color_Burb),0,255,0,1); //idem componente verde
    float b= map(blue(color_Burb),0,255,0,1);  //idem componente azul
    
    Burbuja_shader.set("u_color",r,g,b); //ingresa valores al shader 
  }//_______________________________//
  
  /*--------- CREA BURBUJA ---------
  crea la forma de la burbuja */
  void genera_Burbuja(color colr){
    color_Burb= colr; // se define el color
    color_Burbuja();  //ingresa el color al shader
    forma_Burbuja();  //crea la forma
  }//_______________________________//
  
  /*------------ RENDER -------------
  devuelve la grafica de burbuja*/
  PGraphics render_Burbuja(){
     return Obj_burbuja;
  }//_______________________________//
  
}//--- FIN DE CLASS
