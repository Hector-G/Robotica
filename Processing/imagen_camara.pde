/* Este sencillo ejemplo toma imágenes a través de la cámara y las muestra
   en la pantalla. O lo que es lo mismo, ver la cámara en vídeo por pantalla

  Se utiliza la biblioteca de video estandar de Processing
  
*/


import processing.video.*; //bibliotecas de video de Processing

Capture video; //Crear un objeto tipo Capture (captura imagenes de camara)


void setup() {
  size(640, 480); //Tamaño del lienzo a mostrar
  video = new Capture(this, 640, 480); //Cuanto más pequeña sea la resolución del video, más rápido lo procesará

  video.start(); //Iniciar la captura
}

void draw() {
  //scale(2); //Podemos reescalar la imagen

  image(video, 0, 0 ); //Mostrar la imagen capturada
}

//Utilizamos captureEvent para que la cámara pueda refrescar la imagen
void captureEvent(Capture c) {
  c.read();
}
