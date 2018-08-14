class Obstacle {
  final int red = 0;
  final int green = 255;
  final int blue = 255;
  PVector pos;
  float height;
  float width;
  
  Obstacle(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    height = h;
    width = w;
  }
  
    
  boolean inObstacle(PVector coords) {
    float x = coords.x;
    float y = coords.y;
     if(x >= pos.x && y >= pos.y && x <= (pos.x + width) && y <= (pos.y + height)) return true;
     return false;
  }
}
