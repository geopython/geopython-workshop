#!/bin/bash

PROGRAM_NAME=$(basename $0)

USAGE="Usage: $PROGRAM_NAME <start|stop|url|update|clean>"

if [ "$#" -ne 1 ]; then
    echo $USAGE
    exit 1
fi

# Test for the command
if [ $1 == "start" ]; then
    $0 stop
    docker compose up -d
elif [ $1 == "stop" ]; then
    docker compose stop
    docker compose rm --force
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

    url=$(docker logs geopython-workshop-jupyter 2>&1 | grep "    or http" | sed 's/     or //')
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
