import { Dimensions } from 'react-native';
import {getStatusBarHeight} from "react-native-iphone-x-helper";

export const Predefine = {
    screenInset:{

    },
    screenWidth:Dimensions.get('window').width,
    screenHeight:Dimensions.get('window').height,
    RSS:{
        flexDirection: 'row'
    },
    RCB:{
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    RCC:{
        flexDirection: 'row',
        justifyContent: 'center',
    }
}

export const HeaderHeight =  getStatusBarHeight(false) + 44
