import { StyleSheet } from 'react-native';
export default StyleSheet.create({
    container:{
        flex:1,
    },
    content:{
        backgroundColor: '#fff'

    },
    item:{
        height: 52,
        flexDirection: 'row',
        padding: 15,
        alignItems: 'center',
        justifyContent: 'space-between',
        backgroundColor: '#fff'
    },
    title:{
        fontSize: 15,
        color:"#434343"
    },
    rightArrow:{
        width: 16,
        height: 16
    },
    line:{
        marginLeft: 15,
        height: 1,
        backgroundColor: "#f6f6f6"
    },
    logoutButton:{
        marginHorizontal: 15,
        height: 41,
        backgroundColor: "#4f69d8",
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 100
    },
    logoutText:{
        fontSize: 15,
        color:"#fff",
        fontWeight: '600'
    }
})