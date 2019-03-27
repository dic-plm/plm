#!/bin/bash
docker rmi -f `docker images | awk '{if (NR!=1) {print $3}}'`
docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
##for non empty docker Volumes
##docker volume ls -q | xargs --no-run-if-empty docker volume rm -v
echo Killing all Containers
for i in $( docker ps -q ) ; do
  docker kill $i
done

echo Removing all Containers
for i in $( docker ps -aq ) ; do
  docker rm $i
done

echo Removing all Images
for i in $( docker images -q ) ; do
  docker rmi -f $i
done

echo Removing all Networks
for i in $( docker network ls -q ) ; do
  docker network rm $i
done

echo Removing all Volumes
for i in $( docker volume ls -q ) ; do
  docker volume rm $i
done
echo "testing the git hub 1st time"