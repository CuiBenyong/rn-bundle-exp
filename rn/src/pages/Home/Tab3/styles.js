import { StyleSheet } from 'react-native';
import {Predefine} from "../../../../component/predefine";
export const NavHeight = Predefine.screenWidth * (210 / 375);
export default StyleSheet.create({
    container:{
        flex:1,
        backgroundColor: '#F8F8F8',
        alignItems:'center',
        justifyContent: 'center'
    },

    topBg:{
        width: '100%',
        height: Predefine.screenWidth * (210 / 375)
    },
    scrollView:{
        backgroundColor: 'transparent',
        flex: 1
    },
    containerStyle:{
        alignItems: 'center',
        paddingBottom: 80
    }
})