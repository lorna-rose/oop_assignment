class Block { 
  color h; 
  color s; 
  color b; 
  float a; 
  float xpos; 
  float true_xpos; 
  float true_ypos; 
  float ypos; 
  float xspeed; 
  float d; 
  float r; 
  boolean imaDeadBlock=false; 


  Block(color h_, color s_, color b_, float a_, float xpos_, float ypos_, float xspeed_) { 
    h= h_; 
    s= s_; 
    b= b_; 
    a=a_; 
    xpos = xpos_; 
    ypos = ypos_; 
    xspeed = xspeed_;
  } 

  void display() { 
    noStroke(); 
    fill(h, s, b, a); 
    r=20; 
    true_xpos=xpos+50; 
    true_ypos=ypos+50; 
    rect(true_xpos, true_ypos, r, r);
  } 



  void move() { 
    xpos = xpos + xspeed;
  } 

  void shift() { 
    if (xpos+50 >= width-25) { 
      ypos=ypos+20; 
      xspeed=(xspeed*(-1));
    } 
    if (xpos+50<= 25) { 
      ypos=ypos+20; 
      xspeed=xspeed*(-1);
    }
  } 
  void destroyed() { 
    imaDeadBlock=true; 

    score++;
  } 

  void exitStageLeft() { 
    if (imaDeadBlock==true) { 
      xpos=-2000; 
      xspeed=0;
    }
  }
} 

