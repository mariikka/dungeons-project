class Hero extends GameObjects {

  Weapon myWeapon;
  AnimatedGif currentAction;
  boolean immune;
  int immunetime = 0;
  color c;

  Hero() {
    super();
    hpMAX = hp = 100;
    loc = new PVector (0, 0);
    speed = 5;
    damage = 5;
    roomX = 1;
    roomY = 3;
    size = 40;
    c = green;
    immune = false;
    myWeapon = new AutoPistol();
    currentAction = spriteDown;
  }

  void show() {

    currentAction.show(loc.x, loc.y, size*2/1.5*1.5*1.5, size*2*1.5);
    //healthbar
    rectMode(CENTER);
    fill(brightRed);
    stroke(0);
    strokeWeight(2);
    float lifemeter = map(hp, 0, 100, 0, 70);
    rect(loc.x, loc.y + -35, 70, 10);
    fill(green);
    noStroke();
    rect(loc.x, loc.y - 35, lifemeter, 10);
  }

  void act() {

    //collisions updated for sprite siz3 
    if (loc.x > 635) loc.x = 634;
    if (loc.x < 42) loc.x = 41;
    if (loc.y > 430) loc.y = 429;
    if (loc.y < 35) loc.y = 34;


    super.act();



    if (immune) {
      immunetime++;
      c = red;
    }
    if (immunetime > 100) { 
      immune = false;
      immunetime = 0;
      c = green;
    }

    if (wkey) vel.y = -speed;
    if (skey) vel.y = speed;
    if (akey) vel.x = -speed;
    if (dkey) vel.x = speed;

    if (vel.mag() > speed) vel.setMag(speed);

    if (!wkey && !skey) vel.y = vel.y*0.9;
    if (!akey && !dkey) vel.x = vel.x*0.9;

    //currrrrent action
    if (abs(vel.y) > abs(vel.x)) {
      if (vel.y >= 0) currentAction = spriteDown;
      else currentAction = spriteUp;
    } else {
      if (vel.x > 0) currentAction = spriteRight;
      else currentAction = spriteLeft;
    }

    //moving around rooms

    if (northRoom!=#FFFFFF && loc.x > 309 && loc.x < 361 && loc.y <=34) {
      roomY--;
      loc = new PVector (width/2, 497);
      cleanUp();
    }

    if (eastRoom!=#FFFFFF && loc.y > 225 && loc.y < 230 && loc.x >= 634) {

      roomX++;
      loc = new PVector (113, height/2);
      cleanUp();
    }

    if (southRoom!=#FFFFFF && loc.x > 309 && loc.x < 376 && loc.y >= 428) {
      roomY++;
      loc = new PVector (width/2, 103);
      cleanUp();
    }

    if (westRoom!=#FFFFFF && loc.y > 225 && loc.y < 230 && loc.x <= 40) {
      roomX--;
      loc = new PVector (687, height/2);
      cleanUp();
    }
    myWeapon.update();
    if (spacekey) myWeapon.shoot();

    if (hp <=0) {
      mode = GAMEOVER;
    }
    if (hp > hpMAX) hp = hpMAX;

    //weapon pick function
    if (ONEkey) myWeapon = new AutoPistol();
    if (TWOkey) myWeapon = new ShotGun();
  }

  void cleanUp() {
    int i = 0;
    while (i < myObjects.size()) {
      GameObjects obj =  myObjects.get(i);
      if ( obj instanceof Bullet || obj instanceof Message) {
        if (!inRoomWith(obj)) {
          myObjects.remove(i);
          i--;
        }
      }
      i++;
    }
  }
}
