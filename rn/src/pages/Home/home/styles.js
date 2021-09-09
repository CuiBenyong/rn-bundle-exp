/**
 * Created by cuibenyong on 2020/3/21.
 */
import {StyleSheet, Dimensions, Platform} from 'react-native';
import {Predefine} from "../../../../component/predefine";
const {width, height} = Dimensions.get("window");

export default StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },

    headerContainer:{
        flex:1
    },
    splitLine:{
        height: 6,
        backgroundColor:"#F6F6F6"
    },
    viewPager:{
        flex:1
    },

    first:{
        alignItems: 'center',
        justifyContent: 'flex-end',
        width: Predefine.screenWidth,
        height: Predefine.screenHeight
    },

    currentPage:{
        width: 9,
        height: 9,
        borderRadius: 9,

        backgroundColor: "#ff7777",
        marginBottom: 48
    },

    otherPage:{
        width: 9,
        height: 9,
        borderRadius: 9,
        backgroundColor: "#F0F0F0",
        marginBottom: 48
    },
    centerPage:{
        marginHorizontal: 38
    }

})
