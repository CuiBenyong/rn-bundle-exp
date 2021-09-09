import React, {PureComponent} from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import {getStatusBarHeight} from 'react-native-iphone-x-helper';
import HeaderLeft from './HeaderLeft';

export default class CHeader extends PureComponent{
    constructor(props){
        super(props)
    }

    render(){
        const { headerHeight, navigation, onPress,title, LeftButton, RightButton, height } = this.props;
        return (
            <LinearGradient
                style={[styles.container]}
                colors={['#FF4E4E', '#FF8F8F']}
                start={{x: 0, y: 1}}
                end={{x: 1, y: 1}}
            >
                {
                    !!LeftButton ? <LeftButton/>:   <HeaderLeft onPress={()=>onPress ? onPress() : navigation.goBack()}/>

                }

            <Text style={styles.title} numberOfLines={1}>{title}</Text>

                {
                    !!RightButton ? <RightButton/> : <View style={{width:40}}/>
                }

            </LinearGradient>

        )
    }
}
const styles = StyleSheet.create({
    container:{
        flexDirection: 'row',
        paddingTop: getStatusBarHeight(true),
        alignItems: 'center',
        height:getStatusBarHeight(true) + 44
    },
    title:{
        fontSize: 16,
        color:"#fff",
        fontWeight:'600',
        flex:1,
        textAlign: 'center',
        marginHorizontal: 8
    }
});
