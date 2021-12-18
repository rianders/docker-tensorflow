# Tensorflow for the Raspberry PI 4

## Setup 

```
docker build --platform linux/arm32v7 -t rianders/tensorflow32:2.4.0 -f Dockerfile .
docker push rianders/tensorflow32:2.4.0
```

## Build

```
DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --platform linux/arm/v7 -t tensorflow:2.1.0-cp35 --load .
```

It should take about 2 hours on a 9900k.

## Run

docker run --rm -it rianders/tensorflow:2.1.0-cp35 bash