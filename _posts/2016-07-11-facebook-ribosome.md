---
layout: post
title:  "Facebook Ribosome Hiring Test Revisited"
date:   2016-07-11 21:35:00 -0700
categories: java hiring test 2011 facebook dna strings
---

In Dec. 2011 I had an interview with Facebook. They proposed a coding test
to decipher a DNA string extracting the proteins that were coded in it.
It was a nice test to play with strings with Java. Some weeks later, I don't
know why, I decided to re-code it. Despite I didn't had the original text,
I remembered enough details of the main function, so I took pen and paper 
and I added the resulting code to my gists in Github:

{% gist 1468599 %}

Some days ago, I stumbled upon a github project of a guy that had the complete
text describing the problem and some examples of DNA strings and resulting
proteins. So I though that it was a nice opportunity to check what I did
some years ago :-) I wrote the required scaffolding and I checked my function.

Apart from some minor stuff, the function passed without problems the
tests. I like it because is concise and clear, at least compared to other
solutions that I've seen out there. Only 12 lines. And they could have 
been only 11 if I had returned a list of strings, but it was less convenient 
for the tests.

You can find the problem description and the solution 
[here](https://github.com/francisco-perez-sorrosal/ribosome-facebook).

Also you can test it and play in just 3 lines. Concision!

```
$ git clone git@github.com:francisco-perez-sorrosal/ribosome-facebook.git
$ mvn clean install assembly:single
$ java -jar ribosome-1.0-SNAPSHOT.jar dnastring1.txt
```