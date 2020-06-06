//PVector pos, vel, acc;
class CelestialBody{
  
  float mass;
  float radius;
 
  PVector pos, vel, acc, tempPos, otherBodyPos;
  int moveHistoryLength = 300;
  //PVector[] pastPos = new PVector[moveHistoryLength];
  ArrayList<PVector> pastPos = new ArrayList<PVector>();
  int gravityC = 25;
  //int gravityC = 1000;
  boolean stopped;
  boolean selected = false;
  
  
  
  CelestialBody(float x, float y, float m, boolean stationary, float vx, float vy){
    
    pos = new PVector(x,y);
    vel = new PVector(vx,vy);
    acc = new PVector(0,0);
    mass = m;
    radius = sqrt(mass) * 25;
    stopped = stationary;
    pastPos.add(pos);
    print("INTIAL POS: " + pastPos.get(0));
  }
  
  void updateVelocity(ArrayList<CelestialBody> allBodies , float timeStamp){
  //  print("\n***********************************************\n" + this);
  //  print("\nInitial POS: " + this.pos);
    
    if(!stopped){
      for(int i= 0; i < allBodies.size(); i++){
  //    print("\nOTherBody POS: " + allBodies[i].pos);
        if(allBodies.get(i) != this){
          
          tempPos = pos.copy();
          otherBodyPos = allBodies.get(i).pos.copy();
          float otherBodyMass = allBodies.get(i).mass;
       //   print("\n" + pos);
          PVector deltaPos = otherBodyPos.sub(this.tempPos);
          float sqrtD = deltaPos.magSq();
        //  print("\ndelta: " + deltaPos);
        //  print("\n" + pos);
       //  print("\nOTherBody POS: " + allBodies[i].pos);
        //  print("\nSQuare dist: " + sqrtD);
        //print("\nOTherBody POS: " + allBodies[i].pos);
          PVector forceD = deltaPos.normalize();
         // print("\nOTherBody POS: " + allBodies[i].pos);
         // print("\n" + pos);
        //  print("\nfORCEd: " + forceD);
        //  print("\nOTherBody POS: " + allBodies[i].pos);
          PVector force = (forceD.mult(gravityC * mass * otherBodyMass)).div(sqrtD);
       //   print("\n" + pos);
       //   print("\nForce: " + force);
          acc = force.div(mass);
       //   print("\nAcceleration: " + acc);
          vel = vel.add(acc.mult(timeStamp));
       //   print("\nVelocity: " + vel);
        }
        
     //   print("\nMedium POS: " + this.pos);
        
     //   print("\nOTherBody POS: " + allBodies[i].pos);
      }    
    

  }
  
  }
  void updatePosition(float timeStamp){
   
    
    pos.add(vel.mult(timeStamp)); 
    this.display();
    PVector temp = new PVector(pos.x, pos.y, pos.z);
    
    pastPos.add(0,temp);
    if(pastPos.size() > moveHistoryLength){
      
       pastPos.remove(pastPos.size()-1); 
      
    }
   
  }
  
  void display() {
   // print("\nDisplay POS: " + this + " is at: " + this.pos);
    stroke(0);
    strokeWeight(2);
    fill(100);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void predictDisplay(){
    
    stroke(255);
    strokeWeight(1);
    fill(100);
    point(pos.x, pos.y);
    
  }   
 
  void clicked(float mx, float my){
    
     if(abs(mx-this.pos.x) < this.radius/2){
      
       this.selected = true;
            print("\nBODY SELECTED: " + this);
            print("\n" + abs(mx-this.pos.x) + " is less than: " + radius + " at " + this.pos.x + ", " + this.pos.y);
     }
    
    
  }
}
