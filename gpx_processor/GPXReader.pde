class GPXReader{
  ArrayList <Track> tracks;
  ArrayList <String> files;
  BoundingBox box;
  
  GPXReader(ArrayList<String> in_files, BoundingBox bbox){
    this.files = in_files;
    this.box = bbox;
    tracks = new ArrayList<Track>();
        for (int i = 0;i < gpxfiles.size();i++) {
      read(gpxfiles.get(i));
    }
  }
  void display(){
   for(int i = 0;i < tracks.size(); i++){
     tracks.get(i).display(this.box);
   }
  }
  
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
}
