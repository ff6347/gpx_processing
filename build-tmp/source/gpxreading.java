import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class gpxreading extends PApplet {

/**
 * @author Monika Hoinkis
 * edited for P2 by Fabian Moron Zirfas
 */
 // this is just for export purpose
Boolean writepdf = false; // if true the sketch will create a PDF


/**
 * create a bounding box world
 * upper left and lower right
 * check out http://dbsgeo.com/latlon/
 * for getting geolocations
 */
// float westlon = 180; // the most left point
// float northlat = 90; // the most top point
// float southlat = -90; // the most bottom point
// float eastlon = -180; // the most right point
/**
 * This is Potsdam bounding box
 * 
 */
// float westlon = 12.935028076171875; // the most left point
// float northlat = 52.43299020014247; // the most top point
// float southlat = 52.338695481504814; // the most bottom point
// float eastlon = 13.16436767578125; // the most right point

/**
 * This is campus FHP bounding box
 */
float northlat = 52.41493264663135f; // the most top point
float westlon = 13.045835494995117f; // the most left point
float southlat = 52.40954011714691f; // the most bottom point
float eastlon = 13.054676055908203f; // the most right point


XML xml; // declare the xml element


public void setup() {
  /**
   * IMPORTANT make the sketch size 2:1 
   * this is equirectangular 
   * see --> http://en.wikipedia.org/wiki/Equirectangular_projection
   */
  size(600, 300);
  background(255); // white bg

  if(writepdf == true){
    beginRecord(PDF, "gps_track_01.pdf"); 
  }

  xml = loadXML("GPXMaster_01.gpx"); // this is the file
  XML trk = xml.getChild("trk"); // this is a track
  XML trkseg = trk.getChild("trkseg"); // this is a segemt of a track
  // strokeWeight(3);
  noFill();
  beginShape();
  for (int i = 0; i < trkseg.getChildCount(); i++) {
    XML child = trkseg.getChild(i);// get every child of trkseg
    String name = child.getName();
    if (name.equals("trkpt")) {
      float lat = child.getFloat("lat");  // xml attribute lat
      float lon = child.getFloat("lon"); // // xml attribute lon
      // println(lat+" "+lon);
       float x = width * ((westlon - lon) / (westlon - eastlon));
       float y = ( height * ((northlat - lat)/(northlat - southlat)));
      vertex(x, y);
    }else{
      /**
       * this is just for debugging
       */
    }
  }
  endShape();
  if(writepdf == true){
  endRecord();
  exit();// and nd the sketch
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "gpxreading" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
