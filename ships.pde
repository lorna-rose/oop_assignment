class SpaceShip
{
  int x,y;
  String sprite[];
   
  void draw()
  {
   updateObj();
   drawSprite(x,y);
  }
  
  void drawSprite(int xpos, int ypos)
  {
    for (int i = 0; i < sprite.length; i++)
    {
      String row = (String) sprite[i];
      
      for (int j = 0; j < row.length(); j++)
      {
        if(row.charAt(j) == '1')
        //fill( random(255), random(255), random(255), random(255));
        rect(xpos+(j * pixelsize), ypos+(i * pixelsize), pixelsize, pixelsize);
        fill( random(255), random(255), random(255), random(255));
      }
    }
  }
  
  void updateObj() 
  {
  }
}
