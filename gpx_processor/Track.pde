class Track{
ArrayList <Segment> segments;
Track(){
  segments = new ArrayList<Segment>();
  }
  
  void add_segment(Segment seg){
    segments.add(seg);
  }
  
  
  void display(BoundingBox bbox){

    for(int i = 0; i < segments.size();i++){
    beginShape();  
     for(int j =0;j < segments.get(i).locations.size();j++){
       Location loc = segments.get(i).locations.get(j);
       PVector pos = loc.get_screen_coords(bbox);
//       println(pos);
       vertex(pos.x,pos.y);
     }
    endShape();
    }
    
  }
}
