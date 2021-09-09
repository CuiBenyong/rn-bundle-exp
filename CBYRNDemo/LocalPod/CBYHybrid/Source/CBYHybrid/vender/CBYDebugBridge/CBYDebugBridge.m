//
//  CBYDebugBridge.m
//  CBYDebugBridge
//
//  Created by aevit on 2017/9/25.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "CBYDebugBridge.h"
#import <React/RCTRootView.h>
#import <React/RCTDevMenu.h>
#import "RNBridgeManager.h"
#include <arpa/inet.h>
#import <React/RCTBridge+Private.h>
#import "RCTViewController.h"
#define SC_DEBUG_IP_PORT   @"__SC_DEBUG_IP_PORT__"
#define EXIT_APP_TO_RELOAD  0

@implementation CBYDebugBridge

RCT_EXPORT_MODULE(SCDebug)

static RCTBridge* bridge;
static NSURL *defaultURL;


- (instancetype)init
{
  if (self = [super init]) {

    bridge = [RNBridgeManager getBridge];
    [self addIpAndPortDevItem];
  }
  return self;
}

#pragma mark - public methods
+ (NSDictionary*)getIpAndPort
{
  NSString *ip = @"";
  NSString *port = @"8081";
  NSString *from = @"default";
    
  NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:SC_DEBUG_IP_PORT];
  if (![CBYDebugBridge isEmptyString:str]) {
    // from userDefault (dev menu)
    NSArray *tmpArr = [str componentsSeparatedByString:@":"];
    ip = tmpArr.count > 0 ? tmpArr[0] : @"";
    port = tmpArr.count > 1 ? tmpArr[1] : @"";
    from = @"menu";
  }
  return @{@"ip": ip, @"port": port, @"from": from};
}

+ (void)setDefaultUrl:(NSURL *)url{
    if (url) {
        defaultURL = url;
    }
}

+ (NSURL *)getLoadUrl{
    #if DEBUG
    NSDictionary *ipAndPort = [CBYDebugBridge getIpAndPort];
    NSString *ip = SAFE_STRING([ipAndPort valueForKey:@"ip"]);
    NSString *port = SAFE_STRING([ipAndPort valueForKey:@"port"]);
     if (![CBYDebugBridge isEmptyString:ip] && ![CBYDebugBridge isEmptyString:port]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/index.bundle?platform=ios&dev=true&minify=false", ipAndPort[@"ip"], ipAndPort[@"port"]]];
     }
    #endif
    return defaultURL;
}

+ (void)setDefaultIp:(NSString *)ip port:(NSString *)port{
#if DEBUG
      NSString *ipAndPortStr = [NSString stringWithFormat:@"%@:%@", ip, port];
      [[NSUserDefaults standardUserDefaults] setObject:ipAndPortStr forKey:SC_DEBUG_IP_PORT];
      [[NSUserDefaults standardUserDefaults] synchronize];
    #if EXIT_APP_TO_RELOAD
      [CBYDebugBridge exitApp];
    #else
      [CBYDebugBridge reloadApp];
    #endif
#endif
}

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

#pragma mark - alert delegate
- (void)alertViewReload:(UIAlertController*)alertView
{
    NSString *ip = alertView.textFields[0].text;//[alertView textFieldAtIndex:0].text;
  NSString *port = alertView.textFields[1].text;

  if ([CBYDebugBridge isEmptyString:ip] || [CBYDebugBridge isEmptyString:port]) {
    // clean saved ip and port
    [CBYDebugBridge removeSavedIpAndPort];
#if EXIT_APP_TO_RELOAD
    [CBYDebugBridge exitApp];
#else
    [CBYDebugBridge reloadLocalScript];
#endif
    return;
  }

  if (![CBYDebugBridge isValidIPAddress:ip]) {
    [CBYDebugBridge showAlertMsg:@"非法ip地址"];
    return;
  }
  if (port.length != 4) {
    [CBYDebugBridge showAlertMsg:@"端口需要4位数"];
    return;
  }
  NSString *ipAndPortStr = [NSString stringWithFormat:@"%@:%@", ip, port];
  [[NSUserDefaults standardUserDefaults] setObject:ipAndPortStr forKey:SC_DEBUG_IP_PORT];
  [[NSUserDefaults standardUserDefaults] synchronize];
#if EXIT_APP_TO_RELOAD
  [CBYDebugBridge exitApp];
#else
  [CBYDebugBridge reloadApp];
#endif
}

