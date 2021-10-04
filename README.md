# collectd docker image

## Description

collectd is a daemon which collects system performance statistics periodically
and provides mechanisms to store the values in a variety of ways, for example 
in RRD files.

This image allows you to run collectd in a completely containerized
environment

## How to use this image

Run collectd with the default configuration:

```
docker run \
  --privileged \
  -v /proc:/mnt/proc:ro \
  stewartn782/collectd
```

Run collectd with a custom configuration stored in /etc/collectd:

```
docker run \
  --privileged \
  -v /etc/collectd:/etc/collectd:ro \
  -v /proc:/mnt/proc:ro \
  stewartn782/collectd
```

Run collectd with docker-compose, amending the image tag as required:

```
services:
  collectd:
    image: collectd:latest
    privileged: true
    network_mode: host
    volumes:
      - /proc:/mnt/proc:ro
```


## FAQ

### Do you need to run the container as privileged?

Yes. Collectd needs access to the parent host's /proc filesystem to get
statistics. It's possible to run collectd without passing the parent host's
/proc filesystem without running the container as privileged, but the metrics
would not be accurate.

