class Bullet { 
  int h; 
  int s; 
  int b; 
  float xpos; 
  float ypos; 
  float yspeed;



  Bullet(int temp_h, int temp_s, int temp_b, float temp_xpos, float temp_ypos, float temp_yspeed) { 
    h= temp_h; 
    s= temp_s; 
    b= temp_b; 
    xpos = temp_xpos; 
    ypos = temp_ypos; 
    yspeed = temp_yspeed;
  } 

  void display() { 
    fill(h, s, b); 
    rect(xpos, ypos, 4, 4);
  } 

  void fire() { 
    ypos=ypos-yspeed;
  } 

  boolean finished() { 

    if (ypos-yspeed < 50 || ypos-yspeed > 950) return true; 
    else return false;
  } 

  boolean intersect(Block a) { 
    float distance = dist(xpos, ypos, a.true_xpos, a.true_ypos); 
    if (distance < 20) { 
      return true;
    } else { 
      return false;
    }
  }
} 




