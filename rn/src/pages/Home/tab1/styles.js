/**
 * Created by cuibenyong on 2020/3/21.
 */
import {StyleSheet, Dimensions, Platform} from 'react-native';
import {getBottomSpace} from "react-native-iphone-x-helper";
import {Predefine} from "../../../../component/predefine";
const {width, height} = Dimensions.get("window");

export default StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
        alignItems:'center',
        justifyContent: 'center'
    },
    slide:{
        width: width - 30,
        height: 122
    },
    banner:{
        width: width,
        height: 122,
        position: 'relative',
        justifyContent: 'flex-start'
    },
    containerCustomStyle:{
        height: 122,
    },
    contentContainerCustomStyle:{
        height: 122,
    },
    containerStyle:{
        // position: 'relative'
    },
    paginationContainer:{
        marginTop: 100
    },
    leftContainer:{
        flex:1,
        width
    }  ,
    rightContainer:{
        flex:1,
        width
    },
    line:{
        height: 2,
        backgroundColor:"#F6F6F6"
    },
    bottomContainer: {
        height: 49 + getBottomSpace(),
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: 15,
        borderTopColor: "#F5F5F5",
        borderTopWidth: 1,
        width: Predefine.screenWidth
    },
    section: {
        // flex:1
    },
    textInput: {
        backgroundColor: "#f0f0f0",
        height: 34,
        borderRadius: 4,
        flex: 1,
        paddingHorizontal: 15,
        fontSize: 16,
        paddingVertical: 0,
        width
    },
    buttons: {
        marginLeft: 20,
        width: 22,
        height: 22
    },
    sendContainer:{
        width: 55,
        height: 34,
        borderRadius: 2,
        backgroundColor:"#4d69d8",
        justifyContent: 'center',
        alignItems: 'center',
        marginLeft: 16
    },
    sendText:{
        fontSize: 15,
        color:"#fff"

    },
    publishButton:{
        width: 76,
        height: 76,
        position: "absolute",
        right: 9,
        bottom: 9
    },  publishIcon:{
        width: 76,
        height: 76,
    },
    headerLeftText:{
        marginLeft: 15,
        fontSize: 15,
        color:"#fff",
        fontWeight: '600'
    },
    headerRightText:{
        marginRight: 15,
        fontSize: 15,
        color:"#fff",
        fontWeight: '600'
    },
    textView:{
        padding: 15,
        height: 150,
        backgroundColor: '#fff',
        textAlignVertical: 'top',
        paddingTop: 15,
        fontSize:16
    },
    imageContainer:{
        flexDirection: 'row',
        flexWrap: 'wrap',
        paddingHorizontal: 15,
        marginTop: 15

    },
    itemContainer:{
        width: 100,
        height: 100,
        backgroundColor:'#fff',
        marginRight: 15

    },
    images:{
        width: 90,
        height: 90,
        marginTop: 10
    },
    close:{
        width: 20,
        height: 20,
        position: 'absolute',
        top: 0,
        right: 0
    }

})
