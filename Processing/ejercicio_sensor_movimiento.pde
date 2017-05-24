/*
Ejercicio de sensor de movimiento
Cálculo de la dirección del movimiento
*/

import gab.opencv.*;
import processing.video.*;

Capture video; //Video de entrada
OpenCV opencv; //objeto opencv para procesar imagen
PImage edit,edit2;   //imagen editada

color trackColor; 
float threshold = 100;
int num_muestras = 10; //muestras para el sensor de movimiento
int contador = 0;

float centros[][] = {{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0},{0,0}};

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(Capture.list());
  video = new Capture(this, 640,480, cameras[6]);
  opencv = new OpenCV(this, 640, 480);
  
  trackColor = color(255, 255, 255);
  
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  //startBackgroundSubtraction(int history, int nMixtures, double backgroundRatio)
  
  video.start();
}

void draw() {
  //image(video, 0, 0);  
  opencv.loadImage(video);
  
  opencv.updateBackground();
  
  opencv.erode();
  opencv.dilate();
  
  edit = opencv.getSnapshot(); //convertir opencv en imagen
  tint(255, 255, 255); //Esto es solo para poner colores chulos :D
  //image(edit,0,0);
  edit2 = edit;

  /*noFill();
  stroke(204,60, 46);
  strokeWeight(3);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }*/
  
   //edit2 = new Capture(this, 640,480, edit);
   edit.loadPixels(); //Necesitamos loadPixels() para poder analizar los pixeles uno a uno
   edit2.loadPixels();
  //image(video, 0, 0);

  float avgX = 0;
  float avgY = 0;

  int count = 0;


  // Begin loop to walk through every pixel
  for (int x = 0; x < edit.width; x++ ) {
    for (int y = 0; y < edit.height; y++ ) {
      int loc = x + y * edit.width;
      // What is current color
      color currentColor = edit.pixels[loc]; //color del pixel actual
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); //distancia entre dos puntos (norma euclídea)
                                                //d^2 = raiz((x1-x2)^2+(y1-y2)^2+(z1-z2)^2)
        if (d < threshold*threshold) {
        //calcula el punto medio (centro de gravedad)
        edit2.pixels[loc] = color(255,0,0);
        edit2.updatePixels();
        //image(edit2,640,0);
        //stroke(255,0,0);
        //strokeWeight(1);
        //point(x, y);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
   image(edit2,0,0);
  // We only consider the color found if its color distance is less than threshold. 
  // This threshold is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 24, 24);
    
    //Guardamos el valor del centro en un array
    centros[contador][0] = avgX;
    centros[contador][1] = avgY;
    contador++;
    //Reiniciamos el contador si ya tenemos todas las muestras en el array
    if(contador>=num_muestras){
        contador=0;
        
        //Usamos la media de todas las muestras
        Point mediaCentros = new Point(0.0,0.0);
        for(int k=0; k<num_muestras; k++){
        mediaCentros.x += centros[k][0] / num_muestras;
        mediaCentros.y += centros[k][1] / num_muestras;
         }
    //Dibujamos el vector que indica la dirección y módulo del movimiento
    stroke(0,255,0);
    strokeWeight(8);
    line(320,240,320-2*(-mediaCentros.x+centros[0][0]),240+2*(mediaCentros.y-centros[0][1])); 
    }
    
    }
  edit.updatePixels();

}

void captureEvent(Capture video) {
  video.read();
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

class Point{
  float x, y;
  Point (float posx, float posy){
   x = posx;
   y = posy;
 }
}
