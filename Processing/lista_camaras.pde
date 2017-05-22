/*
Lista por consola todas las camaras disponibles
*/

import processing.video.*;

Capture video;
int camara_N = 0; //Cambia el valor 0 por el de la cámara que quieras usar

void setup(){
  String camaras[] = Capture.list();
  printArray(camaras); //printArray escribe por consola los elementos del
                       //array, cada uno en una linea
  
  size(640,480);
  video = new Capture(this, 640, 480, Capture.list()[camara_N]);
  
  video.start();
  }
  
  
void draw() {

  image(video,0,0);
  
}

void captureEvent(Capture c) {
  c.read();
}
 
