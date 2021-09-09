//
//  RCTViewController.m
//  CBYHybrid
//
//  Created by cuibenyong on 2020/3/19.
//

#import "RCTViewController.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface RCTViewController ()

@end

@implementation RCTViewController
{
    BOOL navHidden;
    BOOL animated;
    BOOL reloadFlag;
    NSString *mReloadBiz;
}

- (instancetype) initWithInitialParams:(RNBizConfig *)config{
    
    if (self = [super init]) {
        NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:[config getInitialPropsDict]];
        self.mConfig = config;
        [mParams setValue:[self getNowTimeTimestamp] forKey:@"timeStart"];
        [mParams setValue:[NSString stringWithFormat:@"%p",self] forKey:@"CBYAddress"];
        NSString *url = [RNBridgeManager getBundleUrl:[self getMainComponentName]];
        NSString *bundleName = [NSString stringWithFormat:@"%@.ios.js", [config.bundleName lowercaseString]];
        NSString *bundle = [url stringByReplacingOccurrencesOfString:bundleName withString:@"bundle.json"];
        
        NSURL *bundleUrl=[NSURL fileURLWithPath:bundle];
         NSData *data = [[NSData alloc] initWithContentsOfURL:bundleUrl];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"%@",dic);
        [mParams addEntriesFromDictionary:dic];
        [mParams setValue:url forKey:@"bundleUrl"];
        
        RCTRootView *rootView =  [[RCTRootView alloc] initWithBridge:[RNBridgeManager getBridge]
                                                                         moduleName: [self getMainComponentName]
                                                                  initialProperties:mParams];
        self.view = rootView;
        [self addDoubleTapTwiceGesture];
    }
    return self;
}

/// 设备接入模块 RN 试图控制器统一接口
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        NSMutableDictionary *mParams = [NSMutableDictionary dictionaryWithDictionary:dict];
        self.mConfig = [[RNBizConfig alloc] initWithBundleName:[dict valueForKey:@"bundleName"] defaultRoute:[dict valueForKey:@"defaultRoute"] initialProps:[dict objectForKey:@"initialProps"]];
        [mParams setValue:[self getNowTimeTimestamp] forKey:@"timeStart"];
        [mParams setValue:[NSString stringWithFormat:@"%p",self] forKey:@"CBYAddress"];
        RCTRootView *rootView =  [[RCTRootView alloc] initWithBridge:[RNBridgeManager getBridge]
                                                          moduleName: [self getMainComponentName]
                                                   initialProperties:mParams];
        self.view = rootView;
       [self addDoubleTapTwiceGesture];
    }
    

    return self;
}

- (NSString *)getMainComponentName{
    return self.mConfig.bundleName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    RCTRootView *rootView = (RCTRootView *)self.view;
    NSNumber *reactTag = [rootView reactTag];
    if(reactTag){
//            [[RNBridgeManager getBridge] enqueueJSCall:@"CBYEvent" method:@"emit" args:@[@"viewDidAppear",reactTag] completion:NULL];
    }

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    RCTRootView *rootView = (RCTRootView *)self.view;
    NSNumber *reactTag = [rootView reactTag];
//    [[RNBridgeManager getBridge] enqueueJSCall:@"CBYEvent" method:@"emit" args:@[@"viewDidDisappear",reactTag] completion:NULL];
}


- (void)didReceiveShouldAutorotat:(NSNotification *)noti{
    
    NSDictionary *userInfo = noti.object;
    NSString *address = [NSString stringWithFormat:@"%@",[userInfo valueForKey:@"address"]];
    if ([address isEqualToString:[NSString stringWithFormat:@"%p",self]]) {
        BOOL should = [[userInfo valueForKey:@"should"] boolValue];
        self.mShouldAutorotate = should;
    }
    
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}


#pragma mark - DevTool

- (void)addDoubleTapTwiceGesture {
    UITapGestureRecognizer *doubleTapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(doubleTapTwiceAction)];
    doubleTapTwice.numberOfTapsRequired = 2;
    doubleTapTwice.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapTwice];
}

- (void)doubleTapTwiceAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)getNowTimeTimestamp{
    
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970] * 1000;
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}

-(BOOL)isVCVisable{
    return (self.isViewLoaded && self.view.window);
}


@end
