#!/bin/bash

ids=$(docker ps -a -q)
if [ -n "$ids" ]; then
  docker stop $ids
  docker rm $ids
fi

docker system prune -f

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$script_dir/import.sh"
"$script_dir/server.sh"
