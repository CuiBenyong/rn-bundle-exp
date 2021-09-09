//
//  FirstViewController.m
//  CBYRNDemo
//
//  Created by cuibenyong on 2020/3/19.
//  Copyright © 2020 cyb. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    self.mConfig = [[RNBizConfig alloc] initWithBundleName:@"Home" defaultRoute:@"Home" initialProps:@{}];
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (NSString *)getMainComponentName{
    return @"Home";
}


@end
