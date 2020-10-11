/**
 * Chi Nguyen<ln2569@bard.edu>
 * 11/12/2018
 * CMCS141
 * Final Project
 * Assignment description: Final project for CMCS141: OOP
 * I worked alone on this assignment
 */

Sheep sheep; //create chacracter
Enemy wolfleft, wolfright; //create enemy
PImage backgroundmain, bgleft, bgright, bgbottom, backgroundstart; //image for background
float wolfX=0; //moving enemy
boolean wolfcheck=true; //boolean check if enemy reach the border of the screen
Obstacles[] ballons, staticObj, arrows;
int totalBallons=0, totalStatic=0, totalArrows;
Timer timerBallons, timerStatic, timerArrows;
int timerS, timerB, timerA;
int point;
boolean start=false, end=false;


void setup() {
  size(540, 960);
  timerB=5000;
  timerBallons = new Timer(timerB); 
  timerBallons.start();

  timerS= int(random(5000, 10000));
  timerStatic = new Timer(timerS); 
  timerStatic.start();

  timerA= int(random(5000, 10000));
  timerArrows = new Timer(timerS); 
  timerArrows.start();

  //setup for the backgound and create the chacracter
  sheep = new Sheep("chacracter.png");
  wolfleft = new Enemy("enemy.png");
  wolfright = new Enemy("enemy1.png");
  backgroundmain = loadImage("background.png");
  backgroundstart = loadImage("start.jpg");
  bgleft = loadImage("left.png");
  bgright = loadImage("right.png");
  bgbottom = loadImage("bottom.png");
  backgroundmain.resize(540, 960);
  bgleft.resize(96, 960);
  bgright.resize(114, 960);
  bgbottom.resize(540, 162);

  //create an array of ballon
  ballons = new Obstacles[1000];
  ballons[0]= new Obstacles("Floating object "+0+".png");
  ballons[0].y=height;
  ballons[0].x=random(100, width-100);
  ballons[0].resize(65, 160);

  //create an array of static object
  staticObj = new Obstacles[1000];
  staticObj[0] = new Obstacles("static object "+0+".png");
  staticObj[0].resize(120, 199);
  staticObj[0].y=0;
  staticObj[0].x=random(100, width-100);

  //create an array of Arrows
  arrows = new Obstacles[1000];
  arrows[0] = new Obstacles("arrow "+0+".png");
  arrows[0].resize(108, 30);
  arrows[0].x=-10;
  arrows[0].y=random(100, height-100);
}


//Ballons Bonus point obstacles
void ballonsRandomDisplay() {
  for (int i = 0; i < totalBallons; i++ ) {
    ballons[i].moveup();
    ballons[i].display();
  }
}
void ballonSpawning() {
  if (timerBallons.isFinished()) {
    totalBallons++; //increase total ballons
    int i = int(random(0, 5));
    ballons[totalBallons] = new Obstacles("Floating object "+i+".png");
    ballons[totalBallons].y=height;
    ballons[totalBallons].x=random(100, width-100);
    ballons[totalBallons].resize(65, 160);
    if (totalBallons >= ballons.length) {
      totalBallons = 0; //start over
    }
    //decrease the number of ballons bonus object overtime and at a boundary
    if (timerB<=10000) {
      timerB= timerB+100;
    }
    timerBallons = new Timer(timerB); 
    timerBallons.start();
  }
}

//Static obstacles
void staticRandomDisplay() {
  for (int i = 0; i < totalStatic; i++ ) {
    staticObj[i].movedown();
    staticObj[i].display();
  }
}
void staticSpawning() {
  if (timerStatic.isFinished()) {
    totalStatic++; //increase total ballons
    int i = int(random(0, 6));
    staticObj[totalStatic] = new Obstacles("static object "+i+".png");
    staticObj[totalStatic].resize(120, 199);
    staticObj[totalStatic].y=-100;
    staticObj[totalStatic].x=random(100, width-100);
    if (totalStatic >= staticObj.length) {
      totalStatic = 0; //start over
    }
    //increase the number of static object overtime and at a boundary
    if (timerS>=2000) {
      timerS= timerS-100;
    }
    timerStatic = new Timer(timerS);
    timerStatic.start();
  }
}

//Arrows obstacles
void arrowsRandomDisplay() {
  for (int i = 0; i < totalArrows; i++ ) {
    arrows[i].moveright();
    arrows[i].display();
  }
}
void arrowsSpawning() {
  if (timerArrows.isFinished()) {
    totalArrows++; //increase total ballons
    int i = int(random(0, 2));
    arrows[totalArrows] = new Obstacles("arrow "+i+".png");
    arrows[totalArrows].resize(108, 30);
    arrows[totalArrows].x=-10;
    arrows[totalArrows].y=random(50, height-100);
    if (totalArrows >= arrows.length) {
      totalArrows = 0; //start over
    }
    //increase the number of arrows overtime and at a boundary
    if (timerA>=2000) {
      timerA= timerA-100;
    }
    timerArrows = new Timer(timerA);
    timerArrows.start();
  }
}

