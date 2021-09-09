import React from 'react';
import 'react-native-gesture-handler';
import {UIManager, Text, TextInput} from "react-native";
import SplashScreen from "react-native-splash-screen";
import {applyMiddleware, createStore} from "redux";
import reducers from "./src/reducers";
import thunk from 'redux-thunk';
TextInput.defaultProps = Object.assign({}, TextInput.defaultProps, {allowFontScaling: false})
Text.defaultProps = Object.assign({}, Text.defaultProps, {allowFontScaling: false})
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
require('./src/pages/Home');
require('./src/pages/Mine');
require('./src/pages/Setting');


global.userStore = createStore(reducers, applyMiddleware(thunk));
SplashScreen.hide();
