//
//  CBYHybridNativeNotificationModule.h
//  CBYHybrid
//
//  Created by cuibenyong on 2018/6/1.
//  Copyright © 2018年 eric. All rights reserved.
//
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "RNBridgeManager.h"

@interface CBYHybridNativeNotificationModule :  RCTEventEmitter <RCTBridgeModule>
+ (CBYHybridNativeNotificationModule *)getInstance;
+ (void)postNotiToReactNative:(NSString *)messageName args:(id)args;
@end
