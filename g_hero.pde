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
imageMode(CENTER);
    currentAction.show(loc.x, loc.y, size*2/1.5*1.5*1.5, size*2*1.5);
    imageMode(CORNER);

    //healthbar
    rectMode(CENTER);
    fill(brightRed);
    stroke(0);
    strokeWeight(2);
    float lifemeter = map(hp, 0, 100, 0, 70);
    rect(loc.x +20, loc.y + -20, 70, 10);
    fill(green);
    noStroke();
    rect(loc.x + 20, loc.y - 20, lifemeter, 10);
  }

  void act() {

    //collisions updated for sprite siz3 
    if (loc.x > 700) loc.x = 699;
    if (loc.x < 102) loc.x = 101;
    if (loc.y > 500) loc.y = 499;
    if (loc.y < 70) loc.y = 69;


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
    if (hp <=0) mode = GAMEOVER;
    if (pause) mode = PAUSE;
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

    if (northRoom!=#FFFFFF && loc.x > 364 && loc.x < 439 && loc.y <=69) {
      roomY--;
      loc = new PVector (width/2, 497);
      cleanUp();
    }

    if (eastRoom!=#FFFFFF && loc.y > 254 && loc.y < 314 && loc.x >= 697) {

      roomX++;
      loc = new PVector (113, height/2);
      cleanUp();
    }

    if (southRoom!=#FFFFFF && loc.x > 364 && loc.x < 439 && loc.y >= 499) {
      roomY++;
      loc = new PVector (width/2, 103);
      cleanUp();
    }

    if (westRoom!=#FFFFFF && loc.y > 254 && loc.y < 314 && loc.x <= 101) {
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
