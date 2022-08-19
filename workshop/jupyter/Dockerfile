# =================================================================
#
# Authors: Just van den Broecke <justb4@gmail.com>
#
# Copyright (c) 2019 Just van den Broecke
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# =================================================================

FROM ubuntu:22.04

LABEL maintainer="Just van den Broecke <justb4@gmail.com>"

# ARGS
ARG TZ="Etc/UTC"
ARG LANG="en_US.UTF-8"
ARG ADD_DEB_PACKAGES=""
ARG ADD_PIP_PACKAGES=""

# ENV settings
ENV TZ=${TZ} \
	LANG=${LANG} \
	DEBIAN_FRONTEND="noninteractive" \
	DEB_BUILD_DEPS="gpg-agent software-properties-common build-essential apt-utils python3-dev libproj-dev" \
	DEB_PACKAGES="locales locales-all proj-bin python3-shapely python3-pyproj python3-setuptools python3-pip python3-gdal python3-fiona python3-rasterio python3-pyproj ${ADD_DEB_PACKAGES}" \
	PIP_PACKAGES="jupyter ${ADD_PIP_PACKAGES}" \
	PROJ_DIR="/usr"

COPY ./requirements.txt /jupyter/requirements.txt

# Run all installs
RUN \
    # Install dependencies
    apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --fix-missing --no-install-recommends ${DEB_BUILD_DEPS}  \
    && add-apt-repository ppa:ubuntugis/ubuntugis-unstable && apt-get update -y \
    && apt-get --no-install-recommends install -y ${DEB_PACKAGES} \
    && update-locale LANG=${LANG} \
    && echo "For ${TZ} date=$(date)" && echo "Locale=$(locale)" \
	&& pip3 install ${PIP_PACKAGES} \
	&& pip3 install -r /jupyter/requirements.txt \
	&& apt-get remove --purge ${DEB_BUILD_DEPS} -y \
	&& apt autoremove -y  \
	&& rm -rf /var/lib/apt/lists/* 
	# Patch for now until https://github.com/jupyter-widgets/ipyleaflet/issues/865 solved in version
	# && sed -i /usr/local/lib/python3.10/dist-packages/ipyleaflet/basemaps.py -e 's/com\/\/tiles/com\/tiles/g'

COPY ./entrypoint.sh /jupyter/start.sh

WORKDIR /jupyter/content/notebooks
ENTRYPOINT ["/jupyter/start.sh"]
