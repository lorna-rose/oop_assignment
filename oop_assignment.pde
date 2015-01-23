  /* OOP assignment 2
Lorna Keogh */

PFont writing;
int stage,level, lives, score;

boolean devMode = true;
boolean sketchFullScreen(){
  return ! devMode; }

int pixelsize = 4;
int gridsize = pixelsize * 9;
int direction = 1;
boolean edge = false;

float startAngle;
float angleVel = 0.23;
ArrayList enemies = new ArrayList();
ArrayList bullets = new ArrayList();
Player player;
Button[] menuButtons;
int NUMBUTTONS = 3;
boolean drawBoxes;

void setup()
{
  if (devMode)
  {
    size(800,600);
  }
  else
  {
    size(displayWidth, displayHeight);
  }
  background(0);
  
  writing = loadFont("ArcadeClassic-48.vlw");
  
  menuButtons = new Button[3];
  menuButtons[0] = new Button("Instructions", new PVector(400,200), 32, color(#00ffff), color(#0000ff));
  menuButtons[1] = new Button("Play Game", new PVector(400,300), 32, color(#00ffff), color(#0000ff));
  menuButtons[2] = new Button("Exit Game", new PVector(400,400), 32, color(#00ffff), color(#0000ff));
  drawBoxes = false;
  
  stage = 1;
  level = 0;
  lives = 4;
  score = 0;

  player = new Player();
  
  createEnemies();
  
}

void draw()
{
  if (stage == 1)
  {
    background(0);
    textAlign(CENTER);
    textFont(writing,50);
    fill(#ff00ff);
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
    fill(#ff00ff);
    text("Main Menu",400,150);
    
    displayMenu();
    
  }
  if (stage == 3)
  {
    clear();
    textAlign(CENTER);
    textFont(writing,50);
    fill(#ff00ff);
    text("Instructions",400,150);
    textFont(writing,30);
    fill(#00ffff);
    text("Use the LEFT and RIGHT keys to move", 400,250);
    text("ctrl lets you shoot", 400, 300);
    text("To exit the game press E", 400, 350);
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
    player.draw();
    
    for (int i = 0; i < bullets.size(); i++ )
    {
      Bullet bullet = (Bullet) bullets.get(i);
      bullet.draw();
    }
    
    for (int i = 0; i < enemies.size(); i++)
    {
      Enemy enemy = (Enemy) enemies.get(i);
      if (enemy.outside() == true)
      {
        direction *= (-1);
        edge = true;
        break;
      }
    }
    for (int i = 0; i < enemies.size(); i++)
    {
      Enemy enemy = (Enemy) enemies.get(i);
      if(!enemy.alive())
      {
        enemies.remove(i);
      }
      else
      {
        enemy.draw();
      }
    }
    edge = false;
    
    if( score == 66 )
    {
      level = 2;
    }
    
    textFont(writing, 20);
    fill(#ff00ff);
    text("Score: "+score, 50,30);
    text("  Lives: " +lives,130,30);
    
    if ( key == 'e' || key == 'E')
    {
      exit();
      stop();
    }
  }
  
  if (level == 2)
  {
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

void createEnemies()
{
  for (int i = 0; i < width/gridsize/2; i++)
  {
    for (int j = 0; j <=5; j++)
    {
      enemies.add(new Enemy(i*gridsize, j*gridsize));
    }
  }
}


  
