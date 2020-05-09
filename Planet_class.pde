//PVector pos, vel, acc;
class CelestialBody{
  
  float mass;
  float radius;
 
  PVector pos, vel, acc, tempPos, otherBodyPos;
  //int gravityC = 25;
  int gravityC = 1000;
    boolean stopped;
  
  
  CelestialBody(float x, float y, float m, boolean stationary, float vx, float vy){
    
    pos = new PVector(x,y);
    vel = new PVector(vx,vy);
    acc = new PVector(0,0);
    mass = m;
    radius = sqrt(mass);
    stopped = stationary;
    
  }
  
  void updateVelocity(CelestialBody allBodies[] , float timeStamp){
  //  print("\n***********************************************\n" + this);
  //  print("\nInitial POS: " + this.pos);
    
if(!stopped){
      for(i= 0; i < allBodies.length; i++){
  //    print("\nOTherBody POS: " + allBodies[i].pos);
        if(allBodies[i] != this){
          
          tempPos = pos.copy();
          otherBodyPos = allBodies[i].pos.copy();
          float otherBodyMass = allBodies[i].mass;
       //   print("\n" + pos);
          PVector deltaPos = otherBodyPos.sub(this.tempPos);
          float sqrtD = deltaPos.magSq();
          print("\ndelta: " + deltaPos);
        //  print("\n" + pos);
       //  print("\nOTherBody POS: " + allBodies[i].pos);
          print("\nSQuare dist: " + sqrtD);
        //print("\nOTherBody POS: " + allBodies[i].pos);
          PVector forceD = deltaPos.normalize();
         // print("\nOTherBody POS: " + allBodies[i].pos);
         // print("\n" + pos);
          print("\nfORCEd: " + forceD);
        //  print("\nOTherBody POS: " + allBodies[i].pos);
          PVector force = (forceD.mult(gravityC * mass * otherBodyMass)).div(sqrtD);
       //   print("\n" + pos);
          print("\nForce: " + force);
          acc = force.div(mass);
          print("\nAcceleration: " + acc);
          vel = vel.add(acc.mult(timeStamp));
          print("\nVelocity: " + vel);
        }
        
     //   print("\nMedium POS: " + this.pos);
        
     //   print("\nOTherBody POS: " + allBodies[i].pos);
      }    
    

  }
  
  
  void updatePosition(float timeStamp){
    
  //  print("\nPos1: " + pos);
  //  print("\nDelta: " + (vel.mult(timeStamp)));
    
    pos.add(vel.mult(timeStamp));
    this.display();
  //  print("\nPos2: " + pos);
    
  }
  
  void display() {
    print("\nDisplay POS: " + this + " is at: " + this.pos);
    stroke(0);
    strokeWeight(2);
    fill(100);
    ellipse(pos.x, pos.y, mass*25, mass*25);
  }
}
