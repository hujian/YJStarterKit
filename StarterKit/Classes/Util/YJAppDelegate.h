/*
 * @brief:  入口的包装类，把常用的一些东西直接实现了
 * @author: Hj
 * @date:   2016-09-23
 */

#import <UIKit/UIKit.h>

@interface YJAppDelegate : UIResponder <UIApplicationDelegate>

// 设置日志系统
// DEBUG状态下, 会默认会打印一些消息。不需要的自行继承修改
- (void)setupLog;

// 正式流程的根，子类覆盖
- (UIViewController*)rootViewController;

// 测试用例流程的根, 子类覆盖
- (UIViewController*)testCaseViewController;

// 是否显示splash动画，默认false
- (BOOL)showSplashView;

// 是否需要测试用例页面
// 默认DEBUG下面YES，release下面NO
- (BOOL)needTestCase;

// 是否需要推送
- (BOOL)needPush;

@property (nonatomic, strong) UIWindow *window;

@end
