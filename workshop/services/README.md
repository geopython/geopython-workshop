# Services

This directory provides support for the Publishing Section. 
**NB this section is optional**

The basic idea is to allow for updating pygeoapi or pycsw service configurations from
locally volume mounted configuration files which then, on docker container
restart, will reflect updates made.

## Running

Optional services - not for regular workshop.

* start: docker compose -f docker-compose-services.yml up -d
* stop: docker compose -f docker-compose-services.yml stop

While running you can publish data, and then restart each individual container. See below.

## Publishing Data

Basic workflow:

* edit [pygeoapi configuration](pygeoapi-config.yml)
* restart docker container with `docker restart geopython-workshop-pygeoapi`
* view updates via http://localhost:5000

## Publishing Metadata

Basic workflow:

* edit [pycsw configuration](pycsw-config.yml)
* restart docker container with `docker restart geopython-workshop-pycsw`
* view updates via http://localhost:8001
