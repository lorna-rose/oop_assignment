/* OOP assignment 2
Lorna Keogh */

PFont writing;
int stage,level, lives, score;
fallingBlock[] blocks;
Player player;

void setup()
{
  size(800,500);
  background(0);
  writing = loadFont("ACaslonPro-Bold-48.vlw");
  
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
    textFont(writing,80);
    text("Welcome",400,200);
    textFont(writing, 60);
    text("Press Space key for main menu", 400,300);
   
    if (key == ' ')
    {
      stage = 2;
    }
  }
  if (stage == 2 )
  {
    background(#00ffff);
    
  }
  
  if (level == 1)
  {
    player.display();
    
    for (int i = 0; i < blocks.length; i++ )
    {
      blocks[i].falling();
      blocks[i].display();
    }
  }
}
  
