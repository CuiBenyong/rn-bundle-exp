//
//  RNBridgeManager.m
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import "RNBridgeManager.h"
#import "ReactExecuteScript.h"
#import "CBYDebugBridge.h"

static RCTBridge *gRCTBridge = nil;
static RNBridgeManager *gRNBridgeManager = nil;
@implementation RNBridgeManager
+ (void) initWithLaunchOptions:(NSDictionary *)launchOptions jsLocationUrl:(NSURL *)jsCodeLocationUrl{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gRNBridgeManager = [RNBridgeManager new];
        gRNBridgeManager.jsCodeLocationUrl = jsCodeLocationUrl;
        [[NSNotificationCenter defaultCenter] addObserver:gRNBridgeManager selector:@selector(onRNBroadcast:) name:@"RNBroadcast" object:nil];
        gRCTBridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocationUrl moduleProvider:nil launchOptions:launchOptions];
    });
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge{
    return gRNBridgeManager.jsCodeLocationUrl;
}

- (void) onRNBroadcast:(NSNotification *)noti {
  [gRCTBridge enqueueJSCall:@"RCTDeviceEventEmitter"
                      method:@"emit"
                        args:@[@"broadcast", noti.userInfo]
                  completion:NULL];
}


- (void) dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RNBroadcast" object:nil];
}

+ (NSString *)getBundleUrl:(NSString *)bundleName {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *bundleInAppUrl = [mainBundle pathForResource:[NSString stringWithFormat:@"RNResources/%@/%@.ios", [bundleName lowercaseString],[bundleName lowercaseString]] ofType:@"js"];
    NSString *bundleJsonInAppUrl = [mainBundle pathForResource:[NSString stringWithFormat:@"RNResources/%@/bundle", [bundleName lowercaseString],[bundleName lowercaseString]] ofType:@"json"];
    
    NSDictionary *appBundle = [self getJSON:bundleJsonInAppUrl];
    
    NSString *homePath = NSHomeDirectory();

    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString *RNBundlePath = [docuPath stringByAppendingPathComponent:@"RNBundles"];
    
    NSString *bundleInDocumentUrl = [NSString stringWithFormat:@"%@/%@/%@.ios.js", RNBundlePath, [bundleName lowercaseString], [bundleName lowercaseString]];
    
    NSString *bundleJSONInDocumentUrl = [NSString stringWithFormat:@"%@/%@/bundle.json", RNBundlePath, [bundleName lowercaseString]];
    
    NSDirectoryEnumerator *direnmu = [[NSFileManager defaultManager]  enumeratorAtPath:RNBundlePath];
    
    NSMutableArray *files = [NSMutableArray arrayWithCapacity:10];
    
    NSString *fileName;
    while (fileName = [direnmu nextObject]) {
        [files addObject:fileName];
    }
    
    NSLog(@"%@", files);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:bundleInDocumentUrl]) {
            NSDictionary *documentBundle = [self getJSON:bundleJSONInDocumentUrl];
        NSInteger av = [[appBundle valueForKey:@"version"] componentsSeparatedByString:@"-"].lastObject.integerValue;
        NSInteger dv = [[documentBundle valueForKey:@"version"] componentsSeparatedByString:@"-"].lastObject.integerValue;
        BOOL useAppBundle = [self appVersionIsBig:[appBundle valueForKey:@"version"] documentVersion:[documentBundle valueForKey:@"version"]];
        if (av > dv) {
            return bundleInAppUrl;
        }else{
            return bundleInDocumentUrl;
        }
    }
    return bundleInAppUrl;
}

+ (BOOL)appVersionIsBig:(NSString *)appVersion documentVersion:(NSString *)documentVersion{
    NSInteger result = [self compareVersion2:appVersion to:documentVersion];
    return result != -1;
}

+ (NSArray *)bundleVersions{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *bundleInAppUrl = [mainBundle pathForResource:@"RNResources" ofType:@""];
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSError *error;
    NSArray *subpaths = [mgr subpathsOfDirectoryAtPath:bundleInAppUrl error:&error];

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    [subpaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *path = (NSString *)obj;
        BOOL isDir = NO;
        [mgr fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", bundleInAppUrl, path] isDirectory:&isDir];
        if (isDir && ![path containsString:@"/"]) {
            [array addObject:[self getBundleObject:path]];
        }
    }];
        NSLog(@"%@", array);
    return array;
}



