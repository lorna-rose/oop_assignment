/* OOP assignment 2
Lorna Keogh */

fallingBlock[] blocks;
Player player;

void setup()
{
  size(800,500);
  background(0);
  
  /*noFill();
  //stroke(#ff00ff);
  //rect(300,200,30,30);


  //level = 1;
  //lives = 4;
  //score = 0;*/

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
  player.display();
  
  for (int i = 0; i < blocks.length; i++ )
  {
    blocks[i].falling();
    blocks[i].display();
  }
}
  
