import {getStatusBarHeight} from "react-native-iphone-x-helper";

/***
 *
 * @type {string}
 */
export const ERROR_MESSAGE = "加载失败，请重试";
export const SMS_SEND_FAIL_MESSAGE = "发送失败，请重试";
export const SMS_SEND_SUCCESS_MESSAGE = "发送成功";
export const MIN_PAGE = 1;
export const MIN_SMS_SEND_TIME = 120000;
export const PAGE_LIMIT = 10;
export const HEADER_HEIGHT = getStatusBarHeight(false) + 44



export const CHECK_RNBUNDLE_UPDATE = `http://192.168.43.10:8000/api/hotupdate/checkAllUpdate`;
// export const CHECK_RNBUNDLE_UPDATE = `http://server.natappfree.cc:34636/api/hotupdate/checkAllUpdate`;
