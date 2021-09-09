//
//  CBYRNVCLifeCycleDelegate.h
//  CBYHybrid
//
//  Created by cuibenyong on 2018/5/31.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBYRNVCLifeCycleDelegate <NSObject>

@optional
/*****
 CBYRNViewController viewWillAppear时调用
****/
- (void)rnViewWillAppear:(BOOL)animated;
/*****
 CBYRNViewController viewDidAppear时调用
 ****/
- (void)rnViewDidAppear:(BOOL)animated;
/*****
 CBYRNViewController viewWillDisappear时调用
 ****/
- (void)rnViewWillDisappear:(BOOL)animated;
/*****
 CBYRNViewController viewDidDisappear时调用
 ****/
- (void)rnViewDidDisappear:(BOOL)animated;
/*****
 CBYRNViewController dealloc时调用
 ****/
- (void)rnViewDealloc;

@end

