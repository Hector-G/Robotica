# Control del movimiento por software

Para mover el robot con el driver L298N podemos definir algunas funciones que regulen los pines:

```arduino
//NOTA: LOS NUMEROS DE LOS PINES NO ESTÁN DEFINIDOS
int PIN_FI = 00; //PIN FRONTAL IZQUIERDA
int PIN_FD = 00; //PIN FRONTAL DERECHA
int PIN_TI = 00; //PIN TRASERA IZQUIERDA
int PIN_TD = 00; //PIN TRASERA DERECHA
```

```arduino
void adelante(int velocidad){
  if((velocidad >= 0) && (velocidad <= 255)){
     arduino.analogWrite(PIN_FI, velocidad);
     arduino.analogWrite(PIN_FD, velocidad);
     arduino.analogWrite(PIN_TI, 0);
     arduino.analogWrite(PIN_TD, 0);
  }
}
```

```arduino
void atras(int velocidad){
  if((velocidad >= 0) && (velocidad <= 255)){
     arduino.analogWrite(PIN_FI, 0);
     arduino.analogWrite(PIN_FD, 0);
     arduino.analogWrite(PIN_TI, velocidad);
     arduino.analogWrite(PIN_TD, velocidad);
  }
}
```

```arduino
void parar(){
     arduino.analogWrite(PIN_FI, 0);
     arduino.analogWrite(PIN_FD, 0);
     arduino.analogWrite(PIN_TI, 0);
     arduino.analogWrite(PIN_TD, 0);
}
```

--------

## Control de giro

El giro del robot a derecha e izquierda lo realizamos por velocidad diferencial de las ruedas, es decir las ruedas de cada lado van a distinta velocidad produciendo que el robot rote alrededor de un punto.

![giro diferencial](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/giro_diferencial.png)

La posición del centro de giro se puede determinar con las velocidades de las ruedas:

![giro diferencial ecuacion](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/giro_dif_ecuacion.png)

A partir de esta ecuación se pueden trazar distintos tipos de curvas a diferentes velocidades. Por ejemplo:
  - Fijando la velocidad de la rueda exterior a 255 (máximo) y sabiendo el radio de giro de la curva podemos calcular la velocidad de la rueda interior (que lógicamente será menor que la de la rueda exterior)
  - Del mismo modo, fijando la velocidad de la rueda exterior a un valor más bajo que 255 tomaremos la curva a menor velocidad.
  - Si cada rueda gira en un sentido, el centro de giro estará ubicado en el punto medio entre las dos ruedas.
  
Este último caso es el que vamos a considerar en el próximo ejemplo de código, ya que permite que el robot tenga mayor maniobrabilidad

```arduino
void derecha(int velocidad){
  if((velocidad >= 0) && (velocidad <= 255)){
     arduino.analogWrite(PIN_FI, velocidad);
     arduino.analogWrite(PIN_FD, 0);
     arduino.analogWrite(PIN_TI, 0);
     arduino.analogWrite(PIN_TD, velocidad);
  }
}
```

```arduino
void izquierda(int velocidad){
  if((velocidad >= 0) && (velocidad <= 255)){
     arduino.analogWrite(PIN_FI, 0);
     arduino.analogWrite(PIN_FD, velocidad);
     arduino.analogWrite(PIN_TI, velocidad);
     arduino.analogWrite(PIN_TD, 0);
  }
}
```

Así el robot giraría sobre su propio centro pudiendo controlar la velocidad a la que rota.

---------

**\*\*\*\*\*** **EXPERIMENTAL** **\*\*\*\*\***

**Aviso: El siguiente código no está comprobado.**

Utilizando la ecuación anterior se pueden trazar distintos tipos de curvas. Las funciones que hay a continuación servirían para tomar una curva a una velocidad dada, con un radio de giro determinado. A nivel teórico, si el radio de giro es 0, se tiene el caso del ejemplo anterior en el que el robot gira sobre su propio centro. Cuando el radio es muy grande, con un radio infinito se obtendría una trayectoria en linea recta.

Los parámetros que hay que pasar al código son:

 - La separación entre ruedas, L
  	
 ```arduino
  float L_ENTRE_RUEDAS = 1.0; //Separación entre ruedas
```

 - La velocidad de avance, en porcentaje. Los valores posibles van entre +100 (adelante) y -100 (marcha atrás)
 
 - El radio de giro, en las mismas unidades que hemos definido L
 
 ```arduino
  void izquierda_R(float R, float velocidad){
  if((velocidad >= -100.0) && (velocidad <= 100.0)){
     int VD = int(velocidad);
     int VI = int(VD*(2*R/L_ENTRE_RUEDAS-1)/(2*R/L_ENTRE_RUEDAS+1));
     if(VD >= 0){
        arduino.analogWrite(PIN_FD, VD);
        arduino.analogWrite(PIN_TD, 0);
     }
     else{
        arduino.analogWrite(PIN_FD, 0);
        arduino.analogWrite(PIN_TD, -VD);
     }
     if(VI >= 0){
        arduino.analogWrite(PIN_FD, VI);
        arduino.analogWrite(PIN_TD, 0);
     }
     else{
        arduino.analogWrite(PIN_FD, 0);
        arduino.analogWrite(PIN_TD, -VI);
     }
  }
}
```

```arduino
  void derecha_R(float R, float velocidad){
  if((velocidad >= -100.0) && (velocidad <= 100.0)){
     int VI = int(velocidad);
     int VD = int(VI*(2*R/L_ENTRE_RUEDAS-1)/(2*R/L_ENTRE_RUEDAS+1));
     if(VD >= 0){
        arduino.analogWrite(PIN_FD, VD);
        arduino.analogWrite(PIN_TD, 0);
     }
     else{
        arduino.analogWrite(PIN_FD, 0);
        arduino.analogWrite(PIN_TD, -VD);
     }
     if(VI >= 0){
        arduino.analogWrite(PIN_FD, VI);
        arduino.analogWrite(PIN_TD, 0);
     }
     else{
        arduino.analogWrite(PIN_FD, 0);
        arduino.analogWrite(PIN_TD, -VI);
     }
  }
}
```

**\*\*\*\*\*\*\*\*\*\*\*\*\*\*\***
