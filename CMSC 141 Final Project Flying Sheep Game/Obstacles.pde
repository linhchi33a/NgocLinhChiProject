class Obstacles{
  float x,y,xwidth,yheight;
  PImage obj;
  
   Obstacles(String st){
     x=width/2;
     y=height/2;
     obj = loadImage(st);
   }
   
   void display(){
     image(obj,x,y);
   }
   void resize(int x,int y){
     obj.resize(x,y);
     xwidth=x;
     yheight=y;
   }
   
   void moveup(){
     y-=random(5,10);
   }
   void movedown(){
     y+=1;
   }
   void moveright(){
     x+=5;
   }
   
}
