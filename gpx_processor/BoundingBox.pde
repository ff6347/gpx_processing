class BoundingBox{
  float northlat = 90; // the most top point
  float westlon = 180; // the most left point
  float southlat = -90; // the most bottom point
  float eastlon = -180; // the most right point

  BoundingBox(){
    // empty constructor
    // will be set to world
  }
  BoundingBox(float nlat, float wlon, float slat, float elon){
  this.northlat = nlat; // the most top point
  this.westlon = wlon; // the most left point
  this.southlat = slat; // the most bottom point
  this.eastlon = elon; // the most right point
  }

}
