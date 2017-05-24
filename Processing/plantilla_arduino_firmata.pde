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

/* ***********************************************   
  METODOS INCLUIDOS EN STANDARD FIRMATA PARA ARDUINO:
  https://playground.arduino.cc/Interfacing/Processing
  
  Arduino.list() Devuelve una lista con todos los puertos donde se ha detectado un Arduino.
  
  Arduino(this,puerto,57600) El puerto seleccionado de Arduino.list(). El baudrate 57600 viene
      determinado por firmata y debe coincidir con el especificado en Arduino.
      
  pinMode(pin,modo) Declarar los pines de entrada o salida. Igual que en Arduino, sólo que en este
      caso INPUT y OUTPUT están definidas como Arduino.INPUT y Arduino.OUTPUT. También podemos 
      definir el modo Arduino.SERVO.
      
  digitalRead(pin) Leer pines digitales. Igual que en Arduino.
  
  digitalWrite(pin, value) Escibir en pines digitales. Igual que en Arduino, sólo que en este caso
      LOW y HIGH están definidas como Arduino.LOW y Arduino.HIGH
  
  analogRead(pin) Leer pin analógico. Igual que en Arduino, valores entre 0 y 1023.
  
  analogWrite(pin, valor) Escribir pin PWM. Igual que en Arduino, valores entre 0 y 255.
  
  servoWrite(pin, valor) Igual que en Arduino. En pines PWM, valores entre 0 y 180.
*/
