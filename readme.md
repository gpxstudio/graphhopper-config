This repository contains the scripts and config files that are running [GraphHopper](github.com/graphhopper/graphhopper) instances for [gpx.studio](https://github.com/gpxstudio/gpx.studio).

### System parameters

Follow steps described here:

https://github.com/graphhopper/graphhopper/blob/master/docs/core/deploy.md#system-tuning


Some general information is also available here:

https://www.graphhopper.com/blog/2022/06/27/host-your-own-worldwide-route-calculator-with-graphhopper/

### Docker

Install Docker on the server by following the instructions here: https://docs.docker.com/engine/install/ubuntu/.
Then, add user to the docker group:
```
sudo usermod -a -G docker $USER
```
and log out and log in.
Finally, build the Docker image by running the build script.
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
20 0 1,14 * * /home/user/graphhopper-config/cron.sh > /home/user/graphhopper-config/cron_logs
```

### NGINX

Install Nginx:
```
sudo apt install nginx
```
Then, replace the default configuration and reload the service.
```
sudo rm /etc/nginx/sites-enabled/default
sudo cp graphhopper.conf /etc/nginx/sites-enabled/
sudo nginx -s reload
```

### Infrastructure

2 servers with 128GB of RAM.
Load balancer with health checks.
