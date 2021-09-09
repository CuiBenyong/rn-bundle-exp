#!/bin/sh
BIZ_NAME=$1
PLATFORM=$2

VERSION=$3

if [ "" = "${VERSION}" ]; then
VERSION="v1.0"
fi

BUILD_PATH="./build"

BUILD_HOME=`pwd`

echo -e "start clear build path"
export buildFolder=$BIZ_NAME
BIZ_FOLDER=`echo "print '$BIZ_NAME'.lower()" | python`

if [ "ios" = "${PLATFORM}" ]; then
OUTPUT_PATH="../CBYRNDemo/CBYRNDemo/RNResources/${BIZ_FOLDER}"
else
OUTPUT_PATH="../androidDemo/app/src/main/assets/bundle/${BIZ_FOLDER}"
fi
#OUTPUT_PATH="./build/${BIZ_FOLDER}"
rm -rf "${OUTPUT_PATH}"

mkdir -p  "${OUTPUT_PATH}"
mkdir -p "${BUILD_PATH}"



echo "react-native bundle --config ./biz.config.js  --entry-file ./src/pages/${BIZ_NAME}/index.js --platform ${PLATFORM} --dev false --bundle-output ./build/${PLATFORM}/${BIZ_NAME}/${BIZ_NAME}.${PLATFORM}.js --sourcemap-output ./build/${PLATFORM}/${BIZ_NAME}/${BIZ_NAME}.${PLATFORM}.map --assets-dest ${OUTPUT_PATH}"
react-native bundle --config ./biz.config.js  --entry-file ./src/pages/${BIZ_NAME}/index.js --platform ${PLATFORM} --dev false --bundle-output ${OUTPUT_PATH}/${BIZ_FOLDER}.${PLATFORM}.js --assets-dest ${OUTPUT_PATH}


time=$(date "+%Y%m%d%H%M%S")
bundle="{
           \"bundleName\":\"${BIZ_NAME}\",
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