#pragma mark - private methods
+ (void)removeSavedIpAndPort
{
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:SC_DEBUG_IP_PORT];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addIpAndPortDevItem
{
  dispatch_async(dispatch_get_main_queue(), ^{
    if (!bridge) {
      return;
    }

      NSDictionary *ipAndPort = [CBYDebugBridge getIpAndPort];
    RCTDevMenuItem *item = [RCTDevMenuItem buttonItemWithTitleBlock:^NSString *{
      return [NSString stringWithFormat:@"修改RN包加载地址"];
    } handler:^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入ip为空时点击'Reload'将加载APP本地包" preferredStyle:UIAlertControllerStyleAlert];
    
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入ip为空时点击'Reload'将加载APP本地包" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reload", nil];
//      [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSString *tip = [SAFE_STRING(ipAndPort[@"ip"]) isEqualToString:@""] ? @"本地" : ipAndPort[@"ip"];
             [textField setText:ipAndPort[@"ip"]];
             [textField setPlaceholder:[NSString stringWithFormat:@"当前加载路径: %@",  tip]];
             [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        }];

        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
               [textField setSecureTextEntry:NO];
               [textField setText:ipAndPort[@"port"]];
                 
             
               [textField setPlaceholder:[NSString stringWithFormat:@"当前端口: %@",  ipAndPort[@"port"]]];
               [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }];
 
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [alert dismiss];
        }];
        
        UIAlertAction *reload = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertViewReload:alert];
        }];
        
        [alert addAction:cancel];
        [alert addAction:reload];
        [[self getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
    }];
    [bridge.devMenu addItem:item];
      
      
      

      
//      [bridge.devMenu addItem:scanQR];
  });
}

- (UIViewController *)getCurrentViewController
{
    UIViewController *result = nil;
    // 获取默认的window
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到它。
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    // 获取window的rootViewController
    result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

+ (BOOL)isValidIPAddress:(NSString*)ipStr
{
  if ([CBYDebugBridge isEmptyString:ipStr]) {
    return NO;
  }
  if ([ipStr isEqualToString:@"localhost"]) {
    return YES;
  }
  const char *utf8 = [ipStr UTF8String];
  int success;

  struct in_addr dst;
  success = inet_pton(AF_INET, utf8, &dst);
  if (success != 1) {
    struct in6_addr dst6;
    success = inet_pton(AF_INET6, utf8, &dst6);
  }

  return success == 1;
}

+ (BOOL)isEmptyString:(NSString*)str
{
  return (!str || [str isEqual:[NSNull null]] || ![str isKindOfClass:[NSString class]] || str.length <= 0);
}

+ (void)showAlertMsg:(NSString*)msg
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

+ (void)reloadApp
{
  NSDictionary *ipAndPort = [CBYDebugBridge getIpAndPort];
  NSURL *jsCodeLocation = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@/index.bundle?platform=ios&dev=true&minify=false", ipAndPort[@"ip"], ipAndPort[@"port"]]];

  bridge.bundleURL = jsCodeLocation;
  [bridge reload];
}

+ (void)reloadLocalScript
{
  NSDictionary *ipAndPort = [CBYDebugBridge getIpAndPort];
  NSURL *jsCodeLocation = defaultURL;

  bridge.bundleURL = jsCodeLocation;
  [bridge reload];
}

+ (void)exitApp
{
  UIWindow *window = [UIApplication sharedApplication].delegate.window;
  [UIView animateWithDuration:0.3f animations:^{
    window.transform = CGAffineTransformMakeScale(1.0, 1 / [UIScreen mainScreen].bounds.size.height);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5f animations:^{
      window.transform = CGAffineTransformMakeScale(1 / [UIScreen mainScreen].bounds.size.width, 1 / [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
      exit(1);
    }];
  }];
}


@end
