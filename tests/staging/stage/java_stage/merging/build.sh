#! /bin/bash

(cd /pipeline/; mvn clean compile assembly:single)
(cd /pipeline/; mvn package)
