// Tweet.pde
// (c) 2012 David Troy (@davetroy)
//
// A simple class for each tweet. For the purposes of trails we are only storing
// a unix timestamp, a screenName, and a latitude and longitude. An optional lifespan
// is specified here but is not used. It could be used for aging out and removing a tweet
// from a trail. Each tweet acts as a waypoint on a gps trail. Trails with a length of
// one tweet (waypoint) just act as single markers and are plotted accordingly.

public class Tweet {
  int timestamp;
  float lat, lon,xvector,yvector;
  String screenName, vcolor,vid;
  int firsttime;
  float lifespan;

  Tweet(String rowString) {
    String[] row = split(rowString, ',');
    timestamp = parseInt(row[0]);
    vid = row[1];
    vcolor = row[2];
    lat = parseFloat(row[3]);
    lon = parseFloat(row[4]);
    xvector = parseFloat(row[5])*2.0;
    yvector = parseFloat(row[6])*2.0;
    lifespan=255;
  }

  PVector screenLocation() {
    return mercatorMap.getScreenLocation(new PVector(lat, lon));
  }

  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

