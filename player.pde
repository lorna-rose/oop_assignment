class Player
{
  
  float x = 400, y = 400;
  float r = 50;
  
  void display()
  {
    noFill();
    stroke(#00ff00);
    ellipse(x,y,r,r);
  }
}
