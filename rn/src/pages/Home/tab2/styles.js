/**
 * Created by cuibenyong on 2020/3/21.
 */
import {StyleSheet, Dimensions, Platform} from 'react-native';
import {Predefine} from "../../../../component/predefine";
const bannerHeight = 140;
export default StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems:'center',
        justifyContent: 'center'
    },

    headerContainer:{
        flex:1
    },
    splitLine:{
        height: 6,
        backgroundColor:"#F6F6F6"
    },
    slide:{
        width: Predefine.screenWidth,
        height: bannerHeight,
        // backgroundColor: 'red'
    },
    banner:{
        width: Predefine.screenWidth,
        height: bannerHeight,
        position: 'relative',
        // justifyContent: 'flex-start'
    },
    containerCustomStyle:{
        height: bannerHeight,
    },
    contentContainerCustomStyle:{
        height: bannerHeight,
    },
    containerStyle:{
        // position: 'relative'
    },
    paginationContainer:{
        marginTop: 100
    },
    line:{
        height: 10,
        backgroundColor:"#F6F6F6"
    }
})
