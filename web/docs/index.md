# Doing Geospatial in Python

With a low barrier to entry and large ecosystem of tools and libraries, Python is the lingua franca for geospatial. Whether you are doing data acquisition, processing, publishing, integration, analysis or software development, there is no shortage of solid Python tools to assist you in your daily workflows.

This workshop will provide an introduction to performing common GIS/geospatial tasks using Python geospatial tools such as OWSLib, Shapely, Fiona/Rasterio, and common geospatial libraries like GDAL, PROJ, pycsw, as well as other tools from the geopython toolchain. Manipulate vector/raster data using Shapely, Fiona and Rasterio. Publish data and metadata to OGC APIs using pygeoapi, pygeometa, pycsw, and more. Visualize your data on a map using Folium, Bokeh and more. Plus a few extras in between!

The workshop is provided using the Jupyter Notebook environment with Python 3.

## Requirements

The workshop uses [Jupyter Notebooks](https://jupyter.org).  Jupyter is
an interactive development environment suitable for documenting and reproducing
workflows using live code.

As the installation of all dependencies on all platforms (Windows, Mac, Linux)
can be quite involved and complex this workshop provides all components 
within a [Docker Image](https://hub.docker.com/r/geopython/geopython-workshop).

In addition, geospatial web services like [pygeoapi](https://pygeoapi.io)
and [pycsw](https://pycsw.org) in this workshop are provided by Docker images.

The core requirement is to have [Docker](https://docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed
on the system.  Once you have Docker and Docker Compose installed you will be
able to install and run the workshop without any other dependencies.

More information on installing Docker can also be found [here](./docker).

### Optional requirements

Users may optionally install [QGIS](https://qgis.org) as a GIS data viewer.
QGIS is a free and open-source cross-platform desktop geographic information
system application that supports viewing, editing, and analysis of geospatial data.

## Data

The workshop provides various sample data to illustrate Python geospatial
functionality which has been tested to cover the workshop requirements.

Having said this, please feel free to bring your own! Examples:

- data: basically anything that can be read with GDAL
- metadata: ISO, FGDC, Dublin Core, OGC API - Records, STAC  or even pygeometa [MCF files](https://github.com/geopython/pygeometa/blob/master/sample.yml)

## Verifying your environment

Ensure Docker is running on your computer, then verify that the `docker`
and `docker-compose` commands are working and available:

```bash
docker version
docker-compose --version
```

If `docker-compose` gives a 'program not found' error:

> In recent versions of Docker the Docker Compose program is part
> of the Docker CLI, thus following the `docker <cmd>` pattern. 
> If `docker-compose --version` as above fails for you, 
> try `docker compose version` (all spaces). If the latter command works
> then use `docker compose` where the text shows `docker-compose`.
> Note that our main Bash script `geopython-workshop-ctl.sh` (see below) will
> figure out which variant you have installed and call the prober Docker Compose
> command.

## Installation
 
Below we will download and run the workshop content.

```bash
curl -O https://codeload.github.com/geopython/geopython-workshop/zip/master
unzip master
cd geopython-workshop-master/workshop

# start the workshop
./geopython-workshop-ctl.sh start

# display URL and open in default web browser
./geopython-workshop-ctl.sh url

# stop workshop
./geopython-workshop-ctl.sh stop
```

If the above `.sh` script does not work on your system 
you can execute `docker-compose` directly via:

```bash
# in dir geopython-workshop-master/workshop
docker-compose up -d
docker logs --follow geopython-workshop-jupyter
# look for URL+Token and Copy/Paste in browser
```

Below are utility commands. Use when stopped to clean and update.

```bash

# update the workshop Docker Images in case of new versions
./geopython-workshop-ctl.sh update

# clean your Docker environment from dangling Images/Containers
# (does not remove the workshop's images, only obsolete ones)
./geopython-workshop-ctl.sh clean

```

## Installation Issues

Docker installed but problems installing/running the workshop? Below some tips:

### Download Problems

Although `curl` may be on your system it may have problems with SSL (one user noted using OSGeo4W).
In that case you can add the `--insecure` commandline option or copy/paste the download URL in your browser and download from there.

### File/Drive Sharing

The workshop setup involves Docker Volume Mounting.
For Mac OS and Windows installs be sure to **enable File/Drive Sharing** within Docker Desktop for the directory where you unzipped the workshop.
Go to the `Preferences/Settings | File Sharing...`  menu and make settings accordingly.

### Running in VirtualBox

You may also run a VirtualBox VM with preferably Ubuntu, install Docker there and run the workshop. Even better if
you use [Vagrant](https://www.vagrantup.com) to provision/manage your VM. You could even unpack the .zip file
on your local machine and mount it within the VM, start the workshop there.

In any case, in order to access the services from your local machine, you need to do port mapping from
ports within the VM to your local machine in order to access the workshop from your local browser.
The following ports need to be mapped from the VirtualBox VM to your local system:
 **8888 (Jupyter)**, **5000 (pygeoapi)** and **8001 (pycsw)** .

You will possibly need to enable firewall access for these ports within your VM. Do this as follows:

```shell
sudo ufw allow 8888/tcp
sudo ufw allow 5000/tcp
sudo ufw allow 8001/tcp
```

Within VirtualBox menu you can then map these ports to the same ports on your local system, so the workshop
is accessed with your local browser via http://127.0.0.1:8888?token=..., http://127.0.0.1:5000 etc.

### Running Docker with privileged user in linux

Currently, the workshop doesn't support a docker installation that needs the `sudo` command to run Docker. The following [post-installation step](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) in the Docker documentation must be performed before running our script to start the workshop.

### Cannot Access URL

The workshop should run on http://127.0.0.1:8888?token="token" but in some cases this may not work.
In that case you could also try http://0.0.0.0:8888?token="token".

### MacOS Monterey issue

There is an issue with MacOS Monterey where the port 5000 is already used and therefore conflicting with that one used by pygeoapi. If you are facing this error `OSError: [Errno 48] Address already in use` then your machine is affected. To overcome the issue you can disable the *Airplay Receiver* from `System Preferences->Sharing` of your MacOS (detailed description in this blog [post](https://progressstory.com/tech/port-5000-already-in-use-macos-monterey-issue/)).

## No Docker Installed?

If you somehow were not able to install Docker:
there is a Cloud version of the Jupyter-Notebook-part of the workshop via "Jupyter Binder".

With some limits (e.g. no local geo-services, no data publication), you can follow most of the workshop using a remote Docker instance within your browser via "Jupyter Binder". Click on the button below
to launch the Workshop Binder Instance. Startup takes a while, be patient...

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/geopython/geopython-workshop/master?filepath=workshop%2Fjupyter%2Fcontent%2Fnotebooks%2F01-introduction.ipynb)

Additional notes for Binder session:

* session timeout is about 10 mins, if that happens, refreshing the page will not help, you need to start a new session using the button above

## Support

A [Gitter](https://gitter.im/geopython/geopython-workshop) channel exists for
discussion and live support from the developers of the workshop.

### Bugs and Issues

All bugs, enhancements and issues can be reported on [GitHub](https://github.com/geopython/geopython-workshop/issues).
