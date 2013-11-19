class Location{
  float x;
  float y;
  float lat;
  float lon;
  Location(float _lat, float _lon){
    this.lat = _lat;
    this.lon = _lon;
  }
  
  PVector get_screen_coords(BoundingBox bbox){
    float aspectRatio = (bbox.eastlon - bbox.westlon) / (bbox.northlat - bbox.southlat);    
    this.x = map(this.lon, bbox.westlon, bbox.eastlon, 0, width);    // bereich der gps koodinaten auf den fensterbereich mappen
    this.y = map(this.lat, bbox.northlat, bbox.southlat, 0, width/aspectRatio);
    return new PVector(this.x, this.y);      
  
  }
  
}
