/* OOP assignment 2
 Lorna Keogh - C13740351 
 
 ---------Game Instructions--------
 
 Basic Shooting Game
 Use LEFT and RIGHT arrows to move
 The CTRL button lets you shoot   
 */

//import file for use of sound in the game
import ddf.minim.*;
Minim minim;
AudioPlayer game;

//fonts and variables
PFont writing;
int stage, level, lives, score;

//for display of screen
boolean devMode = true;
boolean sketchFullScreen() {
  return ! devMode;
}

Player player;
ArrayList bullets;
ArrayList bombs;
int cols= 6;
int rows = 5;
int cols_select;
int rows_select;
int xspeed = 1; 
Block[][] blocks = new Block[cols][rows];
Timer timer;
boolean gameOn=true;
int deadBlocks=0;
int lastBlock=0;


//variables for menu
Button[] menuButtons;
int NUMBUTTONS = 3;
boolean drawBoxes;

void setup()
{
  if (devMode)
  {
    size(800, 600);
  } else
  {
    size(displayWidth, displayHeight);
  }
  background(0);
  colorMode(HSB, 360, 360, 360);
  smooth();

  writing = loadFont("ArcadeClassic-48.vlw");

  menuButtons = new Button[3];
  menuButtons[0] = new Button("Instructions", new PVector(400, 200), 32, color(#00ffff), color(#0000ff));
  menuButtons[1] = new Button("Play Game", new PVector(400, 300), 32, color(#00ffff), color(#0000ff));
  menuButtons[2] = new Button("Exit Game", new PVector(400, 400), 32, color(#00ffff), color(#0000ff));
  drawBoxes = false;

  stage = 1;
  level = 0;
  lives = 4;
  score = 0;

  //play music
  minim = new Minim(this);
  game = minim.loadFile("gameOOP.mp3");
  game.play();


  //initialize the player object, call for constructor;
  player = new Player(200, 200, 200, 400, 580);
  //initialize the bulletArrayList
  bullets = new ArrayList();
  bombs = new ArrayList();
  //initialize the block array
  for (int i=0; i< cols; i++) {
    for (int j=0; j<rows; j++) {
      blocks[i][j] = new Block(200, 200, 200, 360, i*50, j*40, xspeed);
    }
  }
  //initialize the Timer
  timer = new Timer(200);
  timer.start();
}


void draw()
{
  if (stage == 1)
  {
    background(0);
    textAlign(CENTER);
    textFont(writing, 50);
    fill(#ff00ff);
    text("Welcome", 400, 200);
    textFont(writing, 32);
    text("Press Space key for main menu", 400, 300);

    if (key == ' ')
    {
      stage = 2;
      clear();
    }
  }
  if (stage == 2 )
  {
    textAlign(CENTER);
    textFont(writing, 50);
    fill(#ff00ff);
    text("Main Menu", 400, 150);

    displayMenu();
  }
  if (stage == 3)
  {
    clear();
    textAlign(CENTER);
    //textFont(writing,50);
    fill(#ff00ff);

    //load in text file to read in instructions
    String lines[] = loadStrings("instruct.txt");
    for (int i = 0; i < lines.length; i++)
    {
      textFont(writing, 50);
      text(lines[0], 400, 150);
      textFont(writing, 30);
      text(lines[1], 400, 250);
      text(lines[2], 400, 300);
      text(lines[3], 400, 350);
      textFont(writing, 20);
      text(lines[4], 400, 500);
    }

    if ( key == 'm' || key == 'M')
    {
      clear();
      stage = 2;
    }
  }

  if (level == 1)
  {
    playgame();

    textFont(writing, 20);
    fill(#ff00ff);
    text("Score  "+score, 50, 30);
    text("    Lives  "+lives, 130, 30);
  }

  if (lives == 0)//if player day splash screen for end game
  {
    clear();

    background(0);
    textAlign(CENTER);
    textFont(writing, 40);
    fill(#ff00ff);
    text("Game Over", 400, 300);

    if ( key == 'e' || key == 'E' )
    {
      exit();
      stop();
    }
  }
}

void displayMenu()
{
  for (int i = 0; i < NUMBUTTONS; i++)
  {
    menuButtons[i].draw(drawBoxes);
  }
}

void mousePressed()//options for the mouse in the menu
{
  if (menuButtons[0].containsMouse())
  {
    stage = 3;
  }
  if (menuButtons[1].containsMouse())
  {
    level = 1;
  }
  if (menuButtons[2].containsMouse())
  {
    exit();
    stop();
  }
}

void playgame()
{
  clear();

  //draw player and blocks
  player.display();
  player.move();
  player.lastBlock();
  for (int i=0; i< cols; i++) {
    for (int j=0; j<rows; j++) {
      blocks[i][j].display();
      blocks[i][j].move();
      blocks[i][j].shift();
      blocks[i][j].exitStageLeft();
    }
  }

  //for shooting
  for (int i=0; i < bullets.size (); i++) {
    Bullet b = (Bullet) bullets.get(i);
    b.display();
    b.fire();
    if (b.finished()) {
      bullets.remove(b);
    }

    //collision with the bullets and the blocks
    for (int k=0; k< cols; k++) {
      for (int j=0; j<rows; j++) {
        if (b.intersect(blocks[k][j])) {
          bullets.remove(b);
          blocks[k][j].destroyed();
          deadBlocks=deadBlocks+1;
        }
      }
    }
  }
  for (int i=0; i < bombs.size (); i++) {
    Bomb b = (Bomb) bombs.get(i);
    b.display();
    b.fire();
    if (b.finished()) {
      bombs.remove(b);
      //player collision is ment to be here
      /*if(b.intersect(player)){
       bombs.remove(b);
       player.killlife();
       }*/
    }
  }
  for (int i=0; i< cols; i++) {
    for (int j=0; j<rows; j++) {
      int cols_select=int(random(cols));
      int rows_select=int(random(rows)); 
      if (timer.isFinished() && blocks[cols_select][rows_select].imaDeadBlock==false) {
        bombs.add(new Bomb(140, 300, 300, blocks[cols_select][rows_select].true_xpos, blocks[cols_select][rows_select].true_ypos, -10));
        timer.start();
      }
    }
  }
  if (keyPressed && keyCode == CONTROL)//player shooting
  {
    bullets.add(new Bullet(int(random(180, 220)), 200, 200, player.xpos, 780, 10));
  }
  nextLevel();
  if ( key == 'e' || key == 'E' )
  {
    exit();
    stop();
  }
}
//end draw
//NEXT LEVEL CODE
void nextLevel() {
  if (deadBlocks>=cols*rows) {
    color h = (int)random(0, 255);
    xspeed = xspeed+1;
    for (int i=0; i< cols; i++) {
      for (int j=0; j<rows; j++) {
        deadBlocks=0;
        blocks[i][j] = new Block(h, 200, 200, 360, i*50, j*40, xspeed);
        ;
      }
    }
  }
  if (keyPressed && keyCode == CONTROL)
  {
    bullets.add(new Bullet(int(random(180, 220)), 200, 200, player.xpos, 780, 10));
  }

  if ( key == 'e' || key == 'E' )
  {
    exit();
    stop();
  }
}
void lastBlock() {
  println(deadBlocks);
  if (deadBlocks==cols*rows-1) { 
    lastBlock=1000;
  } else {
    lastBlock=0;
  }
}







