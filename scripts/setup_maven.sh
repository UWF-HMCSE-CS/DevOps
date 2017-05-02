#! /bin/sh

# Install Maven inside a Docker ubuntu container
apt-get update
apt-get upgrade
apt-get install software-properties-common
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java7-installer
apt-get install maven

# Working with Maven
#mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.1 -DgroupId=com.company -DartifactId=project -Dversion=1.0-SNAPSHOT -Dpackage=com.company.pr
