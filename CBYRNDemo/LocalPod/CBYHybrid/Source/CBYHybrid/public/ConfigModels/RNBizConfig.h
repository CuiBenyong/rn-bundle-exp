//
//  RNBizConfig.h
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNBizConfig : NSObject
/**
 业务包名称
 */
@property (nonatomic, strong) NSString *bundleName;
/**
 入口名称
 */
@property (nonatomic, strong) NSString *defaultRoute;

/**
 初始化参数
 */
@property (nonatomic, strong) NSDictionary *initialProps;

/***
 @name 初始化
 @param bundleName 业务包k名称
 @param defaultRoute 默认入口名称
 @param initialProps 初始化参数
 */
- (instancetype)initWithBundleName:(NSString*)bundleName defaultRoute:(NSString *)defaultRoute initialProps:(NSDictionary*)initialProps;

/**
 @name 获取配置好的参数字典
 @return 参数字典
 **/
- (NSDictionary *)getInitialPropsDict;

@end

NS_ASSUME_NONNULL_END
