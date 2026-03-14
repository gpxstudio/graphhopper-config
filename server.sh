#!/bin/bash

mkdir -p data
mkdir -p logs

cp config.yml data/config.yml

docker run \
    -v ./data:/data:ro \
    -v ./graph-cache:/graphhopper/graph-cache \
    -v ./logs:/graphhopper/logs \
    -p 8989:8989 \
    -p 8990:8990 \
    graphhopper \
    -c "java -Xmx90g -XX:+UseZGC -Ddw.graphhopper.graph.dataaccess.default_type=MMAP -jar *.jar server /data/config.yml"