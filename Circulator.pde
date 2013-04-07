import java.util.*;
import java.text.*;
import java.io.*;

PImage mapImage;
MercatorMap mercatorMap;
TweetBase db;
Tweet current;
int currentTime;
TrailSystem trailSystem;
PFont legendFont, legendFont2, legendFont3;

int cx, cy;
int n=0;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

int radius = 150;
int tintamount = 240;

File f = new File("C:/proc/Circulator/img");

File[] list = f.listFiles();
int[] imgnumbers = new int[list.length];


void setup() {
  size(994, 522);
  //frameRate(1);
  smooth();
  mapImage = loadImage("protomap.png");  

 
   for(int j=0;j<list.length-1;j++){
     String[] justNumbers;
     justNumbers = split(list[j].getName(),"C:/proc/Circulator/");
     justNumbers = split(justNumbers[0], ".png");
      imgnumbers[j] = Integer.parseInt(justNumbers[0]);
  
    }


 
    mercatorMap = new MercatorMap(994, 522, 39.303, 39.269, -76.653, -76.567);
  

    legendFont = createFont("HelveticaNeue-Bold", 30);
    legendFont2 = createFont("HelveticaNeue-Light", 20);
    legendFont3 = createFont("HelveticaNeue-Light", 18);





    db = new TweetBase();
    current = db.get(0);
    currentTime = current.timestamp;

    trailSystem = new TrailSystem();
  
    //These set up the clock
 
    secondsRadius = radius * 0.45;
    minutesRadius = radius * 0.40;
    hoursRadius = radius * 0.30;
    clockDiameter = radius * 1.0;
  
    cx = 890;
    cy = 420;
  }

  void draw() 
  {
    // draw the base map
  
   tint(tintamount);


    // grab tweets for this time interval
   println(currentTime);


 
    //text(currentTime, 30, 200);
    ArrayList<Tweet> newTweets = db.tweetsThrough(currentTime);

    println(newTweets.size());

    //Get a new BG image if there is one
    //iterate through list and find the greatest item that is less than currentTime
    if(currentTime>imgnumbers[n+1] && n<imgnumbers.length-2){
      n++;
      mapImage = loadImage(list[n].getAbsolutePath());
    }

    image(mapImage,0,0,width,height);  
    currentTime += 2;

    // add new tweets and draw the trails
    trailSystem.addTweets(newTweets);

    trailSystem.draw();



    // generate formatted date
    int offsetTime = currentTime;// + 14400;
    Date time = new java.util.Date((long)offsetTime*1000);
    DateFormat df = new SimpleDateFormat("EEEE MM/dd/yyyy HH:mm");
    String reportDate = df.format(time);
    DateFormat minsFormat = new SimpleDateFormat("m");
    String mins = minsFormat.format(time);
    int minsint = Integer.parseInt(mins);
    DateFormat hoursFormat = new SimpleDateFormat("h");
    String hours = hoursFormat.format(time);
    int hoursint = Integer.parseInt(hours);
    DateFormat apFormat = new SimpleDateFormat("a");
    String ap = apFormat.format(time);
  

    // draw the legends ===================================================================================================================================== 
    
    fill(60);
    //top rect header    
    fill(200,200,200, 192);
    rect(16,10,640,72,8);
    //end top rect header
    
    fill(60,60,60); //text fill
    textFont(legendFont);
    text("Charm City Circulator Real-time Movements", 30, 40);
    textFont(legendFont2);

    //bottom rect footer    
    fill(200,200,200, 192);
    rect(16,480,600,36,8);
    //end bottom rect footer
    
    //text(currentTime,30,70);
    fill(60,60,60);
    text(reportDate, 30, 70);
    textFont(legendFont3);
    text("Visualization by @chris_whong, @ChaseGilliam, & Brian Mackintosh", 30, 500);
  
    //All below draws a clock face
    // Draw the clock background
    fill(200,200,200, 160);//bkg clock color
    stroke(48,48,48,192);
    strokeWeight(1);
    ellipse(cx, cy, clockDiameter, clockDiameter);
  
    //Angles for sin() and cos() start at 3 o'clock;
   //subtract HALF_PI to make them start at the top
 
    float m = map(minsint + 0, 0, 60, 0, TWO_PI) - HALF_PI; 
    float h = map(hoursint + norm(minsint, 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
    
    // Draw the hands of the clock
    stroke(60,60,60);//hand color
    strokeWeight(3);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
    strokeWeight(5);
    line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
    
    // Draw the minute ticks
    strokeWeight(2);
    beginShape(POINTS);
    
    for (int a = 0; a < 360; a+=6) {
      float angle = radians(a);
      float x = cx + cos(angle) * secondsRadius;
      float y = cy + sin(angle) * secondsRadius;
      vertex(x, y);
    }
    endShape();
    saveFrame("output/frames####.tiff");
  
  } 
 

