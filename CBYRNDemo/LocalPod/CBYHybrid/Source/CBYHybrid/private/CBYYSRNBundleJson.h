//
//  YSRNBundleJson.h
//  VideoGo
//
//  Created by zhaowen5 on 2018/5/25.
//  Copyright © 2018年 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 每个RN包下的bundle.json里的信息
 */
@interface CBYYSRNBundleJson : NSObject
//服务端返回的信息
@property(nonatomic,copy)   NSString *name;
@property(nonatomic,copy)   NSString *version;
@property(nonatomic,copy)   NSString *fileName;
@property(nonatomic,copy)   NSString *fileMD5;
@property(nonatomic,copy)   NSString *entryName;
@property(nonatomic,assign) NSInteger isDisable;//RN是否禁用
@property(nonatomic,copy)   NSString *pjtVersion;
@property(nonatomic,copy)   NSString *pubVersion;
// 动态追加数据
@property(nonatomic,copy)   NSString *builtInVersion;
//客户端自己生成的数据
@property(nonatomic,assign) NSInteger status;   //启动状态      0：初始值；1：第一次启动（还未有结果）；2：至少启动成功过一次。
@property(nonatomic,assign) NSInteger errCount; //启动错误次数
@property(nonatomic,copy)   NSString  *jsCodePath; //作为返回参数，临时赋值中转使用，并不存储
@property(nonatomic, strong) NSDictionary *jsonData;
+ (CBYYSRNBundleJson *)CBYYSRNBundleJsonWithDictionary:(NSDictionary *)dict;
- (NSString *)mj_JSONString;
@end

/*
 RN基本目录下的pack.json信息，（以app版本为单位的更新package信息）
 */
@interface CBYYSRNPackJson : NSObject

@property(nonatomic,copy)   NSString *version;

+ (CBYYSRNPackJson *)CBYYSRNPackJsonWithDictionary:(NSDictionary *)dict;
@end
