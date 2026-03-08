#!/bin/bash

ids=$(docker ps -a -q)
if [ -n "$ids" ]; then
  docker stop $ids
  docker rm $ids
fi
docker system prune -f

./import.sh
./server.sh
