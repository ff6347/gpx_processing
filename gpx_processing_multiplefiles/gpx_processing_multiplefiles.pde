/**
 * @author Monika Hoinkis
 * edited for P2 by Fabian Moron Zirfas
 */

/**
 * create a bounding box world
 * upper left and lower right
 * check out http://dbsgeo.com/latlon/
 * for getting geolocations
 */
// float northlat = 90; // the most top point
// float westlon = 180; // the most left point
// float southlat = -90; // the most bottom point
// float eastlon = -180; // the most right point

/**
 * This is Berlin Potsdam boundng box
 *
 */
// float northlat = 52.70468296296834; // the most top point
// float westlon = 12.9638671875; // the most left point
// float southlat = 52.338695481504814; // the most bottom point
// float eastlon = 13.8153076171875; // the most right point
/**
 * This is Potsdam bounding box
 * 
 */
// float northlat = 52.43299020014247; // the most top point
// float westlon = 12.935028076171875; // the most left point
// float southlat = 52.338695481504814; // the most bottom point
// float eastlon = 13.16436767578125; // the most right point

/**
 * This is campus FHP bounding box
 */
float northlat = 52.41493264663135; // the most top point
float westlon = 13.045835494995117; // the most left point
float southlat = 52.40954011714691; // the most bottom point
float eastlon = 13.054676055908203; // the most right point


/**
 * This is Berlin Treptower Park
 *
 */
//float northlat = 52.491181962857084; // the most top point
//float westlon = 13.461813926696777; // the most left point
//float southlat = 52.489013082365126; // the most bottom point
//float eastlon = 13.4637451171875; // the most right point



/**
 * This will hold all the names of the gpx files
 * an ArrayList is like an Array but better. 
 * Check out:
 * http://processing.org/reference/ArrayList.html
 * http://docs.oracle.com/javase/1.5.0/docs/api/java/util/ArrayList.html
 */
ArrayList <String> gpxfiles;


void setup() {
  /**
   * IMPORTANT make the sketch size 2:1 
   * this is equirectangular 
   * see --> http://en.wikipedia.org/wiki/Equirectangular_projection
   */
  size(1200, 600);
  background(255); // white bg
  gpxfiles = new ArrayList<String>(); // Make new arraylist

  /**
   * Add all the filenames located in the data folder.
   */
  gpxfiles.add("Nush.gpx");
  gpxfiles.add("20131013-18_04_14.gpx");
  gpxfiles.add("20131013-18_18_29.gpx");
  gpxfiles.add("GPXMaster_01.gpx");
  gpxfiles.add("RK_03.gpx");
  gpxfiles.add("RK_04.gpx");
  gpxfiles.add("Running.gpx");
}


void draw() {
  /**
   * loop the list and draw all the files to the screen
   */
  for (int i = 0;i < gpxfiles.size();i++) {
    drawgpxfile(gpxfiles.get(i));
  }
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

