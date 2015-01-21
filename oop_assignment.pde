/* OOP assignment 2
Lorna Keogh */

PFont writing;
int stage,level, lives, score;
float startAngle;
float angleVel = 0.23;
fallingBlock[] blocks;
Player player;
Button[] menuButtons;
int NUMBUTTONS = 3;
boolean drawBoxes;

void setup()
{
  size(800,600);
  background(0);
  
  writing = loadFont("ArcadeClassic-48.vlw");
  
  menuButtons = new Button[3];
  menuButtons[0] = new Button("Instructions", new PVector(400,200), 32, color(#BFBFAC), color(#ffffff));
  menuButtons[1] = new Button("Play Game", new PVector(400,300), 32, color(#BFBFAC), color(#ffffff));
  menuButtons[2] = new Button("Exit Game", new PVector(400,400), 32, color(#BFBFAC), color(#ffffff));
  drawBoxes = false;
  
  stage = 1;
  level = 0;
  lives = 4;
  score = 0;

  player = new Player();
  
  blocks = new fallingBlock[6];
  for ( int i = 0; i < 6; i++ )
  {
    blocks[i] = new fallingBlock();
  }

}

float blockSpeed = 4.0f;

void draw()
{
  if (stage == 1)
  {
    background(0);
    textAlign(CENTER);
    textFont(writing,50);
    text("Welcome",400,200);
    textFont(writing, 32);
    text("Press Space key for main menu", 400,300);
   
    if (key == ' ')
    {
      stage = 2;
      clear();
    }
  }
  if (stage == 2 )
  {
    textAlign(CENTER);
    textFont(writing,50);
    text("Main Menu",400,150);
    
    displayMenu();
    
  }
  if (stage == 3)
  {
    clear();
    textAlign(CENTER);
    textFont(writing,50);
    text("Instructions",400,150);
    textFont(writing,20);
    text("Press M to return to the main menu", 400,500);
    
    if ( key == 'm' || key == 'M')
    {
      clear();
      stage = 2;
    }
  }
  
  if (level == 1)
  {
    clear();
    player.display();
    
    for (int i = 0; i < blocks.length; i++ )
    {
      blocks[i].falling();
      blocks[i].display();
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

void mousePressed()
{
  if (menuButtons[0].containsMouse())
  {
    stage = 3;
  }
  if (menuButtons[1].containsMouse())
  {
    level = 1;
  }
  if(menuButtons[2].containsMouse())
  {
    exit();
    stop();
  }
}


  
