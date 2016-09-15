boolean[] keys = new boolean[512];
boolean isPressed;

void keyPressed()
{
  keys[keyCode] = true;
}
void keyReleased()
{
  keys[keyCode] = false;
}

void GetInputs()
{
  if (keys[' '] && !isPressed)
  {
    isPressed = true;
    TickGeneration();
  } else if (!keys[' '] && isPressed)
  {
    isPressed = false;
  }
  
  if(keys['E'])
    TickGeneration();
}

