---
layout: post
title:  "Change Committer Information in Multiple Commits in Git"
date:   2016-08-01 23:05:00 -0700
categories: git commit metadata rewrite tricks
---

At some point while I was working in a small project with a friend of mine, I realized that I was tagging my commits with
the wrong committer credentials. I didn't changed the project's git config file with the right data, so git was taking
the default data contained in the `~/.gitconfig` file. I already had done multiple interleaved commits with my
friend's, so it was not possible to make a simple amend to the last commit: `git commit --amend --author "Author <new@email.com>" --no-edit`
Moreover, the previous solution does not preserve the time of the commit, as it updates it to the current time.

Fortunately we can use a combination of Git commands to perform the required task. We can use the `filter-branch` command 
with the `--commitFilter` argument to rewrite the Git revision history by rewriting the branches specified applying a
filter all along the history: `git filter-branch --commitFilter <filter-command> <branch>`. The `-f` option can be 
used to force update the refs.

The `<filter-command>` is introduced between ' symbols and can include Git variables such as `GIT_AUTHOR_NAME` or 
`GIT_AUTHOR_EMAIL`. So, as I wanted to change my commits, I had to look for the committer name and if it was me, change
the commit metadata accordingly to my new requirements. To create the new commit, we'll use the Git `commit-tree`
command, which creates a new commit based on the provided tree object, emiting the new commit id on the standard output.

I created a gist with a small shell script to automate the task:

{% gist 5122ea5be99fc71f2a8d8912a15ed921 %}

The output after executing the script is similar to this:

```
Rewrite df3205e092bee16b3ae05a6e7c46847bf0a9ac0b (31/33) (2 seconds passed, remaining 0 predicted)
Ref 'refs/heads/master' was rewritten
```

Once the refs have been rewritten, we need to update the remote repo using the `git push -f` command to force the push.