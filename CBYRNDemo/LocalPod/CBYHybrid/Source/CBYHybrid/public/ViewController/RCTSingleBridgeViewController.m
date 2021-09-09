//
//  RCTSingleBridgeViewController.m
//  CBYHybrid
//
//  Created by 玄一 on 2021/8/28.
//

#import "RCTSingleBridgeViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBridge.h>
#import <React/RCTBridge+Private.h>
#import "CBYDebugBridge.h"
#import "RNBridgeManager.h"

@interface RCTSingleBridgeViewController ()
@property (nonatomic, strong) NSString *bundleName;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) RCTBridge *bridge;

@end

@implementation RCTSingleBridgeViewController

- (instancetype)initWithBundleName:(NSString *)bundleName params:(NSDictionary *)params{
    if (self = [super init]) {
        NSString *coreUrl = [RNBridgeManager getBundleUrl:@"Core"];
        NSURL *jsCodeLocation = [NSURL URLWithString:coreUrl];
      #if DEBUG
          [CBYDebugBridge setDefaultUrl:jsCodeLocation];
          jsCodeLocation = [CBYDebugBridge getLoadUrl];
      //    jsCodeLocation = [NSURL URLWithString:@"http://192.168.0.102:8081/index.bundle?platform=ios&dev=true&minify=false"];
      #endif
        self.bridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation moduleProvider:nil launchOptions:self.params];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
