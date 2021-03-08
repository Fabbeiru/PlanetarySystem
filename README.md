# PlanetarySystem by Fabián Alfonso Beirutti Pérez
Planetary system using processing.

## Introducción
El objetivo de esta segunda práctica de la asignatura de 4to, Creación de Interfaces de Usuario (CIU), es empezar a tratar los conceptos y las primitivas básicas 3D para el dibujo de objetos. Para ello, se ha pedido el desarrollo de una aplicación capaz de crear a partir de un perfil de una figura, en la medida de lo posible, cualquier sólido de revolución usando el lenguaje de programación y el IDE llamado Processing. Este permite desarrollar código en diferentes lenguajes y/o modos, como puede ser processing (basado en Java), p5.js (librería de JavaScript), Python, entre otros.
<p align="center"><img src="/planetarySystemGif.gif" alt="Planetary system using processing"></img></p>

## Controles
Los controles de la aplicación se mostrarán en todo momento por pantalla para facilitar su uso al usuario:
- **Teclas W S:** Al presionar estas teclas podremos rotar nuestro sistema planetario para observar el resultado en su completitud.
- **Tecla ESC:** Cerrar la aplicación.

## Descripción
Aprovechando que el lenguaje de programación que utiliza el IDE Processing por defecto está basado en Java, podemos desarrollar nuestro código utilizando el paradigma de programación de "Programación Orientada a Objetos". Así pues, hemos descrito tres clases de Java:
- **PlanetarySystem:** clase principal.
- **Planet:** clase que representa al objeto/resultado de crear cada planeta.
- **Moon:** clase que representa al objeto/resultado de crear cada luna y/o satélite de un planeta.
- **Star:** clase que representa al objeto/resultado de crear una estrella.

## Explicación
### Clase PlanetarySystem
Esta es la clase principal de la aplicación, la cual gestiona la información mostrada por pantalla al usuario (interfaz gráfica), esto es, el desarrollo de los métodos setup() y draw().
```java
void setup() {
  size (1500, 844, P3D);
  surface.setTitle("Planetary System");
  menu = true;
  image = loadImage("Captura.png");
  bgImg = loadImage("background.jpg");
  rotateX = 0.0;
  rotateY = 0.0;
  initSystem();
}

void draw() {
  if (menu) menu();
  else {
    background(bgImg);
    showHelp();
    rotateX(radians(rotateX));
    drawSystem();
    rotateSystem();
  }
}
```
Aquí se declaran varios métodos que nos ayudan a mantener el código limpio y ordenado, además de permitir que en un futuro, si se realizan cambios, no afecten a todo el código. Tenemos dos métodos: *initSystem()* y *drawSystem()*, estos, son los encargados de cargar las imágenes/texturas que se le aplicaran a las esferas, inicializar los objetos que conforman el sistema planetario y de llamar a los métodos nativos de las clases de los objetos *Planet*, *Moon* y *Star* que mostrará por pantalla las esféras, su movimiento alrededor de un punto central (en nuestro caso, al representar el Sistema Solar, es el Sol), y comprobará y reseteará el ángulo de giro de los planetas y lunas y/o satélites.
```java
void initSystem() {
  sunImg = loadImage("Sun.jpg");
  mercuryImg = loadImage("Mercury.jpg");
  venusImg = loadImage("Venus.jpg");
  earthImg = loadImage("Earth.jpg");
  moonImg = loadImage("Moon.png");
  marsImg = loadImage("Mars.jpg");
  jupiterImg = loadImage("Jupiter.jpg");
  saturnImg = loadImage("Saturn.jpg");
  neptuneImg = loadImage("Neptune.jpg");
  this.sun = new Star (100, 5, 0, 0.25, new PVector(width/2, height/2, -550), sunImg, "Sun");
  this.moon = new Moon(15, 1.6, 0, 0.02, new PVector(55, 0, 1), moonImg, "Moon");
  this.mercury = new Planet (35, 4, 0,  0.50, new PVector(40, 0, 1), mercuryImg, "Mercury", null);
  this.venus = new Planet (45, 6, 0,  0.45, new PVector(40, 0, 1), venusImg, "Venus", null);
  this.earth = new Planet (55, 10, 0,  0.40, new PVector(40, 0, 1), earthImg, "Earth", moon);
  this.mars = new Planet (35, 13, 0,  0.35, new PVector(40, 0, 1), marsImg, "Mars", null);
  this.jupiter = new Planet (80, 18, 0,  0.30, new PVector(40, 0, 1), jupiterImg, "Jupiter", null);
  this.saturn = new Planet (65, 24, 0,  0.25, new PVector(40, 0, 1), saturnImg, "Saturn", null);
  this.neptune = new Planet (35, 30, 0,  0.15, new PVector(40, 0, 1), neptuneImg, "Neptune", null);
}

void drawSystem() {
  sun.orbit();  sun.display();
  mercury.orbit();  mercury.display();
  venus.orbit();  venus.display();
  earth.orbit();  earth.display();
  mars.orbit();  mars.display();
  jupiter.orbit();  jupiter.display();
  saturn.orbit();  saturn.display();
  neptune.orbit();  neptune.display();
}
```
Por otra parte, esta misma clase es la que maneja la interacción entre el usuario y la interfaz mediante la implementación de los métodos keyPressed(), keyReleased(), mousePressed(), entre otros. Un ejemplo se muestra a continuación:
```java
void keyPressed() {
  if (keyCode == ENTER) menu = false;
  
  keyStatus = true;
  if (key == 'W' || key == 'w') up = keyStatus;
  if (key == 'S' || key == 's') down = keyStatus;
}

void keyReleased() {
  keyStatus = false;
  if (key == 'W' || key == 'w') up = keyStatus;
  if (key == 'S' || key == 's') down = keyStatus;
}
```
Como se puede apreciar en el código anterior, cada vez que se presiona y se suelta una de las teclas, W o S, se actualizarán los valores de dos variables booleanas (toman el valor de verdadero o falso) que nos permitirán tener un mejor control sobre las acciones del usuario y su interacción con la interfaz. Así conseguimos que, el extra añadido a esta práctica, la rotación de nuestro sistema planetario, sea fluída y que no se noten parpadeos o cambios bruscos en las posiciones de las figuras.

