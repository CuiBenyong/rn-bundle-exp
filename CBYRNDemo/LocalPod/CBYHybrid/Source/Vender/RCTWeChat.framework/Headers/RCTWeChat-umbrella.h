#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RCTWeChat.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"

FOUNDATION_EXPORT double RCTWeChatVersionNumber;
FOUNDATION_EXPORT const unsigned char RCTWeChatVersionString[];

