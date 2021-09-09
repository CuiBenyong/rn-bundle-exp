//
//  CBYDebugBridge.h
//  CBYDebugBridge
//
//  Created by aevit on 2017/9/25.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface CBYDebugBridge : NSObject <RCTBridgeModule>

#ifdef DEBUG
#define CBYHYBRID_DEBUG 1

#else
#define CBYHYBRID_DEBUG 0
#endif

/**
获取IP 和 端口
 
 @return eg: @{@"ip": @"127.0.0.1", @"port": @"8081"}
 */
+ (NSDictionary*)getIpAndPort;

/**
        
 */
+ (void)setDefaultUrl:(NSURL *)url;

+ (void)setDefaultIp:(NSString *)ip port:(NSString *)port;

+ (BOOL)requiresMainQueueSetup;

+ (NSURL *)getLoadUrl;

@end
