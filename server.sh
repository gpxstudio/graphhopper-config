#!/bin/bash

mkdir -p logs

cp config.yml /data/config.yml

sed -i 's/RAM_STORE/MMAP/g' /data/config.yml

docker run \
    -v /data:/data:ro \
    -v ./graph-cache:/graphhopper/graph-cache \
    -v ./logs:/graphhopper/logs \
    -p 8989:8989 \
    -p 8990:8990 \
    graphhopper \
    -c "java -Xmx90g -XX:+UseZGC -jar *.jar server /data/config.yml"