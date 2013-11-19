class GPXReader{
  ArrayList <Track> tracks;
  ArrayList <String> files;
  BoundingBox box;
  
  GPXReader(ArrayList<String> in_files, BoundingBox bbox){
    this.files = in_files;
    this.box = bbox;
    tracks = new ArrayList<Track>();
        for (int i = 0;i < gpxfiles.size();i++) {
//      println(gpxfiles.get(i));
      read(gpxfiles.get(i));
    }
  }
  
  
//  void init(){
//
//    
//  }
  
  
  void display(){
   for(int i = 0;i < tracks.size(); i++){
//     println(tracks.get(i));
     tracks.get(i).display(this.box);
   }
  }
//  void draw(){
//  for (int i = 0;i < gpxfiles.size();i++) {
//      drawgpxfile(gpxfiles.get(i));
//    }
//  }
  
  
private void read(String filename){
  XML xml; // declare the xml element
  xml = loadXML(filename); // this is the file
  Track track = new Track();
  XML trk = xml.getChild("trk"); // this is a track
  // loop all the tracks in the file
  for (int j = 0; j < trk.getChildCount();j++) {
    XML trkseg =  trk.getChild(j);// isolate one track
    String trkseg_childname = trkseg.getName();// get the name
    // check if there is a child called trkseg
    if (trkseg_childname.equals("trkseg")) {
      Segment seg = new Segment();
      // loop the track segment
      for (int i = 0; i < trkseg.getChildCount(); i++) {
        XML child = trkseg.getChild(i);// get every child of trkseg
        String name = child.getName();
        if (name.equals("trkpt")) {
          float lat = child.getFloat("lat");  // xml attribute lat
          float lon = child.getFloat("lon"); // // xml attribute lon
          seg.add_location(new Location(lat, lon));
        }
        else {
          /**
           * this is just for debugging
           */
        }//close else
      }// close i
          track.add_segment(seg);
    }// close trkseg check
  }// close j
  tracks.add(track);
}

  /**
 * This funktion loads one .gpx file
 * and draws it to the screen
 * @argument {String} the Filename
 */
void drawgpxfile(String filename) {

  XML xml; // declare the xml element
  xml = loadXML(filename); // this is the file


    XML trk = xml.getChild("trk"); // this is a track

    // loop all the tracks in the file
  for (int j = 0; j < trk.getChildCount();j++) {

    XML trkseg =  trk.getChild(j);// isolate one track

    String trkseg_childname = trkseg.getName();// get the name

    // check if there is a child called trkseg
    if (trkseg_childname.equals("trkseg")) {
      
      noFill();
      beginShape();
      // loop the track segment
      for (int i = 0; i < trkseg.getChildCount(); i++) {
        XML child = trkseg.getChild(i);// get every child of trkseg
        String name = child.getName();
        if (name.equals("trkpt")) {
          float aspectRatio = (eastlon - westlon) / (northlat - southlat);
          float lat = child.getFloat("lat");  // xml attribute lat
          float lon = child.getFloat("lon"); // // xml attribute lon
          // println(lat+" "+lon);
          float x = map(lon, westlon, eastlon, 0, width);    // bereich der gps koodinaten auf den fensterbereich mappen
          float y = map(lat, northlat, southlat, 0, width/aspectRatio);
          vertex(x, y);
        }
        else {
          /**
           * this is just for debugging
           */
        }//close else
      }// close i
      endShape();
    }// close trkseg check
  }// close j
}

}
