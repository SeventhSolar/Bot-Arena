class Bot1 extends Bot {
  int id() { return 1; }
  
  void go() {
    push(1, 0.5);
  }
  
}

class Bot2 extends Bot {
  int id() { return 2; }
  
  void go() {
    if(dir.mag() == 0)
      push(1, 0);
    push(dir.copy().rotate(PI/2).setMag(1));
  }
  
}

class Bot3 extends Bot {
  int id() { return 3; }
  
  void go() {
    startAttack(0, 0, T360/2, 600);
  }
  
}

class Bot4 extends Bot {
  int id() { return 4; }
  
  void go() {
    startAttack(0, random(2*PI), random(PI), (int)random(2000));
  }
  
}

class Bot5 extends Bot {
  int id() { return 5; }
  
  void go() {
    
  }
  
}
