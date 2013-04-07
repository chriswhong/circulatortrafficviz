// TrailSystem.pde
// (c) 2012 David Troy (@davetroy)
//
// TrailSystem is a wrapper for a Hashtable that tracks trails for individual objects
// in this case, the keys are screenNames associated with tweets. We keep all of the
// active trails in the TrailSystem. When a trail finally fades out and dies, we remove
// it from the system. The system is also responsible for rotating through our color palette.
// (Two palettes provided, courtesy of Friends of the Web, Baltimore -- one dark, one light --
// note that hex colors are provided in 32-bit alpha+rgb order format.)

class TrailSystem {
  Hashtable trails;
  PFont labelFont;
  String[] palette = {
    "FFF17479", "FFF29F63", "FFE7CB46", "FFB6D061", "FF11E686", "FF72DDB3", "FF60CAE9", "FF8999C3", "FFBA80C3", "FFDD8CB4"
  };
  String[] palette1 = {
    "FFFF8D91", "FFFFB47C", "FFFFED72", "FFC5DD77", "FF33FFA3", "FF8AEBC5", "FF78D9F5", "FF9DACD3", "FFCA95D1", "FFEDA3C8"
  };
  color[] colors;
  int colorIndex;

  TrailSystem() {
    colors = new color[palette.length];
    colorIndex = 0;
    trails = new Hashtable();
    labelFont = createFont("Helvetica", 12);
    for (int i=0; i<palette.length; i++) {
      colors[i] = color(unhex(palette[i]));
    }
  }

  color nextColor() {
    if (colorIndex>=colors.length) colorIndex=0;
    return colors[colorIndex++];
  }

  Trail findOrCreateTrail(String vid) {
    Trail trail = (Trail)trails.get(vid);
    if (trail == null) {
      trail = new Trail(nextColor());
      trails.put(vid, trail);
    }
    return trail;
  }





  void addTweets(ArrayList<Tweet> tweets) {    
    Iterator<Tweet> it = tweets.iterator();
    while (it.hasNext ()) {
      Tweet t = it.next();
      Trail trail = findOrCreateTrail(t.vid);
      trail.add(t); //adding an individual report to the trailsystem for its vehicle.
      
    }
  }

  int size() {
    return trails.size();
  }

  void draw() {

    if (trailSystem.size()==0)
      exit();


    Iterator<Trail> it = trails.values().iterator();
    while (it.hasNext ()) {
      Trail tr = it.next();
      //if (tr.points.size()==1) {
        tr.update(); //add a new point to the trail based on time and velocity
        tr.drawPoints();
        
      if (tr.isDead()) {
        textFont(legendFont);
        //text("DEAD", 3 break;00, 300);
        it.remove();
      }
    }
  }
}

