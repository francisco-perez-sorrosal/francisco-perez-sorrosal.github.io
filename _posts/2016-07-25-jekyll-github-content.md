---
layout: post
title:  "A Ruby Gem to add content of Github files ot Jekyll"
date:   2016-07-25 00:30:00 -0700
categories: jekyll github content files website
---

It's been a while since last time I used Ruby, and I had the perfect excuse to come back to it when I was looking for 
a solution to inject content of Github files in [Jekyll](https://jekyllrb.com/) generated websites, and I could not 
find a github-pages solution to do that (there's only a tag for including gists, but not a file or a part of it. See [this](https://github.com/jekyll/jekyll/issues/463))

I took some inspiration in a Gem I found for including [gists](http://blog.55minutes.com/2012/03/liquid-gist-tag-for-jekyll/)
and I started developing my own gem. I never developed a gem before, so I decided to download RubyMine and use the
default template they have for that. With the help of the [guides](http://guides.rubygems.org/make-your-own-gem/) in
rubygems.org, I adapted some minor stuff to make the `.gemfile` ready for my gem, so I was ready to start developing.

I decided to create a single module (`JekyllGithubContent`) to encompass the classes of the Gem. Here is the resulting
file (injected using the gem :-):

{% github_fileref https://github.com/francisco-perez-sorrosal/jekyll-github-content/blob/master/lib/jekyll_github_content.rb %}
{% highlight java linenos %}
{% github_file https://github.com/francisco-perez-sorrosal/jekyll-github-content/blob/master/lib/jekyll_github_content.rb %}
{% endhighlight %}

Basically the gem is composed by three classes. The code is very simple and auto-commented, so it's not worth to add
something else:

* GithubUriParser - A parser that receives a path of a Github file and parses its contents for further use in the 
other 2 classes.
* GithubContentRenderer - The responsible of rendering the file contents with the help of the previous class and the
[Liquid](https://shopify.github.io/liquid/) templating engine.
* GithubMetaContentRenderer - An extension of the previous class that presents only the file metadata.

Finally the last two lines (94 and 95), are responsible the register the two new tags defined by the gem in order
to inject the Github files. The Gem usage is described [here](https://github.com/francisco-perez-sorrosal/jekyll-github-content/blob/master/README.md).

Once the gem was ready, I opened an account in https://rubygems.org/ and I added my gem to the repo: 

```shell
# Build the gem
$ gem build jekyll_github_content.gemspec
# Push it to the rubygems repo
$ gem push jekyll_github_content-0.0.3.gem
# Add your credentials and that's it!
```

At some point I had to create new version, and I wanted to get rid of the old ones in the public repo. We can achieve
that with `gem yank jekyll_github_content -v 0.0.2`.

After installing and testing the gem locally with my Jekyll website, I was ready to commit the integration in my
Jekyll website, which consists only in adding the gem to the `Gemfile` as it's shown below, again using the gem:

{% github_fileref https://github.com/francisco-perez-sorrosal/francisco-perez-sorrosal.github.io/blob/source/Gemfile %}
{% highlight java linenos %}
{% github_file https://github.com/francisco-perez-sorrosal/francisco-perez-sorrosal.github.io/blob/source/Gemfile %}
{% endhighlight %}

In order to add the gem to the my [github-pages website](http://francisco-perez-sorrosal.github.io/), as Github does 
not admit external gems, I had to generate the website statically as I described [in this other blog post]({% post_url 2016-07-21-jekyll-and-github-pages %}).