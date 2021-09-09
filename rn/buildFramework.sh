#!/bin/sh
CONFIGURATION=$1
BUILD=$2
START=`date +%s`
BUILD_RN=$3

if [ "" = "${BUILD}" ]; then
	BUILD="iphone"  #simulator
fi

if [ "" = "${CONFIGURATION}" ]; then
	CONFIGURATION="Release" #Debug
fi

if [ "" = "${BUILD_RN}" ]; then
	BUILD_RN=1
fi

BUILD_DIR=`pwd`/DerivedData/EZHybrid/Build/Products
BUILD_ROOT=`pwd`/DerivedData/EZHybrid/Build/Products

REACT_FRAMEWORK_ROOT=`pwd`/EZHybrid/ReactLib/frameworks
PROJECT_DIR=`pwd`

rm -rf "${REACT_FRAMEWORK_ROOT}/*"
echo -e 'y\n'


echo "rm -rf ${PROJECT_DIR}/Products/Debug/*"
rm -rf ${PROJECT_DIR}/Products/Debug/*
echo -e 'y\n'

echo "rm -rf ${PROJECT_DIR}/Products/Release/*"

rm -rf ${PROJECT_DIR}/Products/Release/*

echo -e 'y\n'


mkdir -p "${PROJECT_DIR}/Products/Debug/RN"
mkdir -p "${PROJECT_DIR}/Products/Release/RN"


if [ "${BUILD_RN}" -eq 1 ]; then
pwd
cd ${PROJECT_DIR}

#yarn install

cd ${PROJECT_DIR}/ios

#pod install --no-repo-update

reactFrameworks=( "React-Core/React.framework" "React-CoreModules/CoreModules.framework" "React-cxxreact/cxxreact.framework" "React-jsi/jsi.framework" "React-jsiexecutor/jsireact.framework" "React-jsinspector/jsinspector.framework" "React-RCTActionSheet/RCTActionSheet.framework" "React-RCTAnimation/RCTAnimation.framework" "React-RCTBlob/RCTBlob.framework" "React-RCTImage/RCTImage.framework" "React-RCTLinking/RCTLinking.framework" "React-RCTNetwork/RCTNetwork.framework" "React-RCTSettings/RCTSettings.framework" "React-RCTText/RCTText.framework" "React-RCTVibration/RCTVibration.framework" "ReactCommon/ReactCommon.framework" "Yoga/yoga.framework" "FBReactNativeSpec/FBReactNativeSpec.framework" "RCTSystemSetting/RCTSystemSetting.framework" "RCTTypeSafety/RCTTypeSafety.framework" "DoubleConversion/DoubleConversion.framework" "glog/glog.framework" "Folly/folly.framework" "ReactNativeART/ReactNativeART.framework" "RNCAsyncStorage/RNCAsyncStorage.framework" "react-native-cameraroll/react_native_cameraroll.framework" "react-native-viewpager/react_native_viewpager.framework")

thirdPartyFrameworks=( "Picker/Picker.framework" "QBImagePickerController/QBImagePickerController.framework" "react-native-netinfo/react_native_netinfo.framework" "react-native-orientation/react_native_orientation.framework" "react-native-video/react_native_video.framework" "react-native-webview/react_native_webview.framework" "RNGestureHandler/RNGestureHandler.framework" "RNImageCropPicker/RNImageCropPicker.framework" "RNReanimated/RNReanimated.framework" "RSKImageCropper/RSKImageCropper.framework" "react-native-safe-area-context/react_native_safe_area_context.framework" "RNScreens/RNScreens.framework" "RNCMaskedView/RNCMaskedView.framework" "react-native-splash-screen/react_native_splash_screen.framework" "ReactNativeExceptionHandler/ReactNativeExceptionHandler.framework" "RNSVG/RNSVG.framework" "BVLinearGradient/BVLinearGradient.framework" "react-native-video/react_native_video.framework" "react-native-baidu-map/react_native_baidu_map.framework" "RCTWeChat/RCTWeChat.framework" "react-native-background-timer/react_native_background_timer.framework" "react-native-view-shot/react_native_view_shot.framework" "RNDateTimePicker/RNDateTimePicker.framework" "SSZipArchive/SSZipArchive.framework" "RNZipArchive/RNZipArchive.framework" "RNFS/RNFS.framework")

thirdPartyLibs=(  )

if [ simulator = "${BUILD}" -o all = "${BUILD}" ]; then
xcodebuild -workspace "EZRNDependency.xcworkspace" -scheme "EZRNDependency" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

for i in ${thirdPartyLibs[@]};
do
	cp ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$i ${PROJECT_DIR}/EZHybrid/EZHybrid/ReactLib/
done

for j in ${reactFrameworks[@]};
do
#	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$j  ${PROJECT_DIR}/EZHybrid/ReactLib/

	if [ Debug = "${CONFIGURATION}" ]; then
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$i  ${PROJECT_DIR}/Products/Debug/RN/
	else
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$i  ${PROJECT_DIR}/Products/Release/RN/
	fi
done

for j in ${thirdPartyFrameworks[@]};
do
	if [ Debug = "${CONFIGURATION}" ]; then
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$j  ${PROJECT_DIR}/Products/Debug/
	else
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$j  ${PROJECT_DIR}/Products/Release/
	fi
done
fi

if [ iphone = "${BUILD}" -o all = "${BUILD}" ]; then
xcodebuild -workspace "EZRNDependency.xcworkspace" -scheme "EZRNDependency"  ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
for i in ${reactFrameworks[@]};
do
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i ${REACT_FRAMEWORK_ROOT}/

	if [ Debug = "${CONFIGURATION}" ]; then
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i  ${PROJECT_DIR}/Products/Debug/RN/
	else
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i  ${PROJECT_DIR}/Products/Release/RN/
	fi

done

for i in ${thirdPartyFrameworks[@]};
do
	if [ Debug = "${CONFIGURATION}" ]; then
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i  ${PROJECT_DIR}/Products/Debug/
	else
	cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i  ${PROJECT_DIR}/Products/Release/
	fi
done

fi

if [ all = "${BUILD}" ]; then
for i in ${thirdPartyLibs[@]};
do
	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/$i" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/$i" -output "${PROJECT_DIR}/EZHybrid/EZHybrid/ReactLib/$i"
done

for j in ${reactFrameworks[@]};
do
	jname=${j#*/}
	#cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/  ${PROJECT_DIR}/EZHybrid/EZHybrid/
