---
layout: post
title:  "ACL 2020 Best Paper Summary: Beyond Accuracy: Behavioral Testing of NLP models with CheckList"
date:   2020-09-10 16:45:00 -0700
categories: nlp deep learning metrics acl best paper
---

I've done a summary of the paper "Beyond Accuracy: Behavioral Testing of NLP models with CheckList" by
_Marco Tulio Ribeiro, Tongshuang Wu, Carlos Guestrin and Sameer Singh_. This paper won the Best-Papwer award in
the 2020 ACL conference.

# Summary

💡 **Goal of the paper**: Present **Checklist**, a _methodology and a tool_ for testing NLP models.

Authors claim that...

* ... only ensuring that models fulfill *benchmark accuracy* **is not enough to evaluate model quality in NLP**

* ... by using similar techniques to those applied in SWE testing it is possible to reveal the "bad" quality of
 models that have passed the existing benchmarks in 3 different tasks

* ... their methodology and tools are easy to follow/use

* ... utility is guaranteed

  - they are able to find errors in battletested public comercial models
  - they show how users (both expert and newcomers) can benefit from the framework almost immediately
 
* ... open-source is the way to go, so...

  - [Tool and all stuff described in the paper is is open sourced](https://github.com/marcotcr/checklist)
  - They plan the community to start growing by sharing their experiences through new test suites and capabilities

[Find my summary of the paper here](https://github.com/francisco-perez-sorrosal/deep-learning-papers/tree/master/Beyond
%20Accuracy) 
in the form of a Jupyter notebook or just [click here to start binder](https://mybinder.org/v2/gh/francisco-perez-sorrosal/deep-learning-papers/master?filepath=Beyond%20Accuracy%2F2005.04118.ipynb) to access the presentation  