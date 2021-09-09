//
//  BaseViewController.h
//  CBYRNDemo
//
//  Created by 崔本勇 on 2020/3/19.
//  Copyright © 2020 Eric. All rights reserved.
//

#import "RCTViewController.h"
#import "RCTViewController.h"
#import "RNBizConfig.h"
#import "RNBridgeManager.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : RCTViewController
@property (nonatomic, assign) BOOL isLoaded;
@end

NS_ASSUME_NONNULL_END
