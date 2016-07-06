---
layout: post
title:  "Sort and beautify column-based file"
date:   2015-08-29 07:05:00 -0700
categories: unix linux shell sort
---

{% gist f8a35f68ad0f5738b4de %}

Sort Options:

- -n Numeric sort
- -r Reverse result
- -t Field separator. See [1]

Column Options:

- -ts Pretty print with char delimiter for columns. See also [1]

[1] Note: sort and column treat ‘\t’ and other char delimiters  as a multi-byte character. In order to make it work, we
should place a $ before it, as it's shown in the example.