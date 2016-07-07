---
layout: post
title:  "Spiral Matrix: The Pacman Way"
date:   2011-12-22 04:06:00 -0700
categories: java arrays matrix spiral recursion
---

Three days ago, I was asked to implement a code to traverse a matrix in spiral during an interview process.
There, I was very nervous and I started trying to figure out how to modify the indexes using nested loops in order to
achieve the proposed goal. I was trying to achieve a concise and efficient code instead of finding first a simple
solution to the problem. ERROR. Of course, in the end I only achieved a completely mess in the blackboard.

When I arrived home and I could think more clearly, I started coding this simple solution, which is based on recursion
and a simple state machine that traverses the matrix like a Pac-Man eating the corresponding rows and columns in the
right order. There are out there a lot of solutions more efficient and concise. But concise and efficient doesn’t
always mean clear and simple. I think this solution is very very simple and what is more important these days, readable.

Code that traverses a matrix in spiral using recursion and a simple state machine:

{% gist 1510085 %}
