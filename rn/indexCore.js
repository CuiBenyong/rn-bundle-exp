import 'react-native-gesture-handler';
import { AppRegistry, NativeModules, Text, TextInput, UIManager, Alert } from 'react-native';
import Orientation from 'react-native-orientation';
import { setCustomSourceTransformer } from 'react-native/Libraries/Image/resolveAssetSource';

console.disableYellowBox = true
for (let k in UIManager) {
  if (UIManager.hasOwnProperty(k) && UIManager[k] && UIManager[k].directEventTypes) {
    UIManager[k].directEventTypes.onGestureHandlerEvent = {
      registrationName: "onGestureHandlerEvent"
    };
    UIManager[k].directEventTypes.onGestureHandlerStateChange = {
      registrationName: "onGestureHandlerStateChange"
    };
  }
}
const assetPathUtils = require('react-native/Libraries/Image/assetPathUtils');
TextInput.defaultProps = Object.assign({}, TextInput.defaultProps, { allowFontScaling: false })
Text.defaultProps = Object.assign({}, Text.defaultProps, { allowFontScaling: false })

const definedBizModules = {};               // 当前已加载业务与模块关联表
global.___definedBizModules = definedBizModules;

const initDefine = global.__d;


const initRunApplication = AppRegistry.runApplication;
const initUnmountApplicationComponentAtRootTag = AppRegistry.unmountApplicationComponentAtRootTag;

AppRegistry.runApplication = (appKey, appParameters) => {
  const { rootTag, initialProps: { bundleName, bundleUrl, entry } } = appParameters;
  definedBizModules[rootTag] = { entry, prefix: `src/pages/${bundleName}/` };
  new SourceTransformer(bundleUrl, bundleName)
  initRunApplication(appKey, appParameters);
}



AppRegistry.unmountApplicationComponentAtRootTag = (rootTag) => {
  initUnmountApplicationComponentAtRootTag(rootTag);

  const { entry, prefix } = definedBizModules[rootTag];
  console.log('unmount', entry)
  global.__destroyModules(entry, prefix)
}


class SourceTransformer {
  constructor(bizScriptURL, bizName) {
    setCustomSourceTransformer(function (resolver) {
      const assetObj = resolver.defaultAsset();
      const { scriptURL } = NativeModules.SourceCode;
      const { asset, jsbundleUrl } = resolver;
      const { httpServerLocation } = asset;
      let folderName = httpServerLocation.split('/')[1].toLowerCase()
      if (folderName === 'assets') {
        folderName = 'core'
      }
      if (Platform.OS === 'ios') {
        const bizAssetURL = jsbundleUrl.substr(0, (jsbundleUrl.length - `/core/`.length));
        if (!scriptURL.startsWith('http') && !!bizName) {
          const fileName = `${httpServerLocation}/${asset.name}`.replace(/^\//, '');
          assetObj.uri = `${bizAssetURL}/${folderName}/${fileName}.${asset.type}`;
        }
      } else if (Platform.OS === 'android') {
        const bizAssetURL = scriptURL.substr(0, (scriptURL.length - `/core/`.length));
        console.log(assetObj, bizScriptURL, scriptURL, jsbundleUrl)
        if (!scriptURL.startsWith('http')) {
          const { scale } = assetObj;
          const drawbleFolder = assetPathUtils.getAndroidResourceFolderName(asset, scale);
          const fileName = assetPathUtils.getAndroidResourceIdentifier(asset);
          assetObj.uri = `assets://bundle/${folderName}/${drawbleFolder}/${fileName}.${asset.type}`.replace('assets://', 'asset:///');
        }
      }
      // console.log('------->>>>>', assetObj.uri)
      return assetObj;
    });
  }
}

const oldHandler = global.ErrorUtils.getGlobalHandler();
global.ErrorUtils.setGlobalHandler((error, isFatal) => {
  if (!__DEV__) {
    Alert.alert(
      '提示',
      `出错了：${error instanceof Object ? error.message : '未错误'}`,
      [
        { text: 'Cancel', onPress: () => console.log('Cancel Pressed'), style: 'cancel' },
        { text: 'OK', onPress: () => console.log('OK Pressed') },
      ],
      { cancelable: false }
    )
  } else {
    oldHandler(error, isFatal)
  }
});

() => {
  require('./src/pages/Home');
  require('./src/pages/Mine');
  require('./src/pages/Setting');
}

Orientation.lockToPortrait();
NativeModules.RNBridge.loadBundleSuccess("Core")
