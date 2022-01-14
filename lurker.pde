class Lurker extends Enemy {
  Lurker(int x, int y, int locx, int locy) {
    super(176, 50, x, y);
    loc = new PVector (locx, locy);
  }

  void show() {
    imageMode(CENTER);
    image(lurker, loc.x, loc.y, 100, 100);
    imageMode(CORNER);
    noStroke();
    noFill();
    circle(loc.x, loc.y, size);
    fill(black);
    textSize(20);
    text(hp, loc.x, loc.y);
  }
  void act() {
    super.act();
    if (dist(myHero.loc.x, myHero.loc.y, loc.x, loc.y)< 100) {
      vel = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
      vel.setMag(1);
    }

    if (hp <=0) {
      myObjects.add(new Message(loc.x, loc.y, 5));
      myObjects.add(new droppedItempoison(loc.x, loc.y, roomX, roomY));
    }
  }
}
