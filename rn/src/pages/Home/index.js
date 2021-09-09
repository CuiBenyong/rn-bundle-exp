import React, { Component } from 'react';
import {
  AppRegistry,
  BackHandler,
  DeviceEventEmitter,
  Image, NativeModules,
  Platform,
  StatusBar, View
} from 'react-native';
import SplashScreen from "react-native-splash-screen";
import { createAppContainer } from 'react-navigation';
import { createBottomTabNavigator } from 'react-navigation-tabs';
import { connect, Provider } from 'react-redux';
import { applyMiddleware, createStore } from 'redux';
import thunk from 'redux-thunk';
import { showToast } from "../../../utils/fn";
import reducers from '../../reducers';
import Tab1 from './tab1/index';
import Home from './home/index';
import Tab3 from './Tab3/index';
import Tab2 from './tab2/index';



const homeSel = require('../../images/tab_home_sel.png')
const homeNor = require('../../images/tab_home.png')

const circleSel = require('../../images/tab_circle_sel.png')
const circleNor = require('../../images/tab_circle.png')

const shopSel = require('../../images/tab_shop_sel.png')
const shopNor = require('../../images/tab_shop.png')

const mineSel = require('../../images/tab_mine_sel.png')
const mineNor = require('../../images/tab_mine.png')

global.isIOS = Platform.OS === 'ios'
const routes = {
  Home: {
    screen: Home,
    navigationOptions: ({ navigation }) => ({
      tabBarLabel: "首页",
      tabBarIcon: ({ tintColor, focused }) => (
        <Image
          source={focused ? homeSel : homeNor}
          style={{ width: 22, height: 22 }}
        />
      ),
      tabBarOnPress: (tab) => {
        tab.defaultHandler();
        StatusBar.setBarStyle('light-content', true)
      }

    })
  },
  Tab1: {
    screen: Tab1,
    navigationOptions: ({ navigation }) => {
      DeviceEventEmitter.emit("GET_MY_TAB_NAVIGATION", navigation)
      const showBadgeIcon = navigation.getParam('showBadgeIcon', false)
      console.log('changed show badge icon ', showBadgeIcon)
      return {
        tabBarLabel: "Tab1",
        tabBarIcon: ({ tintColor, focused }) => (
          <View style={{ width: 35, height: 27, alignItems: 'center' }}>
            <Image
              source={focused ? circleSel : circleNor}
              style={{ width: 22, height: 22, marginTop: 2.5 }}
            />
            {!!showBadgeIcon && <View style={{ width: 6, height: 6, backgroundColor: "#FF3535", borderRadius: 3, position: 'absolute', top: 0, right: 0 }} />}
          </View>
        ),
        tabBarOnPress: (tab) => {
          tab.defaultHandler();
          StatusBar.setBarStyle('dark-content', true)
        }
      }
    }
  },
  Tab2: {
    screen: Tab2,
    navigationOptions: ({ navigation }) => ({
      tabBarLabel: "Tab2",
      tabBarIcon: ({ tintColor, focused }) => (
        <Image
          source={focused ? shopSel : shopNor}
          style={{ width: 21, height: 21 }}
        />
      ),
      tabBarOnPress: (tab) => {
        tab.defaultHandler();
        StatusBar.setBarStyle('dark-content', true)
      }
    })
  },
  Tab3: {
    screen: Tab3,
    navigationOptions: ({ navigation }) => ({
      tabBarLabel: "Tab3",
      tabBarIcon: ({ tintColor, focused }) => (
        <Image
          source={focused ? mineSel : mineNor}
          style={{ width: 19, height: 22 }}
        />
      ),
      tabBarOnPress: (tab) => {
        tab.defaultHandler();
        StatusBar.setBarStyle('light-content', true)
      }
    })
  },
};


const tabBarConfig = {
  tabBarOptions: {
    showIcon: true,            // 是否显示选项卡的图标
    activeTintColor: '#FF7E7E', // 选中时状态颜色
    inactiveTintColor: '#8E8E93', // 未选中状态颜色
    labelStyle: {              // 选项卡标签的样式对象
      fontSize: 10,
    },
    style: {                   // 选项卡栏的样式对象
      backgroundColor: '#fff',
    },
    swipeEnabled: false,//标签之间进行滑动
    animationEnabled: true,
    lazy: false,// 是否懒加载
    keyboardHidesTabBar: false

  },
  lazy: false,// 是否懒加载
  backBehavior: 'none',
}

const TabRoutes = createBottomTabNavigator(routes, tabBarConfig)
const AppContainer = createAppContainer(TabRoutes)

export class AppBase extends Component {
  constructor(props) {
    super(props);
    this.elements = [];
    this.lastTimer = Date.now();
    this.pressCount = 0;

    this.state = {
      position: 0,
    };

  }

  handleBackPress = () => {
    if (this.active) {
      if (this.lastTimer && this.lastTimer + 2000 >= Date.now()) {
        //在2秒内按过back返回，可以退出应用
        console.log('退出退出')
        NativeModules.RNBridge.exitApp()
        return false;
      }
      this.lastTimer = Date.now();
      showToast('再按一次退出应用')
      return true;
    }
    return false;
  }

  componentDidMount() {
    BackHandler.addEventListener('hardwareBackPress', this.handleBackPress)
    this.setListener = DeviceEventEmitter.addListener('setElement', (id, element, callback) => {
      this.elements.push({ id, element });
      this.forceUpdate(callback);
    });
    this.removeListener = DeviceEventEmitter.addListener('removeElement', (id = null, callback) => {
      if (typeof id === 'number') {
        const elements = this.elements;
        for (let i = 0, len = elements.length; i < len; i++) {
          if (elements[i].id === id) {
            elements.splice(i, 1);
            break;
          }
        }
      } else {
        this.elements = [];
      }
      this.forceUpdate(callback);
    });
    SplashScreen.hide();
  }


  componentWillUnmount() {
    BackHandler.removeEventListener('hardwareBackPress', this.handleBackPress)
  }


  render() {
    const elements = this.elements.map(obj => obj.element);
    return (
      <View style={{ flex: 1 }}>
        <StatusBar backgroundColor="transparent" translucent />
        <AppContainer />
        {
          elements
        }
      </View>
    );
  }
}


const mapStateToProps = ({ base }) => ({});

const mapDispatchToProps = (dispatch) => {
  return {

  };
};
global.userStore = createStore(reducers, applyMiddleware(thunk));

const ConnectAppBase = connect(mapStateToProps, mapDispatchToProps)(AppBase);


export default class App extends Component {

  render() {
    return (
      <Provider store={global.userStore}>
        <ConnectAppBase {...this.props} />
      </Provider>
    );
  }
}


AppRegistry.registerComponent('Home', () => App, false);

NativeModules.RNBridge.loadBundleSuccess("Home")
