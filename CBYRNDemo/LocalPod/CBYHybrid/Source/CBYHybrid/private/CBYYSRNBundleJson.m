//
//  YSRNBundleJson.m
//  VideoGo
//
//  Created by zhaowen5 on 2018/5/25.
//  Copyright © 2018年 hikvision. All rights reserved.
//

#import  "CBYYSRNBundleJson.h"

@implementation CBYYSRNBundleJson
+ (CBYYSRNBundleJson *)CBYYSRNBundleJsonWithDictionary:(NSDictionary *)dict{
    CBYYSRNBundleJson *model = [CBYYSRNBundleJson new];
    model.name = dict[@"name"];
    model.version = dict[@"version"];
    model.fileName = dict[@"fileName"];
    model.fileMD5 = dict[@"fileMD5"];
    model.entryName = dict[@"entryName"];
    model.pjtVersion = dict[@"pjtVersion"];
    model.pubVersion = dict[@"pubVersion"];
    model.isDisable = [[dict valueForKey:@"isDisable"] integerValue];
    model.status = [[dict valueForKey:@"status"] integerValue];
    model.errCount = [[dict valueForKey:@"errCount"] integerValue];
    model.jsCodePath = [dict valueForKey:@"jsCodePath"];
    model.jsonData = dict;
    return model;
}

#pragma mark - 转换为JSON
- (NSData *)mj_JSONData
{
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }
    
    return [NSJSONSerialization dataWithJSONObject:[self mj_JSONObject] options:kNilOptions error:nil];
}

- (id)mj_JSONObject
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.jsonData];
    [dict setValue:@(self.status) forKey:@"status"];
    [dict setValue:@(self.errCount) forKey:@"errCount"];
    [dict setValue:@(self.isDisable) forKey:@"isDisable"];
    return dict;
}

- (NSString *)mj_JSONString
{
    return [[NSString alloc] initWithData:[self mj_JSONData] encoding:NSUTF8StringEncoding];
}

@end

@implementation CBYYSRNPackJson
//@property(nonatomic,copy)   NSString *version;

+ (CBYYSRNPackJson *)CBYYSRNPackJsonWithDictionary:(NSDictionary *)dict{
    CBYYSRNPackJson *model = [CBYYSRNPackJson new];
    model.version = [dict valueForKey:@"version"];
    return model;
}
@end
