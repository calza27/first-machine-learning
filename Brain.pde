class Brain {
  ArrayList<PVector> directions;//series of vectors which get the dot to the goal (hopefully)
  int step = 0;

  Brain() {
    directions = new ArrayList<PVector>();
  }
  
  Brain(ArrayList<PVector> vectors) {
    directions = new ArrayList<PVector>();
    for(PVector vec: vectors) {
      directions.add(vec.copy());
    }
  }
  
  Brain(int size) {
    directions = new ArrayList<PVector>();
    for(int i=0; i<size; i++) {
      float randomAngle = random(2*PI);
      PVector vec = PVector.fromAngle(randomAngle);
      directions.add(vec);
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------
  //returns a perfect copy of this brain object
  Brain clone() {
    return new Brain(directions);
  }

  //----------------------------------------------------------------------------------------------------------------------------------------

  //mutates the brain by setting some of the directions to random vectors
  void mutate(float mutationRate, float absoluteMutationRate) {
    for (int i =0; i< directions.size(); i++) {
      float rand = random(1);
      if (rand < absoluteMutationRate) {
        //set this direction as a random direction
        float randomAngle = random(2*PI);
        PVector vec = PVector.fromAngle(randomAngle);
        
        directions.set(i, vec);
      } else if (rand < (mutationRate + absoluteMutationRate)) {
        //set this direction as a random shift in direction +/-22.5 degrees       
        PVector currentVec = directions.get(i).copy();
        float randomAngle = random(PI/4); //0 -> 45 degrees
        float randomAngleShift = randomAngle/2;
        randomAngle -= randomAngleShift; //-22.5 -> +22.5 degrees
        PVector newVec = PVector.fromAngle(currentVec.heading() + randomAngle);
        
        directions.set(i, newVec);
      }
    }
  }
}
