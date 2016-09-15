//----------Copyright Richie Byrne 2016----------
//-----------------------------------------------
class DNA
{
  float fitness = 0;
  color[] colors;

  DNA(boolean needsColorArray, boolean willInitialize)
  {
    if (needsColorArray)
    {
      colors = new color[sourceColors.length];
    }
    if (willInitialize)
    {
      Initialize();
    }
  }

  void Initialize()
  {
    for (int i = 0; i < colors.length; i+=1)
    {
      colors[i] = color(random(255), random(255), random(255));
    }
  }

  float Evaluate()
  {
    Mutate();
    
    for (int i = 0; i < colors.length; i++)
    {      
      this.fitness += CompareColor(this.colors[i], sourceColors[i]);
    }

    this.fitness = this.fitness / colors.length;
    return fitness;
  }

  float CompareColor(color c1, color c2)
  {
    float _red = red(c1);
    float _green = green(c1);
    float _blue = blue(c1);
    float s_red = red(c2);
    float s_green = green(c2);    
    float s_blue = blue(c2);    
    float distance = (_red - s_red)*(_red - s_red) + (_blue - s_blue)*(_blue - s_blue) + (_green - s_green)*(_green - s_green);   

    return distance;
  }

  void Mutate()
  {
    for (int i = 0; i < colors.length; i++)
    {
      float rnd = random(100);
      if (rnd <= mutationRate)
      {
        colors[i] = color(random(255), random(255), random(255));
      }
    }
  }
}

