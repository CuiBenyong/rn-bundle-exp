//
//  AppDelegate.m
//  CBYRNDemo
//
//  Created by Eric on 2020/3/19.
//  Copyright © 2020 Eric. All rights reserved.
//

#import "AppDelegate.h"
#import "RNBridgeManager.h"

#import "CBYDebugBridge.h"
#import "RNBridgeManager.h"
#import <React/RCTRootView.h>
#import <react_native_splash_screen/RNSplashScreen.h>  // here
#import "LoadingViewController.h"
#import <React/RCTLinkingManager.h>

#import <react_native_orientation/Orientation.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initRNEnvWithOptions:launchOptions];
    
    self.nav = (BaseNavigationViewController *)self.window.rootViewController;
    return YES;
}

- (void)initRNEnvWithOptions:(NSDictionary *)lauchOptions{
  
  NSString *pubUrl = [RNBridgeManager getBundleUrl:@"Core"];
  NSURL *jsCodeLocation = [NSURL URLWithString:pubUrl];
#if DEBUG
    [CBYDebugBridge setDefaultUrl:jsCodeLocation];
    jsCodeLocation = [CBYDebugBridge getLoadUrl];
#endif
    [RNBridgeManager initWithLaunchOptions:lauchOptions jsLocationUrl:jsCodeLocation];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  return [Orientation getOrientation];
}

@end
