import { StyleSheet } from 'react-native';
import {Predefine} from "../../../../component/predefine";

export default StyleSheet.create({
    container:{
        flex:1,
    },
    inputs: {
        paddingHorizontal: 15,
        // paddingVertical: 16,
        backgroundColor: "#fff"
    },
    inputContainer:{
        flexDirection: 'row',
        // paddingHorizontal: 27,
        alignItems: 'center',
        height: 52,
        backgroundColor: '#fff'
    },
    title:{
        flex:1,
        fontSize:15,
        color:"#010101"
    },
    inputStyle:{
        flex: 3,
        textAlign: 'left'
    },
    vipIcon:{
        width: 25,
        height: 25
    },
    selectItem:{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center'
    },
    downarrow:{
        width: 18,
        height: 18
    },
    itemTitle:{
        fontSize: 16,
        color:"#000",
        marginHorizontal: 10
    },

    items:{
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
        paddingVertical: 15,
    },
    nextButton:{
        height: 41,
        backgroundColor: '#4D69D8',
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 30,
        marginHorizontal: 15
    },
    nextText:{
        fontSize: 15,
        color:"#fff",
        fontWeight: '600'
    },
    line:{
        flexDirection: 'row',
        marginTop: 18,
        alignItems: 'center'
    },
    numberContainer:{
        width: 15,
        height: 15,
        borderRadius: 2,
        backgroundColor: "#ff7f7f",
        justifyContent: 'center',
        alignItems: 'center'
    },
    number:{
        fontSize: 12,
        color:"#fff"
    },
    content:{
        fontSize: 14,
        color:"#000",
        fontWeight: '400',
        marginLeft: 9
    },
    mobile:{
        paddingHorizontal: 15,
        backgroundColor: "#fff",
        marginTop: 10
    },

    getCode: {
        fontSize: 14,
        color: "#FF8C8C",
    },
    getCodeButton: {
        height: '100%',
        justifyContent: 'center',
        position: 'absolute',
        width: 100,
        right: 0,
        top: 0,
        alignItems: 'flex-end'
    },
    idcardContainer:{
        paddingHorizontal: 15,
        paddingVertical: 16,
        backgroundColor: "#fff",
        marginTop: 10
    },
    idcard:{
        width: Predefine.screenWidth - 30,
        height: (Predefine.screenWidth - 30) * (61 / 173.5),
        marginTop: 19,
        marginBottom: 32
    },
    idcardTitle:{
        fontSize: 16,
        color:"#000"
    }
})