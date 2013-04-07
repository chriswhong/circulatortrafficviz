// Trail.pde
// (c) 2012 David Troy (@davetroy)
//
// wrapper for an ArrayList of points that contains individual tweets
// trails belong to a TrailSystem (like a particle belongs to a ParticleSystem)
// a trail starts out with a lifespan (and opacity) of 255.0 and then decays down to 0
// when it reaches 0, it is considered dead and is removed from the trailsystem.
// Every time a new point is added to the trail its lifespan is (arbitrarily) renewed to 255.0.

public class Trail {

  PVector velocity;

  ArrayList<Tweet> points;
  color trailColor;
  float lifespan;
  //lifespan for mid-trail tweets
  float lifespan2;
  Tweet t = null;
  PVector loc = null;
  PVector loc2 = null;
  PVector loc3 = null;
  int nexttweettime;
  int firsttweettime;
  int timediff;
  int isnew;
  int i=0;
  int fillcolor;

  Trail(color col) {
    points = new ArrayList<Tweet>();
    trailColor = col; //color(random(255),random(255),random(255));
    lifespan = 255.0;
  }

  void add(Tweet t) {
    points.add(t);
    //lifespan = 255.0;
  }

  void drawPoints() {

    noStroke();

    //fill(#9BFFFF, 255);
    Iterator<Tweet> it = points.iterator();
    println("Points.size() is " + points.size());
    while (it.hasNext ()) {


      t = it.next();



      println(t.vcolor);
      if (t.vcolor.equals("orange")==true) {
        fill(255,161,0,33);
        //fillcolor = #ffa100;
      }
      else if (t.vcolor.equals("purple")==true) { 
        fill(212,0,255, 18);
        //fillcolor = #d400ff;
      }

      else if (t.vcolor.equals("green")==true) { 
        fill(0,206,54,18);
        //fillcolor = #00ce18;
        ;
      }
      else {
        fill(0,64,204,26);
        //fillcolor = #0040cc;
      }


      loc = t.screenLocation();
      println(t.lifespan);
      //fill(fillcolor, t.lifespan);
      ellipse(loc.x, loc.y, 20, 20);
      textFont(legendFont3);
      t.lifespan *= 0.80;

      if (t.lifespan<30) {
        it.remove();
      }
    }
  }



  void update() {

    println("Hi from update, points.size() is : " + points.size());
    Tweet lastTweet = points.get(points.size()-1);


    Tweet t = new Tweet("0,0,0,0,0,0,0");
    //t.timestamp = lastTweet.timestamp + 1;
    t.vid = lastTweet.vid;
    t.vcolor = lastTweet.vcolor;
    t.lat = lastTweet.lat + (lastTweet.xvector); 

    t.lon = lastTweet.lon + (lastTweet.yvector); 

    t.xvector = lastTweet.xvector ;
    t.yvector = lastTweet.yvector ;
    t.lifespan=255;
    points.add(t);
  }

  boolean isDead() {

    return (points.size()==0 || lifespan<1.0);
  }
}

