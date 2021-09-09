import React, {PureComponent} from 'react';
import {Animated, StyleSheet, Text, TouchableOpacity, View} from 'react-native';
import RootView from '../../utils/modal';
import {Predefine} from "../../component/predefine";
import {getBottomSpace} from "react-native-iphone-x-helper";

export default class ActionSheet extends PureComponent {
    static ids = [];
    constructor(props){
        super(props)
        this.state = {
            marginBottom: new Animated.Value(Predefine.screenHeight),
        }
    }



    static show(buttons){
        if (!!this.last && (Date.now() - this.last < 500)) return;
        this.last = Date.now();
        this.id = RootView.set(<ActionSheet
            key={'ActionSheet'}
            buttons={buttons}
        />)
        this.ids.push(this.id)
    }

    static close() {
        !!this.id && RootView.remove(this.id);
        this.id = this.ids.length>0 ? this.ids.pop() : null;
    }

    static isShow(){
        return !!this.id;
    }

    componentDidMount() {
        // Animated
        Animated.timing(this.state.marginBottom, {
            toValue: 0,
            velocity: 2,//初始速度
            friction: 1,//摩擦力值
            duration: 200,//
            useNativeDriver: true
        }).start();
    }

    closeAnimated(cb){
        Animated.timing(this.state.marginBottom, {
            toValue: Predefine.screenHeight,
            velocity: 2,//初始速度
            friction: 1,//摩擦力值
            duration: 200,//
            useNativeDriver: true
        }).start((finish)=>{
            cb()
        });
    }


    onClosePress() {
        this.closeAnimated(() => {
            ActionSheet.close();
        })
    }

    render() {
        const { marginBottom } = this.state;
        const {buttons}  = this.props;
        return (
            <View style={styles.background}>
                <TouchableOpacity  activeOpacity={0.9}  style={styles.onClose} onPress={()=>this.onClosePress()}/>
                <Animated.View style={[styles.view,{transform: [{translateY: marginBottom}]}]}>
                    {
                        buttons.map((obj,index)=>{
                            const {title, onPress} = obj;
                            return (
                                <TouchableOpacity  activeOpacity={0.9}  style={styles.actionItems} onPress={()=>{
                                    this.onClosePress();
                                    onPress()
                                }} key={`action_sheet_key_${index}`}>
                                    <Text style={styles.actionTitle}>{title}</Text>
                                </TouchableOpacity>
                            )
                        })
                    }
                    <TouchableOpacity  activeOpacity={0.9}  style={[styles.actionItems,{marginBottom: getBottomSpace()}]} onPress={()=>{
                        this.onClosePress();
                    }} key={`action_sheet_key_cancel`}>
                        <Text style={styles.actionTitle}>取消</Text>
                    </TouchableOpacity>
                </Animated.View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    background: {
        backgroundColor: 'rgba(0,0,0,0.7)',
        justifyContent: 'flex-end',
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
    },
    container: {
        flex: 1,
    },
    view:{
        backgroundColor: '#F6F6F6',
    },
    actionItems:{
        height: 49,
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#fff',
        marginBottom: 10
    },
    actionTitle:{
        fontSize: 18,
        color:"#000"
    },
    onClose:{
        flex:1,
        backgroundColor:'transparent'
    }
});
