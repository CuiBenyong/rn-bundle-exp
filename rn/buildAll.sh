#!/bin/sh

pwd

PLATFORM=$1

VERSION=$2


if [ "" = "${VERSION}" ]; then
VERSION="v1.0"
fi

if [ "ios" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildCore.sh ios ${VERSION}
fi

if [ "android" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildCore.sh android ${VERSION}
fi

if [ "ios" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildHome.sh ios ${VERSION}
fi

if [ "android" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildHome.sh android ${VERSION}
fi

if [ "ios" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildBiz.sh Mine ios ${VERSION}
fi

if [ "android" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildBiz.sh Mine android ${VERSION}
fi

if [ "ios" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildBiz.sh Setting ios ${VERSION}
fi

if [ "android" = "${PLATFORM}" -o "" = "${PLATFORM}" ]; then
sh buildBiz.sh Setting android ${VERSION}
fi
