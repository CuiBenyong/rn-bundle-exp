import { NativeModules } from 'react-native';
export function startPage(bundleName,defaultRoute,params) {
    NativeModules.RNBridge.startPage(bundleName,defaultRoute,params)
}

export function presentPage(bundleName,defaultRoute,params) {
    NativeModules.RNBridge.presentPage(bundleName,defaultRoute,params)
}

export function dismissCurrentVC() {
    NativeModules.RNBridge.dismissCurrentVC()
}

export function showToast(msg) {
    NativeModules.RNBridge.showToast(msg)
}

export function isMobile(mobile) {
    const reg =/^0?1[3|4|5|6|7|8|9][0-9]\d{8}$/
    return reg.test(mobile)
}


export function showLoading(msg) {
    // EasyLoading.show(msg||'Loading...', 3000);
    NativeModules.RNBridge.showLoading(msg||'正在加载...')
}

export function dismissLoading() {
    NativeModules.RNBridge.dismissLoading()
}


export function timestampFormat( dateString ) {
    function zeroize( num ) {
        return (String(num).length == 1 ? '0' : '') + num;
    }
    const timestamp =( new Date(dateString.replace(/-/g, '/')).getTime() ) / 1000
    const curTimestamp = parseInt(new Date().getTime() / 1000); //当前时间戳
    const timestampDiff = curTimestamp - timestamp; // 参数时间戳与当前时间戳相差秒数

    const curDate = new Date(curTimestamp * 1000); // 当前时间日期对象
    const tmDate = new Date(timestamp * 1000);  // 参数时间戳转换成的日期对象
    const Y = tmDate.getFullYear(), m = tmDate.getMonth() + 1, d = tmDate.getDate();
    const H = tmDate.getHours(), i = tmDate.getMinutes(), s = tmDate.getSeconds();

    if ( timestampDiff < 60 ) { // 一分钟以内
        return "刚刚";
    } else if( timestampDiff < 3600 ) { // 一小时前之内
        return Math.floor( timestampDiff / 60 ) + "分钟前";
    } else if ( curDate.getFullYear() == Y && curDate.getMonth()+1 == m && curDate.getDate() == d ) {
        return '今天' + zeroize(H) + ':' + zeroize(i);
    } else {
        const newDate = new Date((curTimestamp - 86400) * 1000); // 参数中的时间戳加一天转换成的日期对象
        if ( newDate.getFullYear() == Y && newDate.getMonth()+1 == m && newDate.getDate() == d ) {
            return '昨天' + zeroize(H) + ':' + zeroize(i);
        } else if ( curDate.getFullYear() == Y ) {
            return  zeroize(m) + '月' + zeroize(d) + '日 ' + zeroize(H) + ':' + zeroize(i);
        } else {
            return  Y + '年' + zeroize(m) + '月' + zeroize(d) + '日 ' + zeroize(H) + ':' + zeroize(i);
        }
    }
}


export function trimLeft(s){
    if(s == null) {
        return "";
    }
    var whitespace = new String(" \t\n\r");
    var str = new String(s);
    if (whitespace.indexOf(str.charAt(0)) != -1) {
        var j=0, i = str.length;
        while (j < i && whitespace.indexOf(str.charAt(j)) != -1){
            j++;
        }
        str = str.substring(j, i);
    }
    return str;
}


export function verifyParams(param) {
    for (var key in param) {
        if (param[key] === '' || param[key] === null || param[key] === undefined) {
            delete param[key];
        }
    }

    return param;
}



