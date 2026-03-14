This repository contains the scripts and config files that are running [GraphHopper](github.com/graphhopper/graphhopper) instances for [gpx.studio](https://github.com/gpxstudio/gpx.studio).

### System parameters

Follow steps described here:

https://github.com/graphhopper/graphhopper/blob/master/docs/core/deploy.md#system-tuning


Some general information is also available here:

https://www.graphhopper.com/blog/2022/06/27/host-your-own-worldwide-route-calculator-with-graphhopper/

### Docker image

```
./build.sh
```

### Periodical updates

Open cron file
```
crontab -e
```
and add a line to schedule the cron.sh script
```
40 16 7 * * /home/user/graphhopper-config/cron.sh > /home/user/graphhopper-config/cron_logs
```

### NGINX reverse proxy

```
cp graphhopper.conf /etc/nginx/sites-enabled/
nginx -s reload
```

### Infrastructure

2 servers with 128GB of RAM.
Load balancer with health checks.