#	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${jname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${jname}" -output "${REACT_FRAMEWORK_ROOT}/${j}/${jname}"
	fname=${jname%.*}
	if [ Debug = "${CONFIGURATION}" ]; then
	cmd="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${fname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${fname}" -output "${PROJECT_DIR}/Products/Debug/RN/${j}/${fname}"
	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${fname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${fname}" -output "${PROJECT_DIR}/Products/Debug/RN/${j}/${fname}"
	else
	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${fname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${fname}" -output "${PROJECT_DIR}/Products/Release/RN/${j}/${fname}"
	fi


done

for j in ${thirdPartyFrameworks[@]};
do
	jname=${j#*/}
	#cp -R ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/  ${PROJECT_DIR}/EZHybrid/EZHybrid/
	fname=${jname%.*}
	if [ Debug = "${CONFIGURATION}" ]; then
	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${fname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${fname}" -output "${PROJECT_DIR}/Products/Debug/${j}/${fname}"
	else
	lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${j}/${fname}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${j}/${fname}" -output "${PROJECT_DIR}/Products/Release/${j}/${fname}"
	fi
done
fi
fi

#cd  ${PROJECT_DIR}/EZHybrid
#/Users/cuibenyong/.rbenv/shims/pod install
#if [ simulator = "${BUILD}" -o all = "${BUILD}" ]; then
#xcodebuild -workspace "EZHybrid.xcworkspace" -scheme "EZHybrid" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
#cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/EZHybrid.framework" ${PROJECT_DIR}/
#fi
#
#if [ iphone = "${BUILD}"  -o all = "${BUILD}" ]; then
#xcodebuild -workspace "EZHybrid.xcworkspace" -scheme "EZHybrid" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
#cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/EZHybrid.framework" ${PROJECT_DIR}/
#fi
#
#if [ all = "${BUILD}" ]; then
#cp -R ${BUILD_DIR}/${CONFIGURATION}-iphoneos/EZHybrid.framework ${PROJECT_DIR}/
#lipo -create "${BUILD_DIR}/${CONFIGURATION}-iphoneos/EZHybrid.framework/EZHybrid" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/EZHybrid.framework/EZHybrid" -output "${PROJECT_DIR}/EZHybrid.framework/EZHybrid"
#fi
#
#if [ Debug = "${CONFIGURATION}" ]; then
#rm -rf "${PROJECT_DIR}/Products/Debug/EZHybrid.framework"
#mv 	"${PROJECT_DIR}/EZHybrid.framework" ${PROJECT_DIR}/Products/Debug/
#else
#rm -rf "${PROJECT_DIR}/Products/Release/EZHybrid.framework"
#mv 	"${PROJECT_DIR}/EZHybrid.framework" ${PROJECT_DIR}/Products/Release/
#fi

END=`date +%s`

COAST=`expr ${END} - ${START}`

echo $COAST s
