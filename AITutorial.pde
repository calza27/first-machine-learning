Population test;
PVector goal  = new PVector(395, 125);
ObstacleSet globalObstacleSet;
int runCount = 0;
final float aggresiveMutationRate = 0.5;
final float aggresiveAbsoluteRandomMutationRate = 0.01;
final float subtleMutationRate = 0.1;
final float subtleAbsoluteRandomMutationRate = 0.01;

void setup() {
  size(800, 800); //size of the window
  frameRate(10000);//increase this to make the dots go faster
  test = new Population(1000);//create a new population with 1000 members
  globalObstacleSet = new ObstacleSet();
  globalObstacleSet.addObstacle(0,400,500,10);
  globalObstacleSet.addObstacle(300,500,500,10);
  globalObstacleSet.addObstacle(300,300,500,10);
  globalObstacleSet.addObstacle(300,100,10,100);
  globalObstacleSet.addObstacle(490,100,10,100);
  globalObstacleSet.addObstacle(300,200,200,10);
}


void draw() { 
  background(255);

  //draw goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  //draw obstacles
  globalObstacleSet.show();

  if (test.allDotsDead()) {
    int numArrived = 0;
    for(Dot subject: test.dots) {
      if(subject.reachedGoal) numArrived++;
    }
    println("Run Count: ", runCount++, " Dots arrived: ", numArrived);
    
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    //mutate slightly if bestDot reached the goal
    if(test.bestDot.reachedGoal) test.mutateDemBabies(subtleMutationRate, subtleAbsoluteRandomMutationRate);
    //otherwise mutate aggresivly
    else test.mutateDemBabies(aggresiveMutationRate, aggresiveAbsoluteRandomMutationRate);
  } else {
    //if any of the dots are still alive then update and then show them
    test.update();
    test.show();
  }
}
