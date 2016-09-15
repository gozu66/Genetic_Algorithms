//----------Richie Byrne 2016--------------------
//-----------------------------------------------

private int generation = 0;                                            //GENERATION COUNTER
private float mutationRate = 25.0f;                                    //% CHANCE OF MUTATION  //EDITABLE FROM UI
private float maxDifference;
private int populationAmout = 20;
private DNA[] population;                                              //POPULATION ARRAY - SIZE EDITABLE FROM UI AT START
private ArrayList<DNA> matingPool = new ArrayList();                   //MATING POOL - PROGRAMATICALLY RESIZED AS REQUIRED

float[] fitnessScores;

boolean display;                      
boolean pauseInputs = false;
boolean firstGen = true;
boolean autoUpdate();

void setup()
{
  size(700, 500);
  frameRate(5);

  Begin();
}

void draw()
{
  background(50);
  text(generation, 10, 10); 
  GetInputs();

  if (display)
  {
    if (autoUpdate)
    {
      if (frameCount % 5 == 0)
      {
        Generate();
      }
    } else
    {      
      if (keys[' '] && !pauseInputs)
      {
        pauseInputs = true;                                            
        Generate();
      }
    }
  }
}


void Begin()
{
}


void Generate()
{
  generation++;
  if (firstGen)
  {
    population  = new DNA[populationAmout];                             //CREATE POPULATION ARRAY
  }
  fitnessScores = new float[populationAmout];                           //ARRAY TO STORE FITNESS SCORES

  for (int i = 0; i <population.length; i++)
  {
    if (firstGen)
    {
      population[i] = new DNA();                                        //INITIALIZE EACH DNA OBJECT
    } else
    {
      population[i] = Crossover();
    }
    fitnessScores[i] = population[i].Evaluate();                        //EVALUATE AND SCORE DNA OBJECTS
  }
  firstGen = false;

  float topFitnessScore = 0;
  DNA fittest = new DNA();

  for (int i = 0; i < population.length; i++)
  {
    if (fitnessScores[i] > topFitnessScore)                             //FIND DNA OBJECT WITH HIGHEST FITNESS
    {
      fittest = population[i];
      topFitnessScore = fitnessScores[i];
    }
  }
  
  BuildMatingPool(fitnessScores, topFitnessScore);
}


void BuildMatingPool(float[] fitnessScores, float topFitnessScore)
{
  matingPool.clear();
  
  for (int i = 0; i < fitnessScores.length; i++)
  {
    fitnessScores[i] = map(fitnessScores[i], 0, topFitnessScore, 1, 10);
  }

  for (int i = 0; i < fitnessScores.length; i++)
  {
    for (int j = 0; j < fitnessScores[i]; j++)
    { 
      matingPool.add(population[i]);
    }
  }
}


DNA Crossover()
{
  DNA mother = matingPool.get((int)random(matingPool.size()));
  DNA father = matingPool.get((int)random(matingPool.size()));
  DNA child = new DNA(true, false);

  //CROSSOVER STUFF GOES HERE

  return child;
}

