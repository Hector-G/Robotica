/*
Este programa es una versión modificada de LiveCamTest, programa de ejemplo 
incluido en la biblioteca OpenCV for Processing

Detección de caras y otros objetos
*/
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2, Capture.list()[0]);
  //La resolución se reduce para mejorar el tiempo de procesamiento
  opencv = new OpenCV(this, 640/2, 480/2);
  
  //Cargamos el filtro de detección
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);    
  /*
    OpenCV incluye por defecto varios tipos:
        CASCADE_FRONTALFACE
        CASCADE_PROFILEFACE
        CASCADE_CLOCK
        CASCADE_EYE
        CASCADE_MOUTH
        CASCADE_NOSE
        CASCADE_RIGHT_EAR
        CASCADE_FULLBODY
        CASCADE_UPPERBODY
        CASCADE_LOWERBODY
        CASCADE_PEDESTRIAN
        CASCADE_PEDESTRIANS
        
    Para pasar cualquier otro archivo cascade, indicar la ruta del archivo y true como segundo argumento:
    opencv.loadCascade("path/to/my/custom/cascade.xml", true)
  */

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

//dibujar un rectángulo donde se detecte un objeto
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length); //numero de caras detectadas

  for (int i = 0; i < faces.length; i++) { //para cada una de las caras
    println(faces[i].x + "," + faces[i].y); //posicion del objeto
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); //dibuja el rectangulo
  }
}

void captureEvent(Capture c) {
  c.read();
}
