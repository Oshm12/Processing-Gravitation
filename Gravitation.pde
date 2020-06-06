import controlP5.*;
ControlP5 cp5;

CelestialBody p1;
CelestialBody p2;
CelestialBody p3;
//CelestialBody[] bodies = new CelestialBody[2];
ArrayList<CelestialBody> bodies = new ArrayList<CelestialBody>();
float timeStamp = 1;
boolean started = false, moving = false, begun = false, stationary = false;
int predictLength = 1000;
int xVel = 0;
int yVel = 0;
int newMass = 2;

void setup() {
  
  size(1000,1000);
  background(10);
  cp5 = new ControlP5(this);
  cp5.addSlider("xVel").setPosition(75,75).setRange(-5,5);
  cp5.addSlider("yVel").setPosition(75,90).setRange(-5,5);
  cp5.addSlider("newMass").setPosition(75,105).setRange(0,20);
  cp5.addToggle("stationary").setPosition(75,40);
  
  p1 = new CelestialBody(250,500,2, false, 0, 1);
  p2 = new CelestialBody(500,500,10,true, 0,0);
  //p1 = new CelestialBody(250,500,2, false, 0, 1);
  //p2 = new CelestialBody(750,500,2, false, 0, -1);
 
 
 // print(bodies);
  //print("ONCE IN A LFIMTEIM");
  //print(bodies.length);
  //noLoop();
  //bodies[0] = p1;
  //bodies[1] = p2;
  bodies.add(p1);
  bodies.add(p2);
  
 //  p1.display();
//  p2.display();
  //p3.display();
  predictive();
}

void draw() {

  
  if(!started){
     background(10);  
     predictive();
     
     for(int i = 0; i < bodies.size() ; i++){
     
        bodies.get(i).display();
     
     }
    
  }
  
  if(started){
    print("\nLOOOP");
   
    background(10);
     
   
   
     for(int i = 0; i < bodies.size() ; i++){
      //print("\n*****************************" + bodies[i].pos);
      
       bodies.get(i).updateVelocity(bodies, timeStamp);
       
       
     }
     
     for(int i = 0; i < bodies.size() ; i++){
       
       
       bodies.get(i).updatePosition(timeStamp);
       
       
     }
     history();
   }
   
   
} 

void predictive() {
  
  PVector[] predictLine = new PVector[bodies.size()];
  PVector[] initialV = new PVector[bodies.size()];
  PVector[] initialPos = new PVector[bodies.size()];
  //initialV = bodies.vel;
  for(int i = 0; i < bodies.size() ; i++){
   
    initialV[i] = bodies.get(i).vel.copy();
    initialPos[i] = bodies.get(i).pos.copy();
    
  }
  
  for(float y = 0 ; y < predictLength; y++){
    for(int i = 0; i < bodies.size() ; i++){
        //print("\n*****************************" + bodies[i].pos);
        
         bodies.get(i).updateVelocity(bodies, timeStamp);
         
         
    }
  
    for(int i = 0; i < bodies.size() ; i++){
        //print("\n*****************************" + bodies[i].pos);
        
         predictLine[i] = bodies.get(i).pos;
         predictLine[i].add(bodies.get(i).vel.mult(timeStamp));
         
         //bodies[i].predictDisplay();
          stroke(255-((y/predictLength)*245));
          //print("\n" + (255-((y/predictLength)*255)));
          point(predictLine[i].x, predictLine[i].y);
    }
  
  }

  for(int i = 0; i < bodies.size() ; i++){
   
    bodies.get(i).vel = initialV[i];
    bodies.get(i).pos = initialPos[i];

  }
}

void history(){
  
  for(int i = 0; i < bodies.size() ; i++){
    //print(bodies.get(i).pastPos);
    for(int j = 0; j < bodies.get(i).pastPos.size(); j++){
      
      
       PVector tempPos = bodies.get(i).pastPos.get(j);
      
        if(tempPos != null){
          //print("\nBody: " + i + " Position at J: " + j + " original: " + bodies.get(i).pastPos[j] + ". at here: " + tempPos );
          //stroke(255,0,0);
          stroke(255-(245*j/bodies.get(i).pastPos.size()));
          //print("\nSIZE OF SHI(T: " + bodies.get(i).pastPos.size());
         // print("\n" + (245*j/bodies.get(i).pastPos.size()) + " at j = " + j);
          //print("\n***************" + bodies.get(i).pastPos.size());
          //print("MAKING POINT AT: X: " + tempPos.x+ " Y: " + tempPos.y);
          point(tempPos.x, tempPos.y);
      }
    }
    
    //print(bodies.get(i).pastPos);
  }
}
 
 void mousePressed(){
   started = false;

   for(int i = 0; i < bodies.size() ; i++){
       
         bodies.get(i).clicked(mouseX, mouseY);
       
       
     }
  
 
  
 }
 
 void mouseDragged() {
   //background(255);
   for(int i = 0; i < bodies.size() ; i++){
       
     if(bodies.get(i).selected){
       
       bodies.get(i).pos.x = mouseX;
       bodies.get(i).pos.y = mouseY;
       
     }
     
     bodies.get(i).display();
   
   }
 }
 
 void mouseReleased(){
   
   if(begun){
     started = true;
   }
   
   for(int i = 0; i < bodies.size() ; i++){
     
    bodies.get(i).selected = false;
     
   }
 }
 
 void keyPressed(){
   print("\nKey Pressed");
   print("\n" + keyCode);
   
   if(keyCode == ENTER){
      if(started){
       
        started = false;
        return;
      }
      
      if(!started){
       
        started = true;
        begun = true;
        return;
        
      }
   }
   
   if(key == 'n' || key == 'N'){
     
     bodies.add(new CelestialBody(mouseX,mouseY,newMass, stationary, xVel, yVel));
     
     
   }
 }
