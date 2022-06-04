#!/bin/bash

CFX_PATH=${1}
SERVER_VERSION=${2}
RESOURCES_VERSION=${3}
CFX_LINUX_SERVER_URL=https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/
CFX_RESOURCES_URL=https://github.com/citizenfx/cfx-server-data/

echo "Running cfx-setup.sh with args:"
echo "CFX_PATH=${CFX_PATH}"
echo "SERVER_VERSION=${SERVER_VERSION}"
echo "RESOURCES_VERSION=${RESOURCES_VERSION}"
echo "CFX_LINUX_SERVER_URL=${CFX_LINUX_SERVER_URL}"
echo "CFX_RESOURCES_URL=${CFX_RESOURCES_URL}"

mkdir -p ${CFX_PATH}server-files/ && mkdir -p ${CFX_PATH}server-resources/ \
    && chmod 777 ${CFX_PATH}cfx/server-files/ && chmod 777 ${CFX_PATH}server-resources/

if [ $SERVER_VERSION == "latest-recommended" ] || [ $SERVER_VERSION == "latest-optional" ]
then
    SEARCH_PATTERN=$(echo ${SERVER_VERSION^^} | tr "-" " ")
    # echo " wget -q -O - $CFX_LINUX_SERVER_URL | grep -B 1 '$SEARCH_PATTERN' | tail -n -2 | head -n -1 | cut -d '\"' -f 2 | cut -c 2-"
    SERVER_FILE=$(wget -q -O - $CFX_LINUX_SERVER_URL | grep -B 1 "$SEARCH_PATTERN" | tail -n -2 | head -n -1 | cut -d '"' -f 2 | cut -c 2-)
fi

VERSION_REGEX='^[0-9]+$'
if [ $SERVER_VERSION == "latest" ] || [[ $SERVER_VERSION =~ $VERSION_REGEX ]]
then
    SEARCH_PATTERN=$([ $SERVER_VERSION == "latest" ] && echo "is-active" || echo "$SERVER_VERSION")
    SERVER_FILE=$(wget -q -O - $CFX_LINUX_SERVER_URL | grep -B 1 "$SEARCH_PATTERN" | head -2 | grep -Po '(?<=href=")[^"]*(?=")' | cut -c 2-) #
fi

curl ${CFX_LINUX_SERVER_URL}${SERVER_FILE} --output ${CFX_PATH}server-files.tar.xz \
    && tar -xf ${CFX_PATH}server-files.tar.xz -C ${CFX_PATH}server-files/


if [ $RESOURCES_VERSION == "latest" ]
then
    RESOURCES_VERSION=$(git ls-remote ${CFX_RESOURCES_URL} HEAD | cut -c1-7)
fi

curl -L ${CFX_RESOURCES_URL}archive/${RESOURCES_VERSION}.tar.gz --output ${CFX_PATH}server-resources.tar.gz \
    && tar -xf ${CFX_PATH}server-resources.tar.gz --strip-components=2 -C ${CFX_PATH}server-resources/

chmod -R 777 ${CFX_PATH}server-resources/