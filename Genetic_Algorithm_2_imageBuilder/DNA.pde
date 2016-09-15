//----------Copyright Richie Byrne 2016----------
//-----------------------------------------------
class DNA
{
  float fitness = 0;
  color[] colors;
  float[] colorFitnessValues;
//  static float maxDistance;

  DNA(boolean needsColorArray, boolean willInitialize)
  {
    if (needsColorArray)
    {
      colors = new color[sourceColors.length];
      colorFitnessValues = new float[colors.length];
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
//      colors[i] = sourceColors[(int)random(sourceColors.length)];
    }
  }

  float Evaluate()
  {
    if(generation > 1)Mutate();
    
    for (int i = 0; i < colors.length; i++)
    {      
      colorFitnessValues[i] = abs(CompareColor(this.colors[i], sourceColors[i]));
      this.fitness += colorFitnessValues[i];
    }
    this.fitness = this.fitness / colors.length;
    this.fitness = this.fitness * this.fitness;
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
//    float distance = (_red - s_red)*(_red - s_red) + (_blue - s_blue)*(_blue - s_blue) + (_green - s_green)*(_green - s_green);   
    float distance = (_red - s_red) + (_blue - s_blue) + (_green - s_green);   


    return distance;
  }

  void Mutate()
  {
    for (int i = 0; i < colors.length; i++)
    {
      float rnd = random(100);
      int rnd2 = (int)random(sourceColors.length);
      if (rnd <= mutationRate)
      {
//        colors[i] = color(random(255), random(255), random(255));
        if(CompareColor(sourceColors[i], sourceColors[rnd2]) < CompareColor(colors[i], sourceColors[i]))
        {
          colors[i] = sourceColors[i];
//          colors[i] = color(random(255), random(255), random(255));
//          println("mutated");
        }
      }
    }
  }
}

