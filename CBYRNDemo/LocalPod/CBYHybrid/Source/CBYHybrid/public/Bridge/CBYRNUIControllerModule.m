//
//  CBYHybridNativeUIControllerModule.m
//  CBYHybrid
//
//  Created by cuibenyong on 2018/6/1.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "CBYRNUIControllerModule.h"
#import "RCTViewController.h"
static CBYHybridNativeUIControllerModule * shareInstance;
@implementation CBYHybridNativeUIControllerModule
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
    return @[];
}
#pragma mark - 退出顶层VC
RCT_EXPORT_METHOD(popNativeNavigation)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nav  = [CBYHybridNativeUIControllerModule getRootNavController];
        if(nav)
        {
            [nav popViewControllerAnimated:YES];
        }
    });
}

#pragma mark - 打开新的RN业务
RCT_EXPORT_METHOD(startReactNaive:(NSString*)biz entry:(NSString*)entry param:(NSDictionary*)param){
    
}

RCT_EXPORT_METHOD(startNative:(NSString*)clzz from:(NSString*)fromBiz){
    
}

+ (UINavigationController *)getRootNavController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UINavigationController *nav =  (UINavigationController *)[(UITabBarController *)rootViewController selectedViewController];
        return nav;
    }
    
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController*)rootViewController;
    }
    
    return rootViewController.navigationController;
}
RCT_EXPORT_METHOD(setShouldAutorotate:(NSString *)address :(BOOL)should){
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CBYRNViewControllerReceiveShouldAutorotat" object:@{@"should":@(should),@"address":address}];
}

//强制旋转
RCT_EXPORT_METHOD(forbitRotatePortraitOrientation){
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
        {
            SEL selector = NSSelectorFromString(@"setOrientation:");
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:[UIDevice currentDevice]];
            NSInteger value = UIInterfaceOrientationPortrait;
            [invocation setArgument:&value atIndex:2];
            [invocation invoke];
        }
    });
}

//判断是否为当前VC
RCT_EXPORT_METHOD(isCurrentActivity:(NSString *)address callback:(RCTResponseSenderBlock)callback){

}


+ (CBYHybridNativeUIControllerModule*)getInstance{
    return shareInstance;
}
@end
