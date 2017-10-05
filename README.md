# Docker image for Deeplearning4j UI

This is docker image for running [Deeplearning4j UI](https://deeplearning4j.org/visualization#ui) server. 

The UI server is configured to store received statistics to file instead of in memory so the data can be retrieved and backed up.

## Run
Simple run command to install latest version:
```
docker run --name deeplearning4j-ui -d -p 9000:9000 gregsi/docker-deeplearning4j-ui
```

Run container with mounted shared volume for accesing Deeplearning4j UI server data from host to running docker container 
```
docker run --name deeplearning4j-ui -d -p 9000:9000 -v /some-host-folder:/root gregsi/docker-deeplearning4j-ui
```

## Versions
 - [gregsi/docker-deeplearning4j-ui:1.2 (latest)](https://github.com/GregaVrbancic/docker-deeplearning4j-ui/blob/f2443d311959168e7a4538c539f4aaa7be5ed3c3/Dockerfile): update DL4J to version 0.9.1
 - [gregsi/docker-deeplearning4j-ui:1.1](https://github.com/GregaVrbancic/docker-deeplearning4j-ui/blob/0632dc139d6c365da095e99d0244c8836564142b/Dockerfile): DL4J version 0.8.0