# surreal_view_app
Surreal_view compares BioProject, BioSample, DRR, taxon, and sequence accession across the DDBJ DBs

## Build container
```
docker build . -t surreal_view_app
```
## Run container with docker-compose
```
docker-compose up -d
```
### Alternatively pull from [DockerHub](https://hub.docker.com/r/ghelfi/surreal_view) 
```
docker pull ghelfi/surreal_view:latest
docker run --name surreal -p 3201:3201 -d ghelfi/surreal_view
```
