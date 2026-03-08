#!/bin/bash

ids=$(docker ps -a -q)
if [ -n "$ids" ]; then
  docker stop $ids
  docker rm $ids
fi

docker system prune -f

cwd=$(pwd)

"$cwd/import.sh"
"$cwd/server.sh"
