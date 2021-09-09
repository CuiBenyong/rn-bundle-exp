//
//  AppDelegate.h
//  CBYRNDemo
//
//  Created by cuibenyong on 2020/3/19.
//  Copyright © 2020 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) BOOL loaded;


@property (nonatomic, weak) BaseNavigationViewController *nav;

@end

