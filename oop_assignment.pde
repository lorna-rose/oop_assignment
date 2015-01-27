  /* OOP assignment 2
Lorna Keogh - C13740351 

  ---------Game Instructions--------
 
       Basic Space Invaders game
   Use LEFT and RIGHT arrows to move
   The CTRL button lets you shoot
   Kill all the ships to win
   
   
 */

//import file for use of sound in the game
import ddf.minim.*;
Minim minim;
AudioPlayer game;

//fonts and variables
PFont writing;
int stage,level, lives, score;

//for display of screen
boolean devMode = true;
boolean sketchFullScreen(){
  return ! devMode; }

//pixel size for ships and players
int pixelsize = 4;
int gridsize = pixelsize * 9;
int direction = 1;
boolean edge = false;

//create array lists
ArrayList enemies = new ArrayList();
ArrayList bullets = new ArrayList();
Player player;

//variables for menu
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
  
  //play music
  minim = new Minim(this);
  game = minim.loadFile("gameOOP.mp3");
  game.play();
  
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
    //textFont(writing,50);
    fill(#ff00ff);
    
    //load in text file to read in instructions
    String lines[] = loadStrings("instruct.txt");
    for(int i = 0; i < lines.length; i++)
    {
      textFont(writing,50);
      text(lines[0], 400,150);
      textFont(writing,30);
      text(lines[1], 400,250);
      text(lines[2], 400,300);
      text(lines[3], 400,350);
      textFont(writing,20);
      text(lines[4], 400,500);
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
  }
  
  if (level == 2)
  {
    clear();
    //playgame();
 
    
    background(0);
    textAlign(CENTER);
    textFont(writing, 40);
    fill(#ff00ff);
    text("You Win", 400,300);
    
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

void playgame()
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
    text("Score  "+score, 50,30);
    text("  Lives  " +lives,130,30);
    
    if ( key == 'e' || key == 'E')
    {
      exit();
      stop();
    }
  }


  
