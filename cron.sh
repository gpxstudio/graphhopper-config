#!/bin/bash

ids=$(docker ps -a -q)
if [ -n "$ids" ]; then
  docker stop $ids
  docker rm $ids
fi

docker system prune -f

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd $script_dir

./import.sh
./server.sh
