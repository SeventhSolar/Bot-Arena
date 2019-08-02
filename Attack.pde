abstract class Attack {
  
  Bot bot;
  
  final int threshold;
  int weight;
  
  Attack(Bot b, int time) {
    bot = b;
    threshold = time * 10;
  }
  
  boolean charge() {
    if (weight == threshold) {
      hit();
      return true;
    }
    weight += 10;
    resize();
    return false;
  }
  
  abstract void resize();
  
  abstract void hit();
  
}



class AttackSweep extends Attack {
  
  final float direction;
  final float arc;
  int radius = 0;
  
  AttackSweep(Bot bot, float dir, float arc, int time) {
    super(bot, time);
    direction = dir;
    if (arc > PI) arc = PI;
    this.arc = arc;
  }
  
  void resize() {
    radius = (int) sqrt( (float)weight * 2 / arc );
  }
  
  void hit() {
    for (int i = 0; i < players.size(); i++) {
      Bot player = players.get(i);
      if (player.id() == bot.id())
        continue;
      
      PVector sight = bot.loc.copy().sub(player.loc);
      if (sight.mag() < radius && inside(sight.heading(), direction, arc))
        kill(player.id());
    }
  }
  
  boolean inside(float subject, float center, float halfArc) {
    float minArc = center - halfArc;
    float maxArc = center + halfArc;
    
    if (minArc > maxArc) minArc -= 2*PI;
    
    if (minArc < 0) {
      subject = (subject - minArc) % (2*PI);
      maxArc -= minArc;
      minArc = 0;
    }
    
    return subject > minArc && subject < maxArc;
  }
  
}



class AttackStrike extends Attack {
  
  final float direction;
  final int halfWidth;
  int length;
  
  AttackStrike(Bot bot, float dir, float width, int time) {
    super(bot, time);
    direction = dir;
    this.halfWidth = (int) width;
  }
  
  void resize() {
    length = (int)( (float) weight / (2 * halfWidth) );
  }
  
  void hit() {
    for (int i = 0; i < players.size(); i++) {
      Bot player = players.get(i);
      if (player.id() == bot.id())
        continue;
      
      PVector sight = bot.loc.copy().sub(player.loc);
      if (false)
        kill(player.id());
    }
  }
  
}
