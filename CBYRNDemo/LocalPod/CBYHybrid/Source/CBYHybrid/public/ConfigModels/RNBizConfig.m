//
//  RNBizConfig.m
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import "RNBizConfig.h"

@implementation RNBizConfig
- (instancetype)initWithBundleName:(NSString*)bundleName defaultRoute:(NSString *)defaultRoute initialProps:(NSDictionary*)initialProps{
    if (self = [super init]) {
        self.bundleName = bundleName;
        self.defaultRoute = defaultRoute;
        self.initialProps = initialProps;
    }
    return self;
}

- (NSDictionary *)getInitialPropsDict{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:self.initialProps];
    [dictionary setValue:self.bundleName forKey:@"bundleName"];
    [dictionary setValue:self.defaultRoute forKey:@"defaultRoute"];
    return [dictionary copy];
}

@end
