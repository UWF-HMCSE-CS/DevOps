#! /bin/bash

rm -rf MediumFX
cp -r ../Medium/MediumFX ./
docker build -t junit ./
docker run -it junit
