class Population {
  Dot ghostDot;
  ArrayList<Dot> dots;
  Dot bestDot;
  ArrayList<Dot> fitDots;
  
  float fitnessSum;
  int gen = 1;

  int bestDotIndex = 0;//the index of the best dot in the dots[]

  int minStep = 1000;

  Population(int size) {
    dots = new ArrayList<Dot>();
    for (int i = 0; i< size; i++) {
      dots.add(new Dot());
    }
  }


  //------------------------------------------------------------------------------------------------------------------------------
  //show all dots
  void show() {
    for (Dot dot: dots) {
      dot.show();
    }
    dots.get(0).show();
  }

  //-------------------------------------------------------------------------------------------------------------------------------
  //update all dots 
  void update() {
    for (Dot dot: dots) {
      if (dot.brain.step > minStep) {//if the dot has already taken more steps than the best dot has taken to reach the goal
        dot.dead = true;//then it dead
      } else {
        dot.update();
      }
    }
  }

  //-----------------------------------------------------------------------------------------------------------------------------------
  //calculate all the fitnesses
  void calculateFitness() {
    for (Dot dot: dots) {
      dot.calculateFitness();
    }
  }


  //------------------------------------------------------------------------------------------------------------------------------------
  //returns whether all the dots are either dead or have reached the goal
  boolean allDotsDead() {
    for(Dot dot: dots) {
      if (!dot.dead && !dot.reachedGoal) { 
        return false;
      }
    }
    return true;
  }



  //-------------------------------------------------------------------------------------------------------------------------------------

  //gets the next generation of dots
  void naturalSelection() {
    ArrayList<Dot> newDots = new ArrayList<Dot>();//next gen
    setBestDot();
    calculateFitnessSum();

    //the champion lives on 
    newDots.add(bestDot.gimmeBaby());
    newDots.get(0).isBest = true;
    for (int i = 1; i< dots.size()-1; i++) {
      //select parent based on fitness
      Dot parent;
      if(bestDot.reachedGoal) parent = bestDot;
      else parent = selectParent();

      //get baby from them
      newDots.add(parent.gimmeBaby());
    }
    Dot ghostDot = bestDot.gimmeBaby();
    ghostDot.isGhost = true;
    ghostDot.isBest = false;
    newDots.add(ghostDot);
    
    dots = (ArrayList<Dot>)newDots.clone();
    gen ++;
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //you get it
  void calculateFitnessSum() {
    fitnessSum = 0;
    fitDots = new ArrayList<Dot>();
    float targetFitness = 0.95*bestDot.fitness;
    for (Dot dot: dots) {
      //only adds fitness of dots that are at least half as good as the best dot
      if(dot.fitness >= targetFitness) {
        fitnessSum += dot.fitness;
        fitDots.add(dot);
      }
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------

  //chooses dot from the population to return randomly(considering fitness)

  //this function works by randomly choosing a value between 0 and the sum of all the fitnesses
  //then go through all the dots and add their fitness to a running sum and if that sum is greater than the random value generated that dot is chosen
  //since dots with a higher fitness function add more to the running sum then they have a higher chance of being chosen
  Dot selectParent() {
    float rand = random(fitnessSum);


    float runningSum = 0;

    for(Dot fdTarget: fitDots) {
      runningSum+= fdTarget.fitness;
      if (runningSum > rand) {
        return fdTarget;
      }
    }

    //should never get to this point

    return null;
  }

  //------------------------------------------------------------------------------------------------------------------------------------------
  //mutates all the brains of the babies
  void mutateDemBabies(float mutationRate, float absoluteMutationRate) {
    for(Dot dot: dots) {
      if(!dot.isGhost) {
        if(dot.isBest) dot.brain.mutate(subtleMutationRate, absoluteMutationRate);
        else dot.brain.mutate(mutationRate, absoluteMutationRate);
      }
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------------
  //finds the dot with the highest fitness and sets it as the best dot
  void setBestDot() {
    float max = 0;
    for (Dot dot: dots) {
      dot.isBest = false;
      if (dot.fitness > max) {
        max = dot.fitness;
        bestDot = dot;
      }
    }
    bestDot.isBest = true;
    //if this dot reached the goal then reset the minimum number of steps it takes to get to the goal
    if (bestDot.reachedGoal) {
      minStep = bestDot.brain.step;
      println("step:", minStep);
    }
  }
}
