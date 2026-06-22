[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/geopython/geopython-workshop/master?labpath=workshop%2Fjupyter%2Fcontent%2Fnotebooks%2F01-introduction.ipynb)

# Doing Geospatial in Python

See Workshop entry doc https://geopython.github.io/geopython-workshop.

## Installation

### Requirements

The workshop uses Jupyter Notebooks. [Jupyter](https://jupyter.org/) is an interactive development environment suitable for documenting and reproducing workflows using live code.

As the installation of all dependencies on all platforms (Windows, Mac, Linux) can be quite involved and complex this workshop provides all components within a Docker Image.

In addition, geospatial web services like pygeoapi and pycsw in this workshop are provided by Docker images.

The core requirement is to have Docker and Docker Compose installed on the system. Once you have Docker and Docker Compose installed you will be able to install and run the workshop without any other dependencies.

Alternatively, if you're confident with Python development, you can run the notebook in a local Anaconda or Python environment. [Read more about running locally](#running-locally)

### Docker Images

The Docker Images for this workshop are [available on DockerHub](https://hub.docker.com/r/geopython/geopython-workshop).
The name of the workshop Image is `geopython/geopython-workshop[:latest]`.
Note that the Docker Images contain mainly all (Python) components/dependencies. The actual workshop content (data+notebooks) will be
Docker-Volume-mounted. There is no need to build the Docker Image yourself (see below), except for testing and development.

## Running

All services are started using a [Docker Compose file](https://github.com/geopython/geopython-workshop/blob/master/workshop/docker-compose.yml).

Linux, macOS, or WSL:

```bash
cd workshop
# start workshop
./geopython-workshop-ctl.sh start
# display URL and open in default web browser, if a browser does not open, then copy the url from the command output to your browser.
./geopython-workshop-ctl.sh url
# stop workshop
./geopython-workshop-ctl.sh stop
```

Windows (PowerShell or Command Prompt):

```bat
cd workshop
.\win-geopython-workshop-ctl.bat start
.\win-geopython-workshop-ctl.bat url
.\win-geopython-workshop-ctl.bat stop
```

Windows (PowerShell + bash):

```bash
cd workshop
# start workshop
bash ./geopython-workshop-ctl.sh start
# display URL and open in default web browser
bash ./geopython-workshop-ctl.sh url
# stop workshop
bash ./geopython-workshop-ctl.sh stop
```

NB [Jupyter notebook](https://en.wikipedia.org/wiki/Project_Jupyter) needs a **token**. The token is displayed in the jupyter container logs on startup:

`http://127.0.0.1:8888/?token=<longtokenhexstring>`.

As Docker Compose may run in background you can make logging
output visible via `docker logs --follow geopython-workshop-jupyter`. Or 
in Docker Desktop UI, select the jupyter container to see its logs.
 
### Building

You may always build a Docker Image from this repo yourself, e.g. for bugfixing:

```bash
git clone https://github.com/geopython/geopython-workshop.git
cd geopython-workshop.git/workshop/jupyter
./build.sh
```

### Notes

- Docker must be managed by non-root users in linux. Please make sure to perform the following [post-installation step](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user).
- by default the web services pygeoapi and pycsw are not required for the regular workshop like FOSS4G
- if you use pygeoapi: there is an issue with MacOS Monterey where the port 5000 is already used and therefore conflicting with that one used by pygeoapi. If you are facing this error `OSError: [Errno 48] Address already in use` then your machine is affected. To overcome the issue you can disable the *Airplay Receiver* from `System Preferences->Sharing` of your MacOS (detailed description in this blog [post](https://progressstory.com/tech/port-5000-already-in-use-macos-monterey-issue/)).

### Running locally

If you're confident with Python development, consider to run the Jupyter notebook locally. The operations below require a [anaconda](https://www.anaconda.com/) or [(micro)mamba](https://mamba.readthedocs.io/en/latest/user_guide/mamba.html) environment.

```bash
# clone the workshop repository
git clone https://github.com/geopython/geopython-workshop.git
cd geopython-workshop/
# create virtual environment
micromamba create -n pyworkshop python=3.12 jupyterlab -y
micromamba activate pyworkshop
# install conda workshop requirements
micromamba install -n pyworkshop -c conda-forge gdal notebook
cd workshop/jupyter
# install python workshop requirements
pip3 install -r requirements.txt
cd content/notebooks
# Run the notebook, copy url (with token) to browser if browser does not open automatically
jupyter notebook
```

### Bugs and Issues

All bugs, enhancements and issues are managed
on [GitHub](https://github.com/geopython/geopython-workshop/issues).

## Contact

https://gitter.im/geopython/geopython-workshop