### Clase Planet
Es la clase que representa a un Planeta. Aquí, se modifican y configuran las características y propiedades de cada objeto *Planet*, y donde están implementados los métodos *orbit()* y *display()*. Estos, comprobarán el ángulo de rotación y lo reseteará una vez se haya completado un giro/vuelta, y, muestra por pantalla la esfera, inicia su movimiento y añade su nombre debajo del mismo. 
```java
void orbit(){
    angle += speed;
    if(angle >= 360){
      angle = 0;
    }
    if(moon != null){
      moon.orbit();
    }
  }
  
  void display(){
    pushMatrix();
    rotateY(radians(angle));
    translate(distance * vector.x, vector.y, vector.z);
    shape(planet);
    textAlign(CENTER);
    textSize(16);
    text(name, 0, radius + 30);
    if(moon != null){
      moon.display();
    }
    popMatrix();
  }
```
Como se puede ver, cada objeto *Planet*, lleva asociado o no, otro objeto *Moon*, que en caso de disponer de uno, solo se mostrará por pantalla si existe el planeta al que está vinculado/relacionado, esto es, si un objeto *Planet* al inicializarlo se le indica un objeto *Moon*, el planeta será el encargado de llamar a los métodos *orbit()* y *display()* de la luna y/o satélite.

## Descarga y prueba
Para poder probar correctamente el código, es necesario descargar todos los ficheros (el .zip del repositorio) y en la carpeta llamada PlanetarySystem se encuentran los archivos de la aplicación listos para probar y ejecutar. El archivo "README.md" y aquellos fuera de la carpeta del proyecto (PlanetarySystem), son opcionales, si se descargan no deberían influir en el funcionamiento del código ya que, son usados para darle formato a la presentación y explicación del repositorio en la plataforma GitHub.

## Recursos empleados
Para la realización de este sistema planetario en 3D, se han consultado y/o utilizado los siguientes recursos:
* Guión de prácticas de la asignatura CIU
* <a href="https://processing.org">Página de oficial de Processing y sus referencias y ayudas</a>
* Processing IDE

Por otro lado, las librerías empleadas fueron:
* <a href="https://github.com/extrapixel/gif-animation">GifAnimation</a>