+ (NSDictionary *)getBundleObject:(NSString *)bundleName {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *bundleInAppUrl = [mainBundle pathForResource:[NSString stringWithFormat:@"RNResources/%@/%@.ios", [bundleName lowercaseString],[bundleName lowercaseString]] ofType:@"js"];
    NSString *bundleJsonInAppUrl = [mainBundle pathForResource:[NSString stringWithFormat:@"RNResources/%@/bundle", [bundleName lowercaseString],[bundleName lowercaseString]] ofType:@"json"];
    
    NSDictionary *appBundle = [self getJSON:bundleJsonInAppUrl];
    
    NSString *homePath = NSHomeDirectory();

    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString *RNBundlePath = [docuPath stringByAppendingPathComponent:@"RNBundles"];
    
    NSString *bundleInDocumentUrl = [NSString stringWithFormat:@"%@/%@/%@.ios.js", RNBundlePath, [bundleName lowercaseString], [bundleName lowercaseString]];
    
    NSString *bundleJSONInDocumentUrl = [NSString stringWithFormat:@"%@/%@/bundle.json", RNBundlePath, [bundleName lowercaseString]];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:bundleInDocumentUrl]) {
            NSDictionary *documentBundle = [self getJSON:bundleJSONInDocumentUrl];
        NSString *appVersion = [appBundle valueForKey:@"version"];
        NSString *documentVersion = [documentBundle valueForKey:@"version"];
        
        NSInteger av = [appVersion componentsSeparatedByString:@"-"].lastObject.integerValue;
        
        NSInteger dv = [documentVersion componentsSeparatedByString:@"-"].lastObject.integerValue;
        
        BOOL useAppBundle = av > dv;
        if (useAppBundle) {
            return appBundle;
        }else{
            return documentBundle;
        }
    }
    return appBundle;
}

/**
 比较两个版本号的大小（2.0）
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion2:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }
    
    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }
    
    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最大的，进行循环比较
    NSInteger bigCount = (v1Array.count > v2Array.count) ? v1Array.count : v2Array.count;
    
    for (int i = 0; i < bigCount; i++) {
        // 字段有值，取值；字段无值，置0。
        NSInteger value1 = (v1Array.count > i) ? [[v1Array objectAtIndex:i] integerValue] : 0;
        NSInteger value2 = (v2Array.count > i) ? [[v2Array objectAtIndex:i] integerValue] : 0;
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }
        
        // 版本相等，继续循环。
    }

    // 版本号相等
    return 0;
}

+ (id)getJSON:(NSString *)path{
    if(!path) return nil;
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
          //DLog(@"JSON解码失败");
          return nil;
      } else {
          return jsonObj;
      }
}

+ (void)loadJSBundle:(NSString *)bundleName  done:(JSCodeLoadedBlock)done{
    NSURL* jsCodeLocation = [CBYDebugBridge getLoadUrl];
    if (![jsCodeLocation.absoluteString containsString:@"http"]) {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *pubUrl = [self getBundleUrl:bundleName];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HHmmssSS"];
        NSString *str = [formatter stringFromDate:[NSDate date]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (gRCTBridge.isLoading) {//侦听common加载完成
                        }

          NSURL *jsCodeLocation = [NSURL URLWithString:pubUrl];
        NSURL *bundUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",pubUrl]];
        [RCTJavaScriptLoader loadBundleAtURL:jsCodeLocation onProgress:nil onComplete:^(NSError *error, RCTSource *source) {
            if (source) {
               
                [gRCTBridge.batchedBridge dispatchBlock:^{
                    [gRCTBridge.batchedBridge executeSourceCode:source.data bundleUrl:bundUrl sync:NO];
                    [gRNBridgeManager.loadedBundles addObject:bundleName];
                    done(pubUrl);
                } queue:RCTJSThread];
             
            }
        }];

    });
    }else{
        done(nil);
    }
  
}


#pragma mark - 获取Bridge
+ (RCTBridge *) getBridge
{
  return gRCTBridge;
}

+ (RNBridgeManager *) getManager{
    return gRNBridgeManager;
}

- (NSMutableArray *)loadedBundles{
    if (!_loadedBundles) {
        _loadedBundles = [[NSMutableArray alloc] init];
    }
    return _loadedBundles;
}

@end
