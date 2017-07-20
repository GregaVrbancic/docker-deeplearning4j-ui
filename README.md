# Docker image for Deeplearning4j UI

This is docker image for running [Deeplearning4j UI](https://deeplearning4j.org/visualization#ui) server. 

The UI server is configured to store received statistics to file instead of in memory so the data can be retrieved and backed up.

## Run
Simple run command:
```
docker run --name deeplearning4j-ui -d -p 9000:9000 gregsi/docker-deeplearning4j-ui
```

Run container with mounted shared volume for accesing Deeplearning4j UI server data from host to running docker container 
```
docker run --name deeplearning4j-ui -d -p 9000:9000 -v /some-host-folder:/root gregsi/docker-deeplearning4j-ui
```