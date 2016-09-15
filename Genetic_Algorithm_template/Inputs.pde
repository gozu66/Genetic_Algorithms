//----------Richie Byrne 2016--------------------
//-----------------------------------------------
boolean[] keys = new boolean[512];
boolean isPressed;

void keyPressed()
{
  keys[keyCode] = true;
  //pauseInputs = true;
}
void keyReleased()
{
  keys[keyCode] = false;
  pauseInputs = false;
}

void GetInputs()
{
  
}

