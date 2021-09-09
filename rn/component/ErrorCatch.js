import React, { Component } from 'react';
import { TouchableOpacity, View, Text, NativeModules } from 'react-native';
import { ScrollView, SafeAreaView } from 'react-native';
const parseErrorStack = require('react-native/Libraries/Core/Devtools/parseErrorStack');
const ErrorCatch = (Comp) => {
  return class Catcher extends Component {
    constructor(props) {
      super(props)
      this.state = {
        showError: false
      }

      const ErrorUtils = global.ErrorUtils;
      const oldHandler = ErrorUtils.getGlobalHandler();
      if (!global.__fbDisableExceptionsManager) {
        const handleError = (e, isFatal) => {
          try {
            this.parseError(e, isFatal);
            !__DEV__ && oldHandler(e, isFatal);
          } catch (ee) {
            console.log('Failed to print error: ', ee.message);
          }
        };
        ErrorUtils.setGlobalHandler(handleError);
      }

    }

    componentDidCatch(e, info) {
      this.parseError(e, true)
    }


    parseError(e, isFatal) {

      const stack = parseErrorStack(e);
      const message =
        e.jsEngine == null ? e.message : `${e.message}, js engine: ${e.jsEngine}`;
      const msg = message.split('\n\n')
      console.log(stack, message, msg);
      this.setState({
        showError: true,
        stack,
        message,
        msg: msg[0]
      })
      //TODO: report Error 

    }

    render() {
      const { showError, message, stack } = this.state;
      if (showError) {
        return <SafeAreaView style={{ flex: 1 }}>
          <ScrollView>
            <Text style={{marginHorizontal: 15, lineHeight: 20, fontSize: 18, fontWeight: '600', color:'red'}}>{message}</Text>
            {
              stack.map(item => {
                const { file, methodName, arguments:args, lineNumber, column } = item;
                return <View style={{ paddingVertical: 10, paddingHorizontal: 15 }}>
                  <Text>文件： {file}</Text>
                  <Text>行号： {lineNumber}</Text>
                  <Text>列号： {column}</Text>
                  <Text>方法名： {methodName}</Text>
                  <Text>参数： {JSON.stringify(args)}</Text>
                </View>
              })
            }
          </ScrollView>
          <TouchableOpacity style={{height: 36, backgroundColor:'gray', borderRadius: 18, alignItems:'center', justifyContent: 'center', marginHorizontal: 15}} onPress={() => {
            NativeModules.RNBridge.popNativeNavigation();
          }}><Text style={{fontSize: 16, color:"#fff"}}>退出页面</Text></TouchableOpacity>

        </SafeAreaView>
      }
      return <Comp {...this.props} />
    }
  }
}

export default ErrorCatch;