/*
Plantilla con el código mínimo necesario para conectar Processing con
Arduino mediante firmata
*/
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

Arduino arduino; //Creamos un objeto tipo arduino, que referencia a una 
                 //placa en concreto. Si tuviésemos más de una, hay que
                 //crear varios con distinto nombre

void setup(){
  printArray(Arduino.list()); //Podemos ver el puerto USB al que está conectado Arduino
  arduino = new Arduino(this, Arduino.list()[0], 57600);//Conectamos al primer puerto
                                                        //de la lista: [0]
                                                        //57600 es la velocidad de 
                                                        //comunicación (es estándar)

 //ESCRIBE AQUI LOS PARAMETROS DE SETUP DE ARDUINO
 
 }

void draw(){
 //ESCRIBE AQUI EL CODIGO DE ARDUINO (LOOP)

}
