class fallingBlock
{
  int x = (int)random(0, width-20);
  int y = (int)random(-height);
  int blockSize = 30;
  
  void falling()
  {
    y += (int)blockSpeed;
    
    if(y>height)
    {
      x = (int)random(0, width+blockSize);
      y = (int)random(-height);
    }
  }
  
  void display()
  {
    noFill();
    stroke(#ff00ff);
    rect(x,y,30,30);
  }
}
