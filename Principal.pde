PBurbujas Bu;

void setup(){
 size(800,600); 
 background(255);
 smooth();
 colorMode(HSB,360,100,100);
 frameRate(1);
 Bu= new PBurbujas(300); //crea el objeto PBurbuja
 Bu.inicio(); //inicializa el objeto
}
////////////////////////////////////////
void draw(){
 background(255,0,0);
 Bu.colores((int)random(360));  //define el color principal
 Bu.display(width/2,height/2);  //muestra en pantalla
}