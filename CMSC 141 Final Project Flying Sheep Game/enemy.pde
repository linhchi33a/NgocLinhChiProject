class Enemy {
  float x, y;
  boolean state;
  PImage enemy;

  Enemy(String st) {
    enemy = loadImage(st);
    enemy.resize(112, 131);
    x=0;
    y=height-162;
  }

  void display() {
    image(enemy, x, y);
  }

  void moveright() {
    x+=5;
  }
  void moveleft(){
    x-=5;
  }
} 
