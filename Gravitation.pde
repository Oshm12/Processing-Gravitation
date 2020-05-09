CelestialBody p1;

CelestialBody p2;
CelestialBody p3;
CelestialBody[] bodies;
float timeStamp = 1;
boolean started = false;

void setup() {
  
  size(1000,1000);
  background(10);
  
  //p1 = new CelestialBody(250,500,2, false, 0, 1);
  p2 = new CelestialBody(500,500,10,true, 0,0);
  //p1 = new CelestialBody(250,500,2, false, 0, 1);
  //p2 = new CelestialBody(750,500,2, false, 0, -1);
 
 
 // print(bodies);
  //print("ONCE IN A LFIMTEIM");
  //print(bodies.length);
  //noLoop();
  
   p1.display();
  p2.display();
  //p3.display();
}

void draw() {
  CelestialBody[] bodies = new  CelestialBody[]{p1, p2};
  
  
  if(!started){
    
   //add predictive paths 
    
    
  }
  
  if(started){
    print("\nLOOOP");
   
    background(255);
     
   
   
     for(int i = 0; i < bodies.length ; i++){
      //print("\n*****************************" + bodies[i].pos);
      
       bodies[i].updateVelocity(bodies, timeStamp);
       
       
     }
     
     for(int i = 0; i < bodies.length ; i++){
       
       
       bodies[i].updatePosition(timeStamp);
       
       
     }
   }
} 
 void mouseClicked() {
   
   for(int t = 0; t < bodies.length; t++){
     
   }
   
 }
 
 void keyPressed(){
   print("\nKey Pressed");
   print("\n" + keyCode);
   
   if(keyCode == ENTER){
      if(started){
       
        started = false;
        
      }
      
      if(!started){
       
        started = true;
        
      }
     
     
     
     
   }
   
 }
