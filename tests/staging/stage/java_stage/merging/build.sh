#! /bin/bash

(cd /pipeline/; mvn package)

git checkout master
git merge $1
git push $2 master
