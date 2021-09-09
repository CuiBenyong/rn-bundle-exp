import React, { Component } from 'react';
import { AppRegistry, DeviceEventEmitter, StatusBar, View } from 'react-native';
import { connect, Provider } from 'react-redux';
import CBYNavigator from '../../../component/CBYNavigator';
import EditMobile from "./editMobile";
import UserInformation from "./information";
import Wallet from "./wallet";
import ErrorCache from '../../../component/ErrorCatch';

export class AppBase extends Component {
    constructor(props) {
        super(props);
        this.elements = [];

    }

    componentDidMount() {
        this.setListener = DeviceEventEmitter.addListener('setElement', (id, element, callback) => {
            this.elements.push({id, element});
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

        StatusBar.setTranslucent(false);
    }

    componentWillUnmount() {
        this.setListener  &&  this.setListener.remove()
        this.removeListener&& this.removeListener.remove()
    }

    render() {
        const {defaultRoute, orderStatus, showJump, param} = this.props;
        const elements = this.elements.map(obj => obj.element);

        return (
            <View style={{flex: 1}}>
                <StatusBar backgroundColor="transparent" translucent/>
                <CBYNavigator
                    routes={{
                        Index: {screen: UserInformation},
                        EditMobile: {screen: EditMobile},
                        Wallet: {screen: Wallet},
                    }}
                    defaultRoute={defaultRoute}
                />
                {
                    elements
                }
            </View>
        );
    }
}


const mapStateToProps = ({base}) => ({});

const mapDispatchToProps = (dispatch) => {
    return {
    };
};

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


AppRegistry.registerComponent('Mine', () => ErrorCache(App), false);
