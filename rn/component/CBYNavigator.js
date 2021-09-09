/**
 * Created by cuibenyong on 2020/3/19.
 */

'use strict';

import React, {Component} from 'react';
import {NativeModules, Platform, View} from 'react-native';
import NavigatorHeaderLeft from './HeaderLeft';
import NavigatorHeaderRight from './HeaderRight';
import {createAppContainer, NavigationActions,} from 'react-navigation';
import {createStackNavigator, TransitionPresets} from 'react-navigation-stack';
import CHeader from "./QHeader";

export {
    NavigatorHeaderLeft,
    NavigatorHeaderRight,
}

export default class CBYNavigator extends Component {
    constructor(props) {
        super(props);
        // ios header 配置
        let navigationOptionsIOS = {
            headerMode:'screen',
            headerBackTitle: null,
            headerStyle: {
                backgroundColor: '#fff'
            },
            headerTitleStyle: {
                fontWeight: 'normal',
                fontSize: 17,
                color: '#333'
            },
            header:({scene,previous, navigation})=>{
                const { options } = scene.descriptor;
                const title =
                    options.headerTitle !== undefined
                        ? options.headerTitle
                        : options.title !== undefined
                        ? options.title
                        : scene.route.routeName;
                const headerLeft =
                    options.headerLeft !== undefined
                        ? options.headerLeft
                        : undefined
                const headerRight =
                    options.headerRight !== undefined
                        ? options.headerRight
                        : undefined
                return (
                    <CHeader
                        navigation={navigation}
                        title={title}
                        LeftButton={headerLeft}
                        RightButton={headerRight}
                        {...options}
                    />
                )
            }
        };
        this.StackNavigatorConfig = {
            // headerMode: 'float',
            navigationOptions: navigationOptionsIOS,
            defaultNavigationOptions: navigationOptionsIOS
        };

        if (Platform.OS === 'android') {
            let navigationOptionsAndroid = {
                headerStyle: {
                    height: 44,
                    shadowColor: 'rgba(0, 0, 0, 0)',
                    shadowOpacity: 0,
                    shadowRadius: 0,
                    shadowOffset: {height: 0},
                    elevation: 0,
                    backgroundColor: '#fff',
                    borderColor: '#ccc',
                    borderStyle: 'solid',
                    borderBottomWidth: 0.5,
                },
                headerTitleStyle: {
                    fontSize: 17,
                    color: '#333',
                },
                headerTitleAlign:'center',
                headerRight: <View style={{width: 50, height: 44}}/>,
                ...TransitionPresets.SlideFromRightIOS,
                headerMode: 'float',
                header:({scene,previous, navigation})=>{
                    const { options } = scene.descriptor;
                    const title =
                        options.headerTitle !== undefined
                            ? options.headerTitle
                            : options.title !== undefined
                            ? options.title
                            : scene.route.routeName;
                    const headerLeft =
                        options.headerLeft !== undefined
                            ? options.headerLeft
                            : undefined
                    const headerRight =
                        options.headerRight !== undefined
                            ? options.headerRight
                            : undefined
                    return (
                        <CHeader
                            navigation={navigation}
                            title={title}
                            LeftButton={headerLeft}
                            RightButton={headerRight}
                            {...options}
                        />
                    )
                }
            };
            this.StackNavigatorConfig = {
                headerMode: 'screen',
                navigationOptions: navigationOptionsAndroid,
                defaultNavigationOptions: navigationOptionsAndroid,

            }
        }
        ;

        const {routes, defaultRoute,} = props;

        if (defaultRoute) {
            this.StackNavigatorConfig.initialRouteName = defaultRoute;
        }

        const ezGetStateForAction = (getStateForAction) => (action, state) => {
            const {type, routeName,} = action;

            // 跳转到底直接退出
            if (type === NavigationActions.BACK && state.index <= 0) {
                NativeModules.RNBridge.popNativeNavigation();
            }

            // 阻止快速点击重复跳转
            let isDuplicate = false;
            if (state && state.routes[state.routes.length - 1].routeName === routeName && type === NavigationActions.NAVIGATE) {
                isDuplicate = true;
                return null;
            }
            return getStateForAction(action, state);
        };

        this.NavigatorComponent = createAppContainer(createStackNavigator(routes, this.StackNavigatorConfig));
        this.NavigatorComponent.router.getStateForAction = ezGetStateForAction(this.NavigatorComponent.router.getStateForAction);
    }


    render() {
        const {NavigatorComponent} = this;
        const {onRef, onNavigationStateChange, routes, ...params} = this.props;
        return (
            <NavigatorComponent
                {...params}
                ref={nav => {
                    onRef && onRef(nav);
                    this.nav = nav
                }}
                onNavigationStateChange={(prevState, newState, action) => {
                    console.log(prevState, newState, action)
                    if (Platform.OS === 'ios'){
                        if (newState.index <= 0){
                            NativeModules.RNBridge.setPanGesture(true)
                        } else{
                            NativeModules.RNBridge.setPanGesture(false)
                        }
                    }
                    onNavigationStateChange && onNavigationStateChange(prevState, newState, action)
                }
                }/>
        )
    }
}
