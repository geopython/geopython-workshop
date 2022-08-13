# Docker

## About Docker

Docker has been available for almost 10 years, and provided as a deployment option on numerous FOSS software and OSGeo projects. Given the current
era of computing, chances are that you have heard of Docker and *containerization*. Or, perhaps are already familiar and hopefully using Docker already.
If not, there is a wide array of introductory materials that can be found online like this [tutorial from IBM](https://www.ibm.com/in-en/cloud/learn/Docker).

FOSS4G software has benefitted greatly from Docker (consistent packaging, isolation, integration and upgrade patterns) in
comparison to custom installations. Though today we mainly use Docker, the bigger picture is the use of **Containers** as a next step
in virtualization. Containerization certainly deserves its own workshop, so for the purpose of this workshop we cover the basics
of Docker and Docker Compose.

[Docker Compose](https://docs.docker.com/compose) is an addition to Docker to facilitate
the orchestration (configuration) of one or more Docker 'Containers' (a Container is a running instance of a Docker image)
using a configuration convention (the Docker Compose YAML file), usually named `docker-compose.yml`.

Stepping up further are even more sophisticated Docker orchestrators like 
[Rancher](https://rancher.com/products/rancher) and [Kubernetes](https://kubernetes.io), but for
this workshop, Docker and Docker Compose are all we need.

## Installation

Docker installation has greatly progressed over the years. This is the only part of the workshop
which is dependent on the system/OS you are running (e.g. Windows, Mac or Linux). For each
system the Docker website provides detailed installation instructions. 
Please follow these consistently.

> Docker Compose in older (pre Compose v2) versions was a separate (Python) program to install,
> though it was usually present in Docker Desktop. 
> The `docker compose` command in that case is `docker-compose` (hyphened).
> Since 2021, Docker Desktop includes Compose in the Docker CLI.
> The command is then `docker compose` (space).
    
In our texts we will use `docker-compose`. Depending on your installation you may need
to replace the hyphen (`-`) with a space. But you can always install the original
compose (`docker-compose`) via `pip install docker-compose`.

For many platforms a product called `Docker Desktop` is available, which includes `Docker Compose`:

* Windows [installation](https://docs.Docker.com/desktop/install/windows-install)
* Mac [installation](https://docs.Docker.com/desktop/install/mac-install)
* Linux [installation](https://docs.Docker.com/desktop/install/linux-install)

Some notes:

* On Windows we recommend using the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) (WSL) as it also provides a powerful (Bash) command line and has optimal integration with Docker
* On Mac, if you are using [Homebrew](https://brew.sh), consider (as the author has) using the [brew Docker formula](https://formulae.brew.sh/formula/Docker)
* On Linux, you can choose the relevant installer for your platform. You can also use Virtualbox with a Ubuntu Image or use a cloud VM
* Docker desktop includes a graphical user interface with some interesting options. You can see logs and information about running containers, open their service in a browser or even open a terminal inside the container

If all goes well, you should be able to run Docker from the command line as follows: [^2]

```bash
$ docker --version
Docker version 20.10.17, build 100c701
$ docker-compose --version  
Docker Compose version v2.6.1
```
