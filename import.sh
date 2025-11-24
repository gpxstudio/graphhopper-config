#!/bin/bash

pbf_file=https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf

rm -rf graph-cache-new
rm -rf logs

mkdir -p data
mkdir -p graph-cache-new
mkdir -p srtm
mkdir -p logs

cp config.yml data/config.yml

if [ -f data/data.osm.pbf ]; then
    mod_time=$(stat -c "%Y" data/data.osm.pbf)
    current_time=$(date +%s)
    age=$((current_time - mod_time))
    # if file is older than 7 days (604800 seconds), re-download
    if [ $age -lt 604800 ]; then
        echo "Using existing data.osm.pbf file."
    else
        echo "Existing data.osm.pbf file is old. Re-downloading."
        rm -f data/data.osm.pbf
        curl -L $pbf_file -o data/data.osm.pbf
    fi
else
    echo "data.osm.pbf file does not exist. Downloading."
    curl -L $pbf_file -o data/data.osm.pbf
fi

if [ ! -f data/data.osm.pbf ]; then
    echo "data.osm.pbf download failed!"
    exit 1
fi

docker run \
    -v ./data:/data:ro \
    -v ./graph-cache-new:/graphhopper/graph-cache \
    -v ./srtm:/tmp/srtm \
    -v ./logs:/graphhopper/logs \
    --entrypoint /bin/bash israelhikingmap/graphhopper \
    -c "java -Xmx64g -Ddw.graphhopper.datareader.file=/data/data.osm.pbf -jar *.jar import /data/config.yml"

if [ $(grep -c "flushed graph total" logs/graphhopper.log) -eq 0 ]; then
    echo "Import failed!"
    exit 1
fi

rm -rf graph-cache
mv graph-cache-new graph-cache