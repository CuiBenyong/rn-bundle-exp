//
//  CBYHybridNativeNotificationModule.m
//  CBYHybrid
//
//  Created by cuibenyong on 2018/6/1.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "CBYRNNotificationModule.h"

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

static CBYHybridNativeNotificationModule *shareInstance;
@implementation CBYHybridNativeNotificationModule
RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}


- (instancetype)init{
    if (self = [super init]) {
        shareInstance = self;
    }
    return self;
}
#pragma mark - JS端注册事件
- (NSArray<NSArray *> *) supportedEvents
{
    NSString *plist = [[NSBundle mainBundle] pathForResource:@"RNExportEvent" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:plist];
    return array;
}

+ (CBYHybridNativeNotificationModule *)getInstance{
    return shareInstance;
}

#pragma mark -- private 
- (void)startObserving
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(emitEventInternal:)
                                                 name:@"event-emitted"
                                               object:nil];
}
- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emitEventInternal:(NSNotification *)notification
{
    NSDictionary *noti = notification.object;
    NSString *type = noti[@"type"];
    id args = noti[@"args"];
    
    [self sendEventWithName:type
                       body:@{@"data":args}];
}

+ (void)postNotiToReactNative:(NSString *)messageName args:(id)args{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = messageName;
    dic[@"args"] = args;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"event-emitted" object:dic];
}


@end
