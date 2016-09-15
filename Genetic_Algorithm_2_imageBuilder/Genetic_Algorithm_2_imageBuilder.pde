//----------Copyright Richie Byrne 2016----------
//-----------------------------------------------

private int generation = 0;                                            //GENERATION COUNTER
private float mutationRate = 25.0f;                                    //% CHANCE OF MUTATION  //EDITABLE FROM UI
private float maxDifference;
private int populationAmout = 20;
private DNA[] population;                                              //POPULATION ARRAY - SIZE EDITABLE FROM UI AT START
private ArrayList<DNA> matingPool = new ArrayList();                   //MATING POOL - PROGRAMATICALLY RESIZED AS REQUIRED

PImage sourceImage, displayImage;                                      //THE IMAGE WE WANT TO RECONSTRUCT
color[] sourceColors;                                                  //CACHED COLOR ARRAY OF SRCIMG COLORS
ArrayList sourceColorPallete = new ArrayList();
float[] fitnessScores;

boolean display;                      
boolean pauseInputs = false;
boolean firstGen = true;

void setup()
{
  size(700, 500);
  frameRate(5);
  
  DNA dna = new DNA(false, false);
  
  maxDifference = dna.CompareColor(color(255, 255, 255), color(0, 0, 0));
  
  Begin();
}

void draw()
{
  background(50);
  text(generation, 10, 10); 
  GetInputs();

  if (display)
  {
    image(displayImage, 150, 50, 400, 400);
    if (keys[' '] && !pauseInputs)
    {
      pauseInputs = true;
      Generate();                                                      //BEGIN SEQENCE
    }
if(frameCount % 5 == 0)
{
  Generate();
}
  }
}

void Begin()
{
  loadSourceImage();                                                  //LOAD SOURCE IMAGE INTO MEMORY AND CACHE PIXEL ARRAY TO COLOR ARRAY
  display = true;                                                     //DISPLAY SOURCE IMAGE AND WAIT FOR INPUT
}

void loadSourceImage()
{
  sourceImage = loadImage("SRC.jpg");                                 //LOAD IMAGE FROM DATA FOLDER
  sourceImage.resize(400,400);
  sourceImage.loadPixels();                            
  sourceColors = new color[sourceImage.pixels.length];  
  for (int i = 0; i < sourceColors.length; i++)
  {
    sourceColors[i] = sourceImage.pixels[i];                          //ASSIGN sourceColos ARRAY TO BE EQUAL TO sourceImage
  }
  displayImage = sourceImage;                                         //SET PIMAGE CONTAINER TO DISPLAY ON SCREEN
  
  
  
//  for(int i = 0 ; i < sourceColors.length; i++)
//  {
//    color c = sourceColors[i];
//    if(i == 0)
//    {
//      sourceColorPallete.add(c);
//    }
//    for(int j = 0; j < sourceColorPallete.size(); j++)
//    {
//      if(sourceColorPallete.get(i) == c)
//      {
//        break;
//      }
//    }
//  }
//  println(sourceColorPallete.length);
}

void Generate()
{
  generation++;
  if(firstGen)
  {
    population  = new DNA[populationAmout];                           //CREATE POPULATION ARRAY
  }
  fitnessScores = new float[populationAmout];                         //ARRAY TO STORE FITNESS SCORES

  for (int i = 0; i <population.length; i++)
  {
    if(firstGen)
    {
      population[i] = new DNA(true, true);                                  //INITIALIZE EACH DNA OBJECT
    }
    else
    {
      population[i] = Crossover();
    }
    fitnessScores[i] = population[i].Evaluate();                      //EVALUATE AND SCORE DNA OBJECTS
  }
  firstGen = false;
  
  float topFitnessScore = 0;
  DNA fittest = new DNA(false, false);

  for (int i = 0; i < population.length; i++)
  {
    if (fitnessScores[i] > topFitnessScore)                                //FIND DNA OBJECT WITH HIGHEST FITNESS
    {
      fittest = population[i];
      topFitnessScore = fitnessScores[i];
    }
  }
  BuildMatingPool(fitnessScores, topFitnessScore);

  displayImage = CreateImageFromColorArray(fittest.colors);          //DISPLAY HIGHEST FITNESS IMAGE
//  delay(1000);
//  Generate();
}

PImage CreateImageFromColorArray(color[] colors)                      //CREATE IMAGE FROM COLOR ARRAY
{
  PImage newImage = new PImage(400, 400);                             //CREATE NEW PIMAGE
  newImage.loadPixels();                                          
  for (int i = 0; i < colors.length; i++)                              //LOOP THROUGH PIXEL ARRAY   
  {
    newImage.pixels[i] = colors[i];                                   //ASSIGN EACH PIXEL TO MATCH COLORS ARRAY
  }
  newImage.updatePixels();

  return newImage;
}

void BuildMatingPool(float[] fitnessScores, float topFitnessScore)
{
  matingPool.clear();
  for (int i = 0; i < fitnessScores.length; i++)
  {
//    fitnessScores[i] = map(fitnessScores[i], 0, topFitnessScore, 10, 0);
        fitnessScores[i] = map(fitnessScores[i], 0, topFitnessScore, 1, 10);

//    println(fitnessScores[i]);
  }
  
  for (int i = 0; i < fitnessScores.length; i++)
  {
    for (int j = 0; j < fitnessScores[i]; j++)
    { 
      matingPool.add(population[i]);
    }
  }
  
//  println(matingPool.size());
}

DNA Crossover()
{
  DNA mother = matingPool.get((int)random(matingPool.size()));
  DNA father = matingPool.get((int)random(matingPool.size()));
  DNA child = new DNA(true, false);
  
  for(int i =  0; i < child.colors.length; i++)
  {
    //float rnd = random(1);
    //child.colors[i] = (rnd > 0.5) ? mother.colors[i] : father.colors[i];
    child.colors[i] = (mother.colors[i] > father.colors[i]) ? mother.colors[i] : father.colors[i];
  }
  
  return child;
}
