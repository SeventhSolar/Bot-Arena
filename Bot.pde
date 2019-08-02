abstract class Bot {
  
  boolean dead = false;
  
  PVector loc = new PVector();
  
  Bot() {
    loc.x = (int) random(1000);
    loc.y = (int) random(1000);
  }
  abstract int id();
  
  PVector dir = new PVector();
  void push(PVector vector) {
    dir.add(vector.normalize());
    if (dir.mag() > 2)
      dir.setMag(2);
  }
  
  void push(float x, float y) {
    push(new PVector(x, y));
  }
  
  //---------------------------------------
  
  
  
  
  
  //---------------------------------------
  
  boolean CHARGING = false;
  
  private Attack attack;
  
  private void chargeAttack() {
    if (attack.charge())
      CHARGING = false;
  }
  
  void startAttack(int attackID, float dir, float param, int time) {
    if (CHARGING) return;
    
    switch (attackID) {
    case 0:
      attack = new AttackSweep(this, dir, param, time);
      break;
    //case 1:
    //  attack = new AttackStrike(this, dir, param, time);
    }
    
    CHARGING = true;
  }
  
  void releaseAttack() {
    if (CHARGING) {
      CHARGING = false;
      attack.hit();
    }
  }
  
  int attackWeight() {
    return attack.weight;
  }
  
  
  boolean WAITING = false;
  
  void run() {
    go();
    
    PVector vel = dir.copy();
    if (CHARGING) {
      float weight = attack.weight / 1000;
      vel.mult( weight > 1 ? 0 : 1 - weight ); 
    }
    
    loc.x += vel.x;
    if (loc.x < 0)
      loc.x = 0;
    if (loc.x > 999)
      loc.x = 999;
    
    loc.y += vel.y;
    if (loc.y < 0)
      loc.y = 0;
    if (loc.y > 999)
      loc.y = 999;
    
    dir.mult(0.95);
    
    if (CHARGING) {
      chargeAttack();
    }
    
    sketch();
  }
  
  abstract void go();
  
  void sketch() {
    fill(255);
    circle(loc.x, loc.y, 20);
    text(CHARGING ? "true" : "false", loc.x - 20, loc.y - 20);
  }
  
}
