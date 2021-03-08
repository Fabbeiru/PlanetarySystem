// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Moon{
  
  int radius;
  float distance;
  float angle;
  float speed;
  PVector vector;
  PShape moon;
  String name;
  
  Moon(int radius, float distance, float angle, float speed, PVector vector, PImage texture, String name){
    this.radius = radius;
    this.distance = distance;
    this.angle = angle;
    this.speed = speed;
    this.vector = vector;
    this.name = name;
    
    noStroke();
    noFill();
    moon = createShape(SPHERE, radius);
    moon.setTexture(texture);
  }
  
  void orbit(){
    angle += speed;
    if(angle >= 360){
      angle = 0;
    }
  }
  
  void display(){
    pushMatrix(); 
    rotateY(angle); 
    translate(distance * vector.x, vector.y, vector.z); 
    shape(moon);
    textAlign(CENTER);
    textSize(16);
    text(name, 0, radius + 30);
    popMatrix();
  }
}
