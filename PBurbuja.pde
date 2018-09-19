
class PBurbuja{
  
  /*-------------------------------------
   ************* VARIABLES *************
  -------------------------------------*/
  PGraphics Obj_burbuja; //objeto grafico burbuja
  int tam_Burb; //tamaño de la burbuja  
  
  PShader Burbuja_shader; //shader de relleno
  
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
        Obj_burbuja.rect(0, 0, Obj_burbuja.width, Obj_burbuja.height); //genera una forma rectangular
        Obj_burbuja.resetShader(); 
        Obj_burbuja.noFill();
      Obj_burbuja.endDraw();    
  }//_______________________________//
  
  /*----------- COLOR ---------------
  envia al shader el color de la burbuja*/
  void color_Burbuja(color color_Burb){
   
    float r= red(color_Burb); //extrae componente rojo 
    float g= green(color_Burb); //idem componente verde
    float b= blue(color_Burb);  //idem componente azul
    
    Burbuja_shader.set("u_color",r,g,b); //ingresa valores al shader 
  }//_______________________________//
  
  /*--------- CREA BURBUJA ---------
  crea la forma de la burbuja */
  void genera_Burbuja(color colr){
    color_Burbuja(colr);  //ingresa el color al shader
    forma_Burbuja();  //crea la forma
  }//_______________________________//
  
  /*------------ RENDER -------------
  devuelve la grafica de burbuja */
  PGraphics render_Burbuja(){
     return Obj_burbuja;
  }//_______________________________//
  
}//--- FIN DE CLASS
