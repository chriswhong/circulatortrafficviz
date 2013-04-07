// TweetBase.pde
// (c) 2012 David Troy (@davetroy)
//
// Acts as a data model and factory for storing, retrieving, and making Tweets, which can
// then be added to Trails and into the TrailSystem. TweetBase allows us to retrieve a span
// of tweets generated over a timestamp range (tweetsThrough) and to return those as an
// ArrayList of fully constituted tweets.

public class TweetBase {
  String[] tweets;
  int index;

  TweetBase() {
    tweets = loadStrings("testdata2.csv");
    index = 0;
  }

  Tweet get(int index) {
    if (index<tweets.length) {
  
      return new Tweet(tweets[index]);
   
    } 
    else {
      return null;
    }
  }

  Tweet next() {
    return this.get(index);
  }

  ArrayList<Tweet> tweetsThrough(int maxTimestamp) {
    ArrayList<Tweet> tweets = new ArrayList<Tweet>();
    Tweet tweet;
    do {
      tweet = this.next();
      if (tweet != null && tweet.timestamp<=maxTimestamp) {
        
        tweets.add(tweet);
           index++;
      }
    } 
    while ((tweet != null) && (tweet.timestamp<=maxTimestamp) );
    return tweets;
  }








  }

