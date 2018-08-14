class ObstacleSet {
  ArrayList<Obstacle> obstacles;
  
  ObstacleSet() {
    obstacles = new ArrayList<Obstacle>();
  }
  
  void addObstacle(float x, float y, float w, float h) {
    obstacles.add(new Obstacle(x, y, w, h));
  }
  
  void show() {
    for(Obstacle obs: obstacles) {
      fill(obs.red, obs.green, obs.blue);
      rect(obs.pos.x, obs.pos.y, obs.width, obs.height);
    }
  }
  
  boolean inObstacle(PVector coords) {
    for(Obstacle obs: obstacles) {
      if(obs.inObstacle(coords)) return true;
    }
    return false;
  }
}
