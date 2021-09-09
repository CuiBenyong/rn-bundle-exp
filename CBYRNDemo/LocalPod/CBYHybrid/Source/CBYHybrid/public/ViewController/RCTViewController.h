//
//  RCTViewController.h
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import <UIKit/UIKit.h>
#import "RNBizConfig.h"
#import "RNBridgeManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface RCTViewController : UIViewController
@property (nonatomic, assign) BOOL mShouldAutorotate;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, strong)  RNBizConfig *mConfig;
- (instancetype) initWithInitialParams:(RNBizConfig *)config;

/// 设备接入模块 RN 试图控制器统一接口
- (instancetype)initWithDictionary:(NSDictionary *)dict;

- (NSString *)getMainComponentName;

-(NSString *)getNowTimeTimestamp;
@end

NS_ASSUME_NONNULL_END
