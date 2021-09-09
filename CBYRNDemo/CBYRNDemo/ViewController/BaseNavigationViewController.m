//
//  BaseNavigationViewController.m
//  CBYRNDemo
//
//  Created by cuibenyong on 2020/4/13.
//  Copyright © 2020 Eric. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationViewController

#pragma mark - system framwork
- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - property
- (void)setIsPanBackGestureEnable:(BOOL)isPanBackGestureEnable {
    _isPanBackGestureEnable = isPanBackGestureEnable;
    self.interactivePopGestureRecognizer.enabled = _isPanBackGestureEnable;
}

#pragma mark - UIGestureRecognizerDelegate
// 手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL isShould = NO;
    if ( (self.childViewControllers.count<=1) ) {
        isShould = NO;
    }else {
        isShould = YES;
    }
    return isShould;
}

@end