//moving sheep
void keyPressed() {
  if (key == CODED && keyCode == LEFT) {
    sheep.move(-20, 0);
  } else if (key == CODED && keyCode == RIGHT) {
    sheep.move(20, 0);
  }
  if (key == CODED && keyCode == UP) {
    sheep.move(0, -20);
  } else if (key == CODED && keyCode == DOWN) {
    sheep.move(0, 20);
  }
  if (key=='s') {
    start=true;
    end=false;
  }
  if(key=='r'){
    start=false;
    end=false;
  }
}

//https://www.openprocessing.org/sketch/8005/#
boolean rectRectIntersect(float left, float top, float right, float bottom, 
  float otherLeft, float otherTop, float otherRight, float otherBottom) {
  return !(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop);
}


void MeetObjBonus(Obstacles[] obj, int total) {
  for (int i=0; i<total; i++) {
    if ((rectRectIntersect(sheep.x, sheep.y, sheep.x+118, sheep.y+117, obj[i].x, obj[i].y, obj[i].x+obj[i].xwidth, obj[i].y+obj[i].yheight) == true)) {
      obj[i].x=-10000;
      obj[i].y=-10000;
      point++;
    }
  }
}

void MeetObjStatic(Obstacles[] obj, int total) {
  for (int i=0; i<total; i++) {
    if ((rectRectIntersect(sheep.x, sheep.y, sheep.x+118, sheep.y+117, obj[i].x+(6*obj[i].xwidth/7), obj[i].y+(9*obj[i].yheight/10), obj[i].x+obj[i].xwidth/2, obj[i].y+obj[i].yheight) == true)) {
      sheep.y=obj[i].y+obj[i].yheight;
    } else sheep.y=sheep.y;
  }
}

void MeetObjDeath(Obstacles[] obj, int total) {
  for (int i=0; i<total; i++) {
    if ((rectRectIntersect(sheep.x, sheep.y, sheep.x+118, sheep.y+117, obj[i].x+50, obj[i].y+10, obj[i].x+obj[i].xwidth, obj[i].y+obj[i].yheight-10) == true)) {
      obj[i].x=-10000;
      obj[i].y=-10000;
      end=true;
    }
  }
}


void gameStart() {
  background(backgroundstart);
  point=0;
}

void end() {
  background(0);
  fill(255);
  textSize(60);
  text("YOU HAVE FALLEN",30,height/2-100);
  text("TO YOUR DEATH",30,height/2-50);
  text("POINT:        "+ point,50,height/2-200);
  text("PRESS R to return",30,height/2+100);
  text("To main menu",30,height/2+150);
}


void draw() {
  if (start==false) {
    gameStart();
    totalBallons=0;
    totalStatic=0;
    totalArrows=0;
    end=false;
    sheep.x=width/2;
    sheep.y=height/2;
  }
  if (start && end==false) {
    //display background
    background(backgroundmain);

    //display sheep
    sheep.display();

    //display static object
    staticSpawning();
    staticRandomDisplay();
    MeetObjStatic(staticObj, totalStatic);

    //display arrows
    arrowsSpawning();
    arrowsRandomDisplay();

    //display bubble
    image(bgbottom, 0, height-162);
    image(bgleft, 0, 0);
    image(bgright, width-114, 0);

    //display ballons
    ballonSpawning();
    MeetObjBonus(ballons, totalBallons);
    ballonsRandomDisplay();

    //Display point
    fill(0);
    textSize(30);
    text("Point:    "+point, 50, 50);

    //code for moving the enemy
    if (wolfX<=0) { 
      wolfcheck=true;
    }
    if ( wolfX>=width-100) {
      wolfcheck=false;
    }
    if (wolfcheck) {
      wolfX+=5;
      wolfright.x=wolfX;
      wolfright.display();
      wolfright.moveright();
    } else if (!wolfcheck) {
      wolfX-=5;
      wolfleft.x=wolfX;
      wolfleft.display();
      wolfleft.moveleft();
    }
    //ways to die
    MeetObjDeath(arrows,totalArrows);
    if(sheep.y>=height-250){
      end=true;
    }
    sheep.x= constrain(sheep.x,50,width-150);
    sheep.y= constrain(sheep.y,50,height-50);
    if (end) {
      end();
    }
  }
}
