void gameover() {
  background(white);
  fill(0);
  textSize(100);
  textFont(iFont);

  
  //bg
  image(graves, 0, 0, 800, 600);
  
  fill(black);
  stroke(white);
  strokeWeight(5);
  rectMode(CENTER);
  rect(400, 120, 550, 100);
  fill(white);
  textAlign(CENTER);
  textSize(100);
    text("GAMEOVER", 400, 150);
    

 
 
 
  //NAME SELECTIONS
  if (name == 1)  image(YGOR, 150, 100, 600, 600);
  if (name == 2)  image(MARY, 150, 100, 600, 600);
  if (name == 3)  image(KARL, 150, 100, 600, 600);
  if (name == 4)  image(VERA, 150, 100, 600, 600);
  
  
  //conditions
  if (pointsWin >= 19) {
 textFont(iFont);
  textSize(70);
 text("YOU WIN", 400, 300);
 } 
 
  if (pointsWin < 19) {
 textFont(iFont);
 textSize(70);
 text("YOU LOSE", 400, 300);
 }  
  
  fill(black);
   grass.show();
   
   //buttons n stuff
  
GameoverREDO.show();
GameoverEXIT.show();

if (GameoverREDO.clicked){
 setup();
mode = NAMESELECT;
//myHero.hp = 100;
pointsWin = 0;
}

if (GameoverEXIT.clicked){

}

  
}
