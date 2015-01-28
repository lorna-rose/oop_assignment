class Player { 
  //declare variables 
  int h; 
  int s; 
  int b; 
  float xpos; 
  float ypos; 
  //boolean killed = false;


  //constructor 
  Player(int temp_h, int temp_s, int temp_b, float temp_xpos, float temp_ypos) { 
    h=temp_h; 
    s=temp_s; 
    b=temp_b; 
    xpos=temp_xpos; 
    ypos=temp_ypos;
  } 

  void display() { 
    noStroke(); 
    fill(h, s, b); 
    ellipse(xpos, ypos, 50, 50);
  } 
  void move()
  {
    if (keyPressed && keyCode == LEFT) xpos = constrain(xpos-5, 0, width-40);
    if (keyPressed && keyCode == RIGHT) xpos = constrain(xpos+5, 0, 770);
  }


  void lastBlock()
  { 
    println(deadBlocks); 
    if (deadBlocks==80)
    { 
      lastBlock=1000;
    } else 
    { 
      lastBlock=0;
    }
  }  
  /*void killLife()
   {
   boolean killed;
   lives--;
   } */
} 

