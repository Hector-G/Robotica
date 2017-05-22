/*
Muestra la imagen de la cámara por pantalla y el color del pixel que apunta el ratón
clicando sobre la imagen guarda el valor en la consola
*/

import processing.video.*;

Capture video; //ver ejemplo en imagen_camara.pde

color c; //Las variables tipo color guardan 3 datos, con los valores de los canales RGB

void setup() {  
  size(640, 480);
 
  video = new Capture(this, 640, 480, Capture.list()[0]);
  
  video.start();
}


void draw() {

  image(video, 0, 0);
  c = get(mouseX, mouseY); //Obtener el valor del color en la posicion del mouse
  text("R: " + red(c) + " G: " + green(c) + " B: " + blue(c), mouseX, mouseY);
  
}

void mousePressed() {    
    //Si hacemos clic lo muestra por la consola
    println("R: " + red(c) + " G: " + green(c) + " B: " + blue(c)); 
}

void captureEvent(Capture c) {
  c.read();
}
