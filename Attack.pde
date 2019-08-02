abstract class Attack {
  
  Bot bot;
  
  final int threshold;
  int weight;
  
  Attack(Bot b, int time) {
    bot = b;
    threshold = time * 20;
  }
  
  boolean charge() {
    if (weight == threshold) {
      hit();
      return true;
    }
    weight += 20;
    resize();
    return false;
  }
  
  abstract void resize();
  
  abstract void hit();
  
}



class AttackSweep extends Attack {
  
  final float direction;
  final float halfArc;
  final float minArc;
  final float maxArc;
  int radius = 0;
  
  AttackSweep(Bot bot, float dir, float arc, int time) {
    super(bot, time);
    direction = dir;
    if (arc > PI) arc = PI;
    this.halfArc = arc;
    minArc = direction - arc + 0.00001;
    maxArc = (direction + arc) % (2*PI);
  }
  
  void resize() {
    radius = (int) sqrt( (float)weight / halfArc );
    noFill();
    arc(bot.loc.x, bot.loc.y, radius, radius, minArc, maxArc, PIE);
    text("charging: " + radius, bot.loc.x - 20, bot.loc.y + 30);
    text("min: " + minArc, bot.loc.x - 20, bot.loc.y + 40);
    text("max: " + maxArc, bot.loc.x - 20, bot.loc.y + 50);
  }
  
  void hit() {
    for (int i = 0; i < players.size(); i++) {
      Bot player = players.get(i);
      if (player.id() == bot.id())
        continue;
      
      PVector sight = bot.loc.copy().sub(player.loc);
      if (sight.mag() < radius && inside(sight.heading(), minArc, maxArc))
        kill(player.id());
    }
    
    fill(255, 0, 0);
    arc(bot.loc.x, bot.loc.y, radius, radius, minArc, maxArc);
  }
  
  boolean inside(float subject, float minArc, float maxArc) {
    
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
