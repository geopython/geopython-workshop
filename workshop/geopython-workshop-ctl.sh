#!/bin/bash

shopt -s expand_aliases

PROGRAM_NAME=$(basename $0)

USAGE="Usage: $PROGRAM_NAME <start|stop|url|update|clean>"

if [ "$#" -ne 1 ]; then
    echo $USAGE
    exit 1
fi

# Sniff which Docker Compose variant is installed
# and set an alias.
# See https://github.com/geopython/geopython-workshop/issues/82
if command docker-compose --version &> /dev/null
then
  alias dockercompose='docker-compose'
  echo "Using docker-compose"
else
  if !command docker compose version &> /dev/null
  then
    echo "Neither docker-compose nor docker compose is available"
    echo "Check your Docker Installation"
    exit 1
  fi
  alias dockercompose='docker compose'  
  echo "Using docker compose"
fi

# Test for the command
if [ $1 == "start" ]; then
    $0 stop
    dockercompose up -d
elif [ $1 == "stop" ]; then
    dockercompose stop
    dockercompose rm --force
elif [ $1 == "url" ]; then
    # try to open the Jupyter Notebook in Browser
    platform="$(uname | tr '[:upper:]' '[:lower:]')"

    if [[ $platform == 'linux' ]]; then
       openapp="xdg-open"
    elif [[ $platform == 'darwin' ]]; then  # MacOS
       openapp="open"
    else  # assume some kind of Windows variant
      openapp="cmd /c start"
    fi

    # Filter the URL from the log output
    url=$(docker logs geopython-workshop-jupyter 2>&1 | grep "http://127.0.0.1" | tail -n 1 | xargs)
    if [ -z ${url} ]; then
        echo "workshop not started"
        echo "did you start the workshop? (i.e. bash $0 start)"
        exit 2
    fi
    echo "Attempting to open ${url} in your browser on platform ${platform}..."
    echo "If this fails, simply copy/paste that URL in your browser"
    ${openapp} ${url}
elif [ $1 == "update" ]; then
    docker pull geopython/geopython-workshop:latest
    echo
    echo
    echo "workshop is running the latest Docker images"
    echo "If updates occured, then stop/start the workshop"
elif [ $1 == "clean" ]; then
    # Remove all exited containers
    for c in $(docker ps -a -f status=exited -q)
    do
        docker rm ${c}
    done
    # And dangling images
    for i in $(docker images -f dangling=true -q)
    do
        docker rmi ${i}
    done
else
    echo ${USAGE}
fi
