#!/bin/sh
PLATFORM=$1

VERSION=$2

if [ "" = "${VERSION}" ]; then
VERSION="v1.0"
fi


BUILD_PATH="./build"

echo -e "start clear build path"
BIZ_NAME="Core"
BIZ_FOLDER="core"
BUILD_HOME=`pwd`
export buildFolder="Core"

if [ "ios" = "${PLATFORM}" ]; then
OUTPUT_PATH="../CBYRNDemo/CBYRNDemo/RNResources/${BIZ_FOLDER}"
else
OUTPUT_PATH="../androidDemo/app/src/main/assets/bundle/${BIZ_FOLDER}"
fi

#OUTPUT_PATH="./build/${BIZ_FOLDER}"

echo -e "rm -rf ${OUTPUT_PATH}"
rm -rf "${OUTPUT_PATH}"

mkdir -p  "${OUTPUT_PATH}"
mkdir -p "${BUILD_PATH}"


react-native bundle --config ./core.config.js  --entry-file ./indexCore.js --platform ${PLATFORM} --dev false --bundle-output ${OUTPUT_PATH}/${BIZ_FOLDER}.${PLATFORM}.js  --assets-dest ${OUTPUT_PATH}

time=$(date "+%Y%m%d%H%M%S")

bundle="{
           \"bundleName\":\"Core\",
           \"version\":\"${VERSION}-${time}\",
           \"entry\": \"src/pages/${BIZ_NAME}/index.js\"
       }"

echo $bundle > "${OUTPUT_PATH}/bundle.json"


cd ${OUTPUT_PATH}/../

zip -r ${BIZ_NAME}-${VERSION}-${time}-${PLATFORM}.zip ./${BIZ_FOLDER}



cd ${BUILD_HOME}

pwd

mv ${OUTPUT_PATH}/../${BIZ_NAME}-${VERSION}-${time}-${PLATFORM}.zip ${BUILD_PATH}


unset buildFolder
