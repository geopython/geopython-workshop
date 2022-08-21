[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/geopython/geopython-workshop/master?filepath=workshop%2Fjupyter%2Fcontent%2Fnotebooks%2F01-introduction.ipynb)
# Doing Geospatial in Python

## Installation

### Requirements

The workshop requires [Docker](https://docker.com) 
and [Docker Compose](https://docs.docker.com/compose/) on your system

### Docker Images

The Docker Images for this workshop are [available on DockerHub](https://hub.docker.com/r/geopython/geopython-workshop). 
The name of the workshop Image is `geopython/geopython-workshop[:latest]`.
Note that the Docker Images contain mainly all (Python) components/dependencies. The actual workshop content (data+notebooks) will be
Docker-Volume-mounted.

You may always build a Docker Image from this repo yourself:

```bash
git clone https://github.com/geopython/geopython-workshop.git
cd geopython-workshop.git/workshop/jupyter
./build.sh
```

## Running

All services are started using a [Docker Compose file](https://github.com/geopython/geopython-workshop/blob/master/workshop/docker-compose.yml).

```bash
cd workshop
# start workshop
./geopython-workshop-ctl.sh start
# display URL and open in default web browser
./geopython-workshop-ctl.sh url

# Browse to http://127.0.01:5000 for workshop pygeoapi service
# Browse to http://127.0.01:8001 for workshop pycsw service
# NB Possibly best if we add a frontend or use docs ("home") as entrypoint
./geopython-workshop-ctl.sh stop
```

NB Jupyter notebook needs a **token**. The token is displayed on startup:

`http://127.0.0.1:8888/?token=<longtokenhexstring>`.

As Docker Compose may run in background you can make logging 
output visible via `docker logs --follow geopython-workshop-jupyter`.

### Notes

- There is an issue with MacOS Monterey where the port 5000 is already used and therefore conflicting to that one used by pygeoapi. If you are facing with this error `OSError: [Errno 48] Address already in use` then your machine is affected. To overcome the issue you can disable the *Airplay Receiver* from `System Preference->Sharing` of your MacOS (detailed description in this blog [post](https://progressstory.com/tech/port-5000-already-in-use-macos-monterey-issue/)).  

### Bugs and Issues

All bugs, enhancements and issues are managed 
on [GitHub](https://github.com/geopython/geopython-workshop/issues).

## Contact

https://gitter.im/geopython/geopython-workshop
