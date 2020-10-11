class Sheep {
  float x, y;
  boolean state;
  PImage sheep;

  Sheep(String st) {
    sheep = loadImage(st);
    sheep.resize(118, 117);
    x=width/2;
    y=height/2;
  }

  void display() {
    image(sheep, x, y);
  }

  void move(float a, float b) {
    x=x+a;
    y=y+b;
  }
} 
