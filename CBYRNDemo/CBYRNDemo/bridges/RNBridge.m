//
//  RNBridge.m
//  CBYRNDemo
//
//  Created by 崔本勇 on 2020/3/20.
//  Copyright © 2020 Eric. All rights reserved.
//

#import "RNBridge.h"
#import "RNBridgeManager.h"
#import "RCTViewController.h"
#import "RNBizConfig.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "Toast.h"
@implementation RNBridge
RCT_EXPORT_MODULE(RNBridge)

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

// 注册事件
- (NSArray<NSArray *> *)supportedEvents
{
    return @[
             ];
}

RCT_EXPORT_METHOD(loadBundleSuccess:(NSString*)bundleName){
    if ([bundleName isEqualToString:@"Core"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CoreHasBeenLoaded" object:nil];
        [RNBridgeManager loadJSBundle:@"Home" done:^(NSString * _Nonnull url) {
            
        }];
    }
}



RCT_EXPORT_METHOD(startPage:(NSString*)bundleName defalutRoute:(NSString*)defaultRoute param:(NSDictionary*)params){
        [RNBridgeManager loadJSBundle:bundleName done:^(NSString * _Nonnull url) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIViewController *controller = [RNBridge getCurrentViewController];
                if (controller == nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                          RNBizConfig *config = [[RNBizConfig alloc] initWithBundleName:bundleName defaultRoute:defaultRoute initialProps:params];
                          RCTViewController *rn = [[RCTViewController alloc] initWithInitialParams:config];
                          [((AppDelegate *)[UIApplication sharedApplication].delegate).nav pushViewController:rn animated:YES];
                      });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        RNBizConfig *config = [[RNBizConfig alloc] initWithBundleName:bundleName defaultRoute:defaultRoute initialProps:params];
                        RCTViewController *rn = [[RCTViewController alloc] initWithInitialParams:config];
                        rn.modalPresentationStyle = UIModalPresentationFullScreen;
                        [RNBridgeManager getManager].loginVC = rn;
                        [controller presentViewController:rn animated:YES completion:^{

                        }];
                    });
                }

            });
         }];
}




RCT_EXPORT_METHOD(presentPage:(NSString*)bundleName defalutRoute:(NSString*)defaultRoute param:(NSDictionary*)params){
        [RNBridgeManager loadJSBundle:bundleName done:^(NSString * _Nonnull url) {
         dispatch_async(dispatch_get_main_queue(), ^{
             RNBizConfig *config = [[RNBizConfig alloc] initWithBundleName:bundleName defaultRoute:defaultRoute initialProps:params];
             RCTViewController *rn = [[RCTViewController alloc] initWithInitialParams:config];
             rn.modalPresentationStyle = UIModalPresentationFullScreen;
             [RNBridgeManager getManager].loginVC = rn;
             [((AppDelegate *)[UIApplication sharedApplication].delegate).nav presentViewController:rn animated:YES completion:^{

             }];
         });
         }];
}



RCT_EXPORT_METHOD(dismissCurrentVC){
    dispatch_async(dispatch_get_main_queue(), ^{
         UIViewController *controller = [RNBridge getCurrentViewController];
           if (controller.navigationController != nil) {
          [((AppDelegate *)[UIApplication sharedApplication].delegate).nav popViewControllerAnimated:YES];
           }else{
               [controller dismissViewControllerAnimated:YES completion:nil];
           }
    });
}



RCT_EXPORT_METHOD(popNativeNavigation){
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *controller = [RNBridge getCurrentViewController];
         if (controller == nil) {
        [((AppDelegate *)[UIApplication sharedApplication].delegate).nav popViewControllerAnimated:YES];
         }else{
             [controller dismissViewControllerAnimated:YES completion:nil];
         }
    });
}


RCT_EXPORT_METHOD(getHttpCacheSize:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    resolve(@([httpCache currentDiskUsage]));
}

RCT_EXPORT_METHOD(clearCache:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)
{
    NSURLCache *httpCache = [NSURLCache sharedURLCache];
    [httpCache removeAllCachedResponses];
    resolve(nil);
}

RCT_EXPORT_METHOD(setPanGesture:(BOOL)enable){
    dispatch_async(dispatch_get_main_queue(), ^{
        //获取当前显示的navigationController 然后根据RN那边传过来的canswipe参数决定是否禁止侧滑返回
        ((AppDelegate *)[UIApplication sharedApplication].delegate).nav.isPanBackGestureEnable = enable;
    });
}


RCT_EXPORT_METHOD(showLoading:(NSString*)string){
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
        [SVProgressHUD showWithStatus:string];
    });
}


RCT_EXPORT_METHOD(dismissLoading){
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

RCT_EXPORT_METHOD(showToast:(NSString*)string){
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window makeToast:string duration:3 position:CSToastPositionCenter];
    });
}

RCT_EXPORT_METHOD(getBundleVersions:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    NSArray * array = [RNBridgeManager bundleVersions];
    if (array) {
        resolve(array);
    }else{
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:-1 userInfo:nil];
        reject(@"-1", @"error",error);
    }
}

RCT_EXPORT_METHOD(getAppVersion:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    resolve(app_Version);
}

RCT_EXPORT_METHOD(openAppStore){
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *urlstr = @"https://itunes.apple.com/app/apple-store/id111?mt=8";
        NSURL *url = [NSURL URLWithString:urlstr];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
            //设备系统为IOS 10.0或者以上的
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }else{
            //设备系统为IOS 10.0以下的
            [[UIApplication sharedApplication] openURL:url];
        }
        
    });
}

RCT_EXPORT_METHOD(exitApp){
    dispatch_async(dispatch_get_main_queue(), ^{
        exit(0);
    });
}

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return 前屏幕显示的viewcontroller
 */
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
        return topVC;
    }
    return nil;
}


@end
