---
layout: post
title:  "TweetStorm: A Simple Storm App to Retweet and Filter Twitter Mentions"
date:   2016-08-20 11:35:00 -0700
categories: storm twitter omid filter heroku howto tutorial
---

When we open-sourced [Omid](https://omid.incubator.apache.org/) in Apache back in April, we also opened a Twitter
account to spread news and useful information about it [@ApacheOmid](https://twitter.com/ApacheOmid).
The first month, I was taking a look from time to time in order to see Tweets mentioning Omid or the account, 
retweets, etc. till I got bored about it, and I decided to create an application to do it for me.
 
So I took the [Twitter Hosebird Client](https://github.com/twitter/hbc) and the [Twitter4J](http://twitter4j.org/en/)
libraries and I started working on it.

I could have chosen to implement a standard Java standalone application, but I decided to use [Apache Storm](http://storm.apache.org/) 
in order to have a simple (but useful at the same time) pet project that I could re-use in the future as a base with 
the minimum Storm scaffolding for other projects.

The initial purpose of the application was very simple; just observe the stream of Tweets in Twitter, detect when
some of them mention [@ApacheOmid](https://twitter.com/ApacheOmid) and retweet them automatically. After this, I also
decided to add a functionality to filter the retweet of those Tweets that could potentially include offensive terms
associated to [@ApacheOmid](https://twitter.com/ApacheOmid) and send a notification about these events to my personal
Tweeter account [@fperezsorrosal](https://twitter.com/fperezsorrosal).

The TweetStorm application can be found in my [Github account](https://github.com/francisco-perez-sorrosal/tweetstorm).
The Storm topology is very simple and consists in a single Spout and 3 Bolts:

1. `TwitterSuckerSpout`: Connects with Twitter through the Hosebird lib and emits raw Tweets to the `TwitterFilterBolt`
2. `TwitterFilterBolt`: Inspects the received Tweets and checks for possible offensive terms associated to the 
[@ApacheOmid](https://twitter.com/ApacheOmid) mention. If the Tweet is not offensive, emits a value to the 
`ReTwitterBolt`. Otherwise, emits the value to the `WatchDogBolt`. 
3. `ReTwitterBolt`: It's responsible of retweeting the contents in the [@ApacheOmid](https://twitter.com/ApacheOmid) account using Twitter4J.
4. `WatchDogBolt`: It's responsible of sending a notification to [my personal Twitter account](https://twitter.com/fperezsorrosal) through Twitter4J lib.

This piece of code shows the required wiring of those elements:

{% highlight java linenos %}
{% github_file https://github.com/francisco-perez-sorrosal/tweetstorm/blob/master/src/main/java/com/fps/tweetstorm/TwitterTopology.java 71 105 %}
{% endhighlight %}

I made the OAuth configuration and the other application parameters configurable in the `conf/config.properties` file, so 
anyone can use it for her own purposes. The usage is very simple, just:

1) Clone the repo
```sh
$ git@github.com:francisco-perez-sorrosal/tweetstorm.git
```

2) Configure the Twitter OAuth and related config in `conf/config.properties` file


3) Compile the application and generate the jar file
```sh
$ mvn clean install assembly:single
```

4) Run the application
```sh
$ java -jar tweetstorm-1.0-SNAPSHOT.jar conf/config.properties
```

The application can be deployed also in [Heroku](https://www.heroku.com/). It's been a while since I had tried the 
Heroku platform and I wanted to try it again, so I downloaded the provided [Toolbelt](https://toolbelt.heroku.com/)
and I deployed in the app in there. The process was like a breeze. After you register your account, you have to basically
create an application environment in Heroku to host your app in the platform and deploy it:

```
$ heroku heroku apps:create <my-app-name>
```

In order to deploy it, we have to use the Maven plugin for Heroku (See the `pom.xml` [file in the project](https://github.com/francisco-perez-sorrosal/tweetstorm)):

```
    <plugin>
        <groupId>com.heroku.sdk</groupId>
        <artifactId>heroku-maven-plugin</artifactId>
        <version>1.0.3</version>
        <configuration>
            <appName>my-app-id</appName>
            <processTypes>
                <worker>java -jar tweetstorm-1.0-SNAPSHOT.jar conf/config.properties</worker>
            </processTypes>
            <includeTarget>false</includeTarget>
            <includes>
                <include>tweetstorm-1.0-SNAPSHOT.jar</include>
                <include>conf/config.properties</include>
            </includes>
        </configuration>
    </plugin>
```

and deployed the app after compiling it with:

```
$ mvn clean install assembly:single
$ maven heroku:deploy
```

Later, you can check the remote logs through the Heroku Toolbelt with:
```
$ heroku logs --app <my-app-name> -n 100
```

As I said before, it was very easy and the app deployment process was like a breeze.

Hope this post could also be useful for those of you that want to have a simple and quick introduction
to Storm and application deployment in the cloud.