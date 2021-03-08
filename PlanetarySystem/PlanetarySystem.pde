// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

PImage image, bgImg, sunImg, mercuryImg, venusImg, earthImg, moonImg, marsImg, jupiterImg, saturnImg, neptuneImg;
Star sun;
Planet mercury, venus, earth, mars, jupiter, saturn, neptune;
Moon moon;

float rotateX, rotateY;
boolean menu, keyStatus, up, down;

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

void rotateSystem() {
    if (up && rotateX >= -45.0) rotateX -= 0.5;
    if (down && rotateX <= 45.0) rotateX += 0.5;
  }

// Initial screen
void menu() {
  background(0);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Planetary System", 750,150);
  text("3D model", 750,220);
  textSize(25);
  text("by Fabián B.", 750, 270);
  image(image, 420, 300);
  text("Press ENTER to continue", 750, 750);
}

// Display help
void showHelp() {
  textAlign(LEFT);
  text("> Press W and S keys to rotate the planetary system.", 20,50);
  text("> Press ESC to exit.", 20,100);
  text(rotateX, 1420, 50);
}

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
