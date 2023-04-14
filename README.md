# surreal_view_app_light

Surreal_view is a tool that compares BioProject, BioSample, DRR, taxon, and sequence accession across the DDBJ databases. This lightweight version implements ShinyProxy and a volume container to manage different databases independently of the front-end application.

## Features

- Compare BioProject, BioSample, DRR, taxon, and sequence accession across DDBJ databases
- Utilizes ShinyProxy to manage the front-end application
- Volume container for handling independent databases

## Building the Docker Containers

### 1. Build the APP container

To build the APP container, run the following command:

```
cd front_end
docker build . -t ghelfi/surreal_view_app_light

```
### 2. Build the ShinyProxy container
To build the ShinyProxy container, run the following command:
```
cd surrealnet
docker build . -t ghelfi/shinyproxy-surrealview
```
### 3. Build the container with volume (mock_data)
To build the container with the mock_data volume, run the following command:
```
cd docker_volumes
docker build . -t ghelfi/mock_volume
```
Deploying surreal_view_app_light
### 1. Pull containers from [DockerHub](https://hub.docker.com/r/ghelfi/surreal_view) 
```
docker pull ghelfi/surreal_view_app_light:latest
docker pull ghelfi/shinyproxy-surrealview:latest
docker pull ghelfi/mock_volume:latest
```
### 2. Create a Docker volume
```
docker run -it --rm -v db_master:/usr/local/src/app/data ghelfi/mock_volume
```
### 3. Check the Docker volume
```
docker volume ls
docker volume inspect db_master
```
### 4. Optionally remove the mock_volume image
```
docker image rm ghelfi/mock_volume
```
### 5. Create a Docker network
```
docker network create surrealnet
docker network ls
```
### 6. Run ShinyProxy surreal_view
```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock --net surrealnet -p 3201:3201 ghelfi/shinyproxy-surrealview
```
