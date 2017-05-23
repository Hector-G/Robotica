/*
Este programa permite clicar sobre un pixel para seleccionar su color, después busca en la imagen todos 
los pixeles de color similar, dentro de una distancia umbral definida
*/
// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/nCVZHROb_dE

import processing.video.*;

Capture video;

color trackColor; 
float threshold = 80;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[0]);
  video.start();
  //Hasta aquí como en el ejemplo imagen_camara.pde
  trackColor = color(255, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels(); //Necesitamos loadPixels() para poder analizar los pixeles uno a uno
  image(video, 0, 0);

  float avgX = 0;
  float avgY = 0;

  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc]; //color del pixel actual
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
        stroke(255);
        strokeWeight(1);
        point(x, y);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

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
  }
}

//Funcion para calcular la distancia entre dos puntos en 3D
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

void mousePressed() {
  // Save color where the mouse is clicked in trackColor variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}
