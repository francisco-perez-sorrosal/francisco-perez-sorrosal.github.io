#!/usr/bin/env bash
set -e # halt script on error

if [[ $TRAVIS_BRANCH == 'source' ]] ; then
  cd _site
  git init

  git config user.name "Travis CI"

  git add .
  git commit -m "Deploy"

  # We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --force --quiet "https://${GH_TOKEN}@github.com/francisco-perez-sorrosal/francisco-perez-sorrosal.github.io.git" master:master > /dev/null 2>&1
else
  echo 'Invalid branch. You can only deploy from gh-pages.'
  exit 1
fi