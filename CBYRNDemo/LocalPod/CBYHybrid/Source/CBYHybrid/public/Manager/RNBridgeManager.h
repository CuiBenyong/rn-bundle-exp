//
//  RNBridgeManager.h
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import <React/RCTBridge+Private.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^JSCodeLoadedBlock)(NSString *url);
@interface RNBridgeManager : NSObject <RCTBridgeDelegate>

@property (nonatomic, strong) NSURL *jsCodeLocationUrl;

@property (nonatomic, strong) NSMutableArray *loadedBundles;

@property (nonatomic, weak) UIViewController *loginVC;
// 初始化 with server info
+ (void) initWithLaunchOptions:(NSDictionary *)launchOptions jsLocationUrl:(NSURL *)jsCodeLocationUrl;
// 获取Bridge
+ (RCTBridge *) getBridge;
+ (RNBridgeManager *) getManager;
+ (void)loadJSBundle:(NSString *)bundleName done:(JSCodeLoadedBlock)done;
+ (NSString *)getBundleUrl:(NSString *)bundleName;
+ (NSArray *)bundleVersions;
@end

NS_ASSUME_NONNULL_END
