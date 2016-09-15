  String[] targetArray;
String targetString = "To be or not to be?";
float mutationRate = 0.5f;
DNA[] population;
int generation = 0;
int populationAmount = 200;
String[] bestGuess;
float bestGuessIndex = 0;

void setup()
{
  targetArray = new String[] {
    "T", "o", " ", "b", "e", " ", "o", "r", " ", "n", "o", "t", " ", "t", "o", " ", "b", "e", "?"
  };

  population = new DNA[populationAmount];

  for (int i = 0; i < population.length; i++)
  {
    DNA _dna = new DNA(true);
    population[i] = _dna;
  }
}

void draw()
{
  GetInputs();
}

void TickGeneration()
{
  generation ++;

  for (int i = 0; i < population.length; i++)
  {
    population[i].Evaluate();
  }

  PopulateMatingPool();

  for (int i = 0; i < population.length; i++)
  {
    DNA mother = SelectFromMatingPool();
    DNA father = SelectFromMatingPool();
    DNA child = Crossover(mother, father);

    population[i] = child;  

    population[i].Mutate();
  }
}

ArrayList<DNA> matingPool = new ArrayList();
void PopulateMatingPool()
{
  matingPool.clear();
  float[] fitnessArray = new float[population.length];
  float biggest = 0; 
  int biggestIndex = 0;

  for (int i = 0; i < population.length; i++)
  {
    fitnessArray[i] = population[i].fitness;
    if (fitnessArray[i] > biggest) {
      biggest = fitnessArray[i];
      biggestIndex = i;
    }
  }

  for (int i = 0; i < fitnessArray.length; i++)
  {
    fitnessArray[i] = map(fitnessArray[i], 0, biggest, 0, 10);
    population[i].fitness = fitnessArray[i];
  }

  for (int i = 0; i < population.length; i++)
  {
    float count = population[i].fitness;

    while (count >= 0)
    {
      matingPool.add(population[i]);
      count--;
    }
  }

  println("matingPool.size : " + matingPool.size());
  println("Generation : " + generation);     
  println(bestGuess);  
  println("best guess index " + bestGuessIndex);
}

DNA SelectFromMatingPool()
{
  int rnd = (int)random(matingPool.size()-1 );
  return matingPool.get(rnd);
}

DNA Crossover(DNA _mother, DNA _father)
{
  DNA dna = new DNA(false);

  for (int i = 0; i < dna.phrase.length; i++)
  {
    float rnd = random(1);
    dna.phrase[i] = (rnd > 0.5f) ? _mother.phrase[i] : _father.phrase[i];
  }

  return dna;
}

