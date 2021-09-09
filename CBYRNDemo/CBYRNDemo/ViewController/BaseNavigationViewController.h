//
//  BaseNavigationViewController.h
//  CBYRNDemo
//
//  Created by cuibenyong on 2020/4/13.
//  Copyright © 2020 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationViewController : UINavigationController
//是否开启滑动退场
@property(nonatomic, assign)BOOL isPanBackGestureEnable;

@end

NS_ASSUME_NONNULL_END
