import { StyleSheet } from 'react-native';
import {Predefine} from "../../../../component/predefine";

export default StyleSheet.create({
    container:{
        backgroundColor: "#F6F6F6"
    },
    walletBg:{
        marginHorizontal: 15,
        marginTop: 10,
        width: (Predefine.screenWidth - 30),
        height: (Predefine.screenWidth - 30) * (68 / 172.5),

        paddingLeft: 25,
        paddingRight: 17,
        paddingTop: 18,
        paddingBottom: 13,
        backgroundColor: 'red'
    },
    account:{
        fontSize: 18,
        fontWeight: '600',
        color:"#fff"
    },
    moneyContainer:{
        flexDirection: 'row',
        marginTop: 34,
        alignItems: 'center'
    },
    vLine:{
        width: 3,
        height: 14,
        backgroundColor: "#fff",
    },
    money:{
        fontSize: 14,
        color:"#fff",
        marginLeft: 4
    },
    recipButton:{
        width: 87,
        height: 28,
        backgroundColor: "#fff",
        alignItems: 'center',
        justifyContent: 'center',
        borderRadius: 4,

        position: 'absolute',
        right: 15,
        bottom: 15
    },
    recipText:{
        fontSize: 15,
        color:"#FF7E7E"
    },
    accountDetail:{
        marginHorizontal: 15,
        marginTop: 10,
        padding: 15,
        backgroundColor: "#fff",

        borderRadius: 4
    },
    icon:{
        width: 15,
        height: 15
    },
    detailContainer:{
        flexDirection: 'row',

    },
    title:{
        fontSize: 16,
        color:"#4D69D8",
        marginLeft: 10,
        fontWeight: '600'
    },
    itemContainer:{
        height: 66,
        justifyContent: 'center'
    },
    firstLine:{
        flexDirection: 'row',
        justifyContent: 'space-between'
    },
    remark:{
        fontSize: 14,
        color:"#030303",
        maxWidth: (Predefine.screenWidth * (2/3) - 30)
    },
    rmoney:{
        fontSize: 15,
        color:"#ff3535",
        maxWidth: Predefine.screenWidth * (1/3)
    },
    createTime:{
        fontSize: 14,
        color:"#b9b9b9",
        marginTop: 8
    },
    loading:{
        height: Predefine.screenWidth,
        alignItems: 'center',
        justifyContent: 'center'
    },
    wechatIcon:{
        width: 24,
        height: 24
    },
    paySelect:{
        flexDirection: 'row',
        paddingVertical: 14,
        alignItems: 'center',
        paddingHorizontal: 15,
        backgroundColor: "#fff"
    },
    wechatText:{
        fontSize: 16,
        color:"#010101",
        marginLeft: 10,
        flex:1
    },
    rightArrow:{
        width: 6,
        height: 12
    },
    withdraw:{
        fontSize: 18,
        color:"#000"
    },
    withdrawContent:{
        padding: 15,
        marginTop: 15,
        backgroundColor: "#fff"
    },
    withdrawMoney:{
        flexDirection: 'row',
        paddingVertical: 15,
        alignItems: 'center'
    },
    withdrawIcon:{
        fontSize: 18,
        color:"#000"
    },
    withdrawInput:{
        fontSize: 18,
        color:"#000",
        flex:1,
        marginLeft: 15
    },
    notice:{
        flexDirection:'row',
        justifyContent: 'space-between'
    },
    noticeText:{
       fontSize: 14,
       color:"#c0c0c0"
    },

    bottomButton:{
        marginHorizontal: 15,
        height: 41,
        backgroundColor: "#4d69d8",
        justifyContent: 'center',
        alignItems: 'center',
        flexDirection: 'row',
        marginVertical: 38
    },
    bottomButtonText:{
        fontSize: 15,
        color:"#fff",
        fontWeight: '600'
    },
    bankContainer:{
        backgroundColor: "#fff",
        marginTop: 10,
        paddingHorizontal: 15,
        paddingTop: 15
    },
    bankCardIcon:{
        width: 36,
        height: 36
    },
    inputs: {
        marginTop: 10,
        paddingHorizontal: 15,
        paddingVertical: 16,
        backgroundColor: "#fff"
    },
    inputContainer:{
        flexDirection: 'row',
        // paddingHorizontal: 27,
        alignItems: 'center',
        height: 52,
        backgroundColor: '#fff',
        justifyContent:'space-between',
        borderBottomWidth: 0.5,
        borderBottomColor: "#f6f6f6"
    },
    inputTitle:{
        flex:1,
        fontSize:15,
        color:"#010101"
    },
    inputStyle:{
        flex: 3,
        textAlign: 'right',
        color:"#C0C0C0"
    },
    payCodeTitle:{
        marginTop: 10
    },
    payCode:{
        width: 200,
        height: 200,
    }
})
