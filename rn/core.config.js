/**
 * Metro configuration for React Native
 * https://github.com/facebook/react-native
 *
 * @format
 */

const pathSep = require('path').sep;
function createModuleIdFactory() {
  const projectRootPath = __dirname;//获取命令行执行的目录，__dirname是nodejs提供的变量
  return path => {
    let name = '';
    if(path.indexOf('node_modules'+pathSep+'react-native'+pathSep+'Libraries'+pathSep)>0){
      name = path.substr(path.lastIndexOf(pathSep)+1);//这里是去除路径中的'node_modules/react-native/Libraries/‘之前（包括）的字符串，可以减少包大小，可有可无
    }else if(path.indexOf(projectRootPath)==0){
      name = path.substr(projectRootPath.length+1);//这里是取相对路径，不这么弄的话就会打出_user_smallnew_works_....这么长的路径，还会把计算机名打进去
    }
    // name = name.replace('.js','$js');//js png字符串没必要打进去
    // name = name.replace('.png','$png');
    // let regExp = pathSep=='\\'?new RegExp('\\\\',"gm"):new RegExp(pathSep,"gm");
    // name = name.replace(regExp,'_');//把path中的/换成下划线
    return name;
  };
}

function processModuleFilter(module){
  if ( module.path.indexOf('/src/actions') > -1
      ||module.path.indexOf('/src/reducers') > -1
  ){
    return true;
  }
  if (
         module.path.indexOf('node_modules') > -1
      || module.path.indexOf('/rn/utils') > -1
      || module.path.indexOf('redux') > -1
      || module.path.indexOf('/rn/indexCore.js') > -1
      || module.path.indexOf('/rn/component') > -1
      || module.path.indexOf('private_modules') > -1
  ){
    return true;
  }

  if (module.path.indexOf('package.json') > -1 ){
    return true;
  }
  return false;
}

function getRunModuleStatement(entryFilePath){
  console.log("entry point",entryFilePath)
  return `__r('indexCore.js')`
}

module.exports = {
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: false,
      },
    }),
  },
  serializer: {
    createModuleIdFactory:createModuleIdFactory,
    processModuleFilter:processModuleFilter,
    getRunModuleStatement:getRunModuleStatement
    /* serializer options */
  }
};
