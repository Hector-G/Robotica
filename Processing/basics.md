# Sketch básico en Processing

[Página principal de Processing](https://processing.org/)

[Processing Reference](https://processing.org/reference)

[Tutorial en la web de Processing](https://processing.org/reference/environment/) (en inglés)

------

```processing

// Cabecera: incluir primero las bibliotecas que se van a utilizar
//ejemplo:
import processing.video.*;

//También se pueden añadir desde Sketch -> Importar biblioteca... ->
//Si no se encuentra instalada se puede buscar en el repositorio: Sketch -> Importar biblioteca... -> Añadir biblioteca...

//Al principio definimos también las variables globales
//Como por ejemplo:
int mi_variable1 = 100;
String mi_texto = "hola";


void setup(){
 //Dentro de setup definimos las propiedades del sketch e inicializamos variables
 //Este código se ejecuta una vez al iniciar el programa
 size(640,480); //Tamaño del lienzo en píxeles
 frameRate(12);  //Define el número de iteraciones por segundo
 
}

void draw(){
  //Este código se ejecuta una y otra vez en bucle
  background(150); //definir un color de fondo
  mi_funcion(); //ejecutar la función mi_funcion
}

//Aquí podemos crearnos funciones para el programa:
void mi_funcion(){
  background(random(250),random(20),random(50));
}

}
```
