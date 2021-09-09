//
//  BaseViewController.m
//  CBYRNDemo
//
//  Created by 崔本勇 on 2020/3/19.
//  Copyright © 2020 Eric. All rights reserved.
//

#import "BaseViewController.h"
#import "CBYDebugBridge.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (!self.isLoaded) {
        NSURL* jsCodeLocation = [CBYDebugBridge getLoadUrl];
        if (![jsCodeLocation.absoluteString containsString:@"http"]) {
                  dispatch_async(dispatch_get_global_queue(0, 0), ^{
                                  while (![[RNBridgeManager getManager].loadedBundles containsObject:self.mConfig.bundleName]) {//侦听common加载完成
                                  }
                            [self loaded];
                    });
        }else{
                          [self loadViews:nil];
        }
  
    }
}

- (void)loaded{
    
    NSURL* jsCodeLocation = [CBYDebugBridge getLoadUrl];
    if (![jsCodeLocation.absoluteString containsString:@"http"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *bizUrl = [RNBridgeManager getBundleUrl:[self getMainComponentName]];
            [self loadViews:bizUrl];
                                               });
    }
    
     
}

- (void)loadViews:(NSString *)bizUrl{
    NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:[self.mConfig getInitialPropsDict]];
                                              [mParams setValue:[self getNowTimeTimestamp] forKey:@"timeStart"];
                                              [mParams setValue:[NSString stringWithFormat:@"%p",self] forKey:@"Address"];
                                              [mParams setValue:bizUrl forKey:@"bundleUrl"];
    
    NSString *url = [RNBridgeManager getBundleUrl:[self getMainComponentName]];
    NSString *bundleName = [NSString stringWithFormat:@"%@.ios.js", [self.mConfig.bundleName lowercaseString]];
    NSString *bundle = [url stringByReplacingOccurrencesOfString:bundleName withString:@"bundle.json"];
    
    NSURL *bundleUrl=[NSURL fileURLWithPath:bundle];
     NSData *data = [[NSData alloc] initWithContentsOfURL:bundleUrl];
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     NSLog(@"%@",dic);
    [mParams addEntriesFromDictionary:dic];
    [mParams setValue:url forKey:@"bundleUrl"];
    
    
    
    
                                            RCTRootView *rootView =  [[RCTRootView alloc] initWithBridge:[RNBridgeManager getBridge]
                                                                                                       moduleName: [self getMainComponentName]
                                                                                                initialProperties:mParams];
                                             self.view = rootView;
                                           self.isLoaded = YES;
}

- (void)loadedNotification{
        self.isLoaded = YES;
        [self loaded];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
