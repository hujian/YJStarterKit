#import "AppDelegate.h"
#import "YJShareControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];
    
//    [YJShareControl setup:@"178d0350deb00"
//                 weChatID:nil weChatToken:nil QQID:@"1105655727"
//                  QQToken:@"35197a6668576adfd0ed35ccadae069f"
//                  weiboID:nil weiboToken:nil];
    
    return result;
}

@end
