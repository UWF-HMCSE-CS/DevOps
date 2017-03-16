#! /bin/bash

(cd /pipeline/; mvn package)

(cd /pipeline/; git checkout master)
(cd /pipeline/; git merge $1)
(cd /pipeline/; git push $2 master)
