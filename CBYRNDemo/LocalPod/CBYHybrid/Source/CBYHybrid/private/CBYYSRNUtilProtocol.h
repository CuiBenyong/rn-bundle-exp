//
//  YSRNModuleProtocol.h
//  Pods
//
//  Created by zhaowen5 on 2018/5/17.
//

#import <Foundation/Foundation.h>

typedef void (^RNBundleRejectBlock)(NSString *code, NSString *message, NSError *error);

@class CBYYSRNBundleJson, CBYYSRNPackJson;

@protocol CBYYSRNUtilProtocol <NSObject>

+(BOOL)isBundleNotEnable:(NSString *)name;

+(void)removePackageWhenFirstUpdateApp;

+(CBYYSRNBundleJson *)getBundleCodeLocationWithBundleName:(NSString *)name forRNLoading:(BOOL)forRNLoading rejectBlock:(RNBundleRejectBlock)rejectBlock;
//+(void)removeBundleFolder:(NSString *)bundleName;
//
//+(CBYYSRNBundleJson *)bundleJsonInDocumentWithBundleName:(NSString *)bundleName;
//+(void)writeJson:(CBYYSRNBundleJson *)model inDocumentWithBundleName:(NSString *)bundleName;
//
//+(CBYYSRNBundleJson *)bundleJsonInAppWithBundleName:(NSString *)bundleName;
//
//+(CBYYSRNPackJson *)packageVersion;
//
//+(void)removeAllFileInFolder:(NSString *)folderPath;
//
//// 获取当前App使用的所哟RN模块的信息字典
//+ (NSDictionary<NSString*, CBYYSRNBundleJson*> *)getCurrentUsingBundleJSONDict;



#pragma mark - BundleMove
+ (void)removeBundleNamed:(NSString *)bundleName ofDirPath:(NSString *)dirPath;
+ (BOOL)moveBundleNamed:(NSString *)bundleName inDir:(NSString *)inDir toDir:(NSString *)toDir;
+ (void)removeAllFileInFolder:(NSString *)folderPath;

#pragma mark - YSRNBundleJson
// RN模块 bundle.json文件生成对象
+ (CBYYSRNBundleJson *)bundleJsonInAppWithBundleName:(NSString *)bundleName; //（MainBundle）
+ (CBYYSRNBundleJson *)bundleJsonInRNBundleFolderWithBundleName:(NSString *)bundleName; //（更新文件夹）
+ (CBYYSRNBundleJson *)bundleJsonInRNTryBundleFolderWithBundleName:(NSString *)bundleName; //（试运行文件夹）

#pragma mark - jsCodeLocation
+ (NSString *)jsCodeLocationInRNBundleFolder:(CBYYSRNBundleJson *)bundleJson;
+ (NSString *)jsCodeLocationInMainBundle:(CBYYSRNBundleJson *)bundleJson;
+ (NSString *)jsCodeLocationInRNTryBundleFolder:(CBYYSRNBundleJson *)bundleJson;

#pragma mark - Others

+ (void)writeJson:(CBYYSRNBundleJson *)model inRNTryBundleWithBundleName:(NSString *)bundleName;

// 所有RN模块的最大版本信息
+ (NSDictionary<NSString*, CBYYSRNBundleJson*> *)getRNBundleMaxVersionDict;

// 所有RN模块的信息字典
+ (NSDictionary<NSString*, CBYYSRNBundleJson*> *)getCurrentUsingBundleJSONDict;

#pragma mark - DCLog上报
//type 1:下载,2:MD5检验,3:解压,4:覆盖,5:启动（启动失败次数超过阀值）
+ (void)addRNDCLogWithBundleName:(NSString *)bundleName version:(NSString *)version type:(NSNumber *)type;


@end
