#import "YJAppDelegate.h"
#import "YJSplashView.h"
#import "YJLogger.h"
#import "YJTestCaseViewController.h"

@implementation YJAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 日志
    [self setupLog];
  
    // 页面入口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 是否需要测试用例
    if ([self needTestCase]) {
        self.window.rootViewController = [self testCaseViewController];
    } else {
        self.window.rootViewController = [self rootViewController];
    }
  
    // splash
    if ([self showSplashView]) {
        YJSplashView* splash = [[YJSplashView alloc] initWithFrame:self.window.bounds];
        [self.window addSubview:splash];
    }
  
    return YES;
}

- (void)setupLog {
    [YJLogger setup];
    [YJLogger startLogVCProgress];
}

- (UIViewController*)rootViewController {
    LogWarn(@"AppDelegat sould overide YJAppDelegate::rootViewController");
    return [[UIViewController alloc] init];
}

- (UIViewController*)testCaseViewController {
    LogWarn(@"AppDelegat sould overide YJAppDelegate::testCaseViewController");
  
    YJTestCaseViewController* test = [[YJTestCaseViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:test];
    
    __weak YJAppDelegate* weakSelf = self;
    
    YJTestCaseSection* section = [test addSection:nil];
    [test addTestCase:@"正常流程" toSection:section block:^() {
        UIViewController* root = [weakSelf rootViewController];
        weakSelf.window.rootViewController = root;
    }];
  
    return navi;
}

- (BOOL)showSplashView {
    return NO;
}

- (BOOL)needTestCase {
#if DEBUG
    return YES;
#else
    return NO;
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end