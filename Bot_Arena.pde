import java.util.Collections;

final static float T360 = 2*PI;

ArrayList<Bot> players = new ArrayList<Bot>();
int playerCount = 5;

void setup() {
  size(1000, 1000);
  ellipseMode(RADIUS);
  strokeWeight(4);
  fill(255);
  players.add(new Bot1());
  players.add(new Bot2());
  players.add(new Bot3());
  players.add(new Bot4());
  players.add(new Bot5());
}

ArrayList<Integer> killQueue;
int queueLength;

void draw() {
  background(150);
  for (int i = 0; i < players.size(); i++) {
    players.get(i).run();
  }
  
  clean();
}

void kill(int id) {
  if (queueLength == 0)
    killQueue = new ArrayList<Integer>();
  
  killQueue.add(id);
  queueLength++;
}

void clean() {
  if (queueLength > 0) {
    for (int i = 0; i < queueLength; i++)
      for (int j = 0; j < players.size(); j++)
        if (players.get(j).id() == killQueue.get(i)) {
          players.get(j).dead = true;
          players.remove(j);
          playerCount --;
          break;
        }
    queueLength = 0;
  }
}
