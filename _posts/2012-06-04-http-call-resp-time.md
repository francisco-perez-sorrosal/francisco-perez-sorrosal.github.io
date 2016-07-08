---
layout: post
title:  "Response Time of HTTP Requests"
date:   2012-06-04 08:10:00 -0700
categories: unix linux shell http request response time performance
---

Curl is a very well-known tool to transfer data using different protocols (HTTP, IMAP, POP3, FTP...). We can measure
the response time of an HTTP request in millisecond resolution the curl way, like this:

```sh
curl -s -w '\nResponse Time \t%{time_total} (secs)\n' -o /dev/null http://example.com
```

Options:

- -s Silent mode to not to show trash on screen
- -w <pattern> Allows to specify a pattern that can include different variables: time_connect, time_pretransfer...
- -o Redirect output, in this case to the trash can, as we use the -w to show the result we want

Echoping is a less well-known tool to test remote host with TCP, UDP protocols but we can also measure the response
time of HTTP requests. This is the echoping way:

```sh
echoping -v -h / example.com
```

Options:

- -v Verbose
- -h <url> Use the http protocol instead of ping for the url specified