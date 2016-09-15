class DNA
{
  String[] phrase = new String[targetArray.length];
  String[] useableArray = new String[] {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", 
    "?", " "
  };
  float fitness = 0.0;

  DNA(boolean populate)
  {
    if (populate)
    {
      for(int i = 0; i < this.phrase.length; i++)
      {
        this.phrase[i] = PopulateChar();  
      }
    }
  }

  String PopulateChar()
  {
    return useableArray[(int)random(useableArray.length)];
  }

  void Evaluate()
  {
    fitness = 0;

    for (int j = 0; j < targetArray.length; j++)
    {
      String k = targetArray[j];
      String l = phrase[j];

      if (k == l)
      {
        fitness++;
      }
    }    
    println(this.phrase);
    println("---------------------------------------->" + fitness + " Corect Letter");
    fitness *= fitness;
    if(fitness > bestGuessIndex)
    {
      bestGuessIndex = fitness;
      bestGuess = phrase;
    }
  }

  void Mutate()
  {
    for(int i = 0; i < this.phrase.length; i++)
    {
      float f = random(100);
      if(f <= mutationRate)
      {
        this.phrase[i] = PopulateChar(); 
      }      
    }
    
  }
}

