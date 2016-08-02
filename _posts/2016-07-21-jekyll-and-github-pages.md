---
layout: post
title:  "Adventures with Jekyll and Github pages"
date:   2016-07-21 23:30:00 -0700
categories: jekyll github-pages github website tricks blog
---

When some years ago I was exploring tools for generating web sites for a project I stumbled upon [Jekyll](https://jekyllrb.com/).
In the end I didn't used Jekyll for that project (I opt for [Maven Site Plugin](https://maven.apache.org/plugins/maven-site-plugin/)
+ the [Fluido Skin](https://maven.apache.org/skins/) in the end). However, when I decided to start my webpage/blog
in Github pages, I decided to start using Jekyll as it was the default no-brainer option.

It was pretty easy and quick to start building the website and publish the contents to Github. These are the basic steps
once you have installed Ruby in your system and created a project in Github for storing your website sources (note that
the repo name should be <username>.github.io):

```shell
$ gem install jekyll
$ jekyll new <username>.github.io
$ cd <username>.github.io
# Here you are supposed to add the content of your website, and when finishing, you push it to Github
$ git init
$ git remote add origin git@github.com/<username>/<username>.github.io
$ git add .
$ git commit -m "First version of my website"
$ git push
```

After pushing, Github compiles the Jekyll website in your repo and generates automatically a static website, showing it
under the `http://<username>.github.io` domain name as [my site](http://francisco-perez-sorrosal.github.io) is shown.
So far, so good if you are not using Jekyll plugins or you use the standard github-pages plugins accepted by [Github](https://help.github.com/articles/adding-jekyll-plugins-to-a-github-pages-site/).
For example, at some point, I wanted to generate the sitemap for my website, so I just had to include the `jekyll-sitemap`
[gem](https://github.com/jekyll/jekyll-sitemap) in the `_config.yml` file of Jekyll.

However, I needed to add my own Gem containing a Jekyll plugin, so I had to generate locally the static content of my
website and push it to Github. That fact obliged me to change the way I organized the Github repo of the website. After
taking a look at different options I went for this one; the `master` branch will contain the static website generated
locally and I would create a new branch `source` for holding the Jekyll code and the website sources and my docs.

In order to do that, I first created the new branch `source` without including the `_site` directory, so I add that dir
to the `.gitignore`. Then, I pushed the contents to the new branch in the remote repo and I track it locally. After
this step I had the important data in the new branch. Now, I had to take care of the generated static content of the
website that has to be shown through the Github pages. So, I cleaned up the contents in the `_site` dir, I removed the
`master` branch and I created a new repo tracking the remote  `master` branch locally, associated to the
directory contents. This is the summary of the steps I had to do:

```shell
$ cd <username>.github.io
# Assuming we are in the master branch
$ git checkout -b source
# Now we're in the source branch
$ echo _site/ >> .gitignore
$ git add .
$ git ci -m "Do not keep track of _site dir"
$ git push --set-upstream origin source
$ git branch -D master
$ cd _site
# Now we're in a directory that is not associated to git so...
$ git init
$ git remote add origin https://github.com/<username>/<username>.github.io
$ git push -f --set-upstream origin master
```

So now, pushes under the `_site` directory will update the website contents remotely. Let's try it!

```shell
# Assuming that we're still in the _site dir...
$ cd ..
# Now we should be in the root of the project in the source branch! Let's check it!
$ git branch
# Let's generate the static website...
$ jekyll build
# Now the new content should be in _site/ so...
$ cd _site
$ git add .
$ git commit -m "New version"
$ git push
```

At this point, if we go to `http://<username>.github.io` we should see the new static website we've just generated and
pushed to Github.

So, we've seen how to separate the static content of our website from the Jekyll metadata and our metadata content in
two separate branches under our Github pages project. Apart of having to commit twice every time that you change the
contents of your website, this solution has another drawback; if we do a `jekyll clean` we'll wipe out the contents 
of the `_site` dir, so we'll have to generate again the repo and associate it with the remote `master` branch.