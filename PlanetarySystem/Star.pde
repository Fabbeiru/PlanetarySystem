// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Star{
   
  int radius;
  float distance;
  float angle;
  float speed;
  PVector vector;
  PShape star;
  String name;
  
  Star(int radius, float distance, float angle, float speed, PVector vector, PImage texture, String name){
    this.radius = radius;
    this.distance = distance;
    this.angle = angle;
    this.speed = speed;
    this.vector = vector;
    this.name = name;
    
    noStroke();
    noFill();
    star = createShape(SPHERE, radius);
    star.setTexture(texture);
   }
  
  void orbit(){
    angle += speed;
    if(angle >= 360){
      angle = 0;
    }
  }
  
  void display(){
    translate(vector.x, vector.y, vector.z);
    pushMatrix();
    rotateY(radians(angle));
    shape(star);
    textAlign(CENTER);
    textSize(16);
    text(name, 0, radius + 30);
    popMatrix();
  }
}
