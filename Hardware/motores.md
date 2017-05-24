## EL PUENTE H Y EL DRIVER L298N

----------

![PuenteH-01](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/PUENTEH01.png "Esquema básico del puente H")

La conexión en puente H es una configuración simple para regular el sentido de giro de un motor de CC.

![PuenteH-02](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/puenteH02.png "Configuración de giro A puente H")

Activando la primera pareja de transistores conseguimos que la corriente circule de izquierda a derecha a través del motor, haciendo que gire.

![PuenteH-03](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/puenteH03.png "Configuración de giro B puente H")

Activando la segunda pareja de transistores conseguimos que la corriente circule de derecha a izquierda a través del motor, haciendo que gire en sentido contrario.

Es importante activar los transistores correctos y dejar desactivados los otros dos, de lo contrario produciríamos un cortocircuito causando daños a la electrónica.

Como la manera de controlarlo es siempre por parejas, podemos conectar los transistores dos a dos:

![PuenteH-04](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/PUENTEH04.png "Puente H")

Así, activando el pin IN1 y apagando IN2 haremos que gire en un sentido. Apagando IN1 y activando IN2 girará en el otro sentido. Apagando ambos detendremos el motor. Y activando ambos el motor también se detendrá, pero es una situación no deseable para el circuito.

-------

El driver L298N tiene conexiones para dos motores, de manera que los pines IN1, IN2 controlan el MOTOR1 y los pines IN3, IN4 controlan el MOTOR2.

![Driver L298N](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/L298N.png "Driver L298N")

Además, si utilizamos señales PWM para controlar los motores, podemos regular la velocidad.

-------

Conectando el driver L298N con un Arduino UNO quedaría tal que así:

![Motor Arduino](https://github.com/Hector-G/Robotica/blob/master/Hardware/imagenes/robot_arduino_motor.png "Motor Driver y Arduino")
