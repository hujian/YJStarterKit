#import "YJPush.h"
#import "YJAppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface YJPush () <UNUserNotificationCenterDelegate>

@property (nonatomic, strong) id<AspectToken> recieveTokenHook;
@property (nonatomic, strong) id<AspectToken> recieveTokenFailedHook;
@property (nonatomic, strong) id<AspectToken> appLaunchHook;
@property (nonatomic, strong) id<AspectToken> recieveNotificationHook;

@end

@implementation YJPush

DEF_SINGLETON(YJPush);

- (void)setup {
    [self registerRemoteNotification];

    [YJTools clearAspeckHook:_recieveTokenHook];
    self.recieveTokenHook = [YJAppDelegate aspect_hookSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)
                                                   withOptions:AspectPositionAfter
                                                    usingBlock:^(id<AspectInfo> aspectInfo) {
                                                        [self handleDeviceToken:aspectInfo];
                                                    } error:nil];
    
    [YJTools clearAspeckHook:_recieveTokenFailedHook];
    self.recieveTokenFailedHook = [YJAppDelegate aspect_hookSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)
                                                         withOptions:AspectPositionAfter
                                                          usingBlock:^(id<AspectInfo> aspectInfo) {
                                                              [self handleDeviceTokenFailed:aspectInfo];
                                                          } error:nil];
    
    [YJTools clearAspeckHook:_appLaunchHook];
    self.recieveTokenHook = [YJAppDelegate aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:)
                                                   withOptions:AspectPositionAfter
                                                    usingBlock:^(id<AspectInfo> aspectInfo) {
                                                        NSArray* params = aspectInfo.arguments;
                                                        NSDictionary* launchOptions = params[1];
                                                        if (launchOptions.isNotEmpty) {
                                                            [self handleDeviceToken:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
                                                        }
                                                    } error:nil];
    
    [YJTools clearAspeckHook:_recieveNotificationHook];
    self.recieveNotificationHook = [YJAppDelegate aspect_hookSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)
                                                         withOptions:AspectPositionAfter
                                                          usingBlock:^(id<AspectInfo> aspectInfo) {
                                                              NSArray* params = aspectInfo.arguments;
                                                              NSDictionary* userInfo = params[1];
                                                              [self handleReciveNotification:userInfo];
                                                          } error:nil];
}

- (void)handleDeviceToken:(id<AspectInfo>)aspectInfo {
    NSArray* params = aspectInfo.arguments;
    if (params.count >= 2) {
        NSData* data = params[1];
        NSString *token = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        self.deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        LogVerbose(@"Push | recieve device token: %@", self.deviceToken);
    }
}

- (void)handleDeviceTokenFailed:(id<AspectInfo>)aspectInfo {
    NSArray* params = aspectInfo.arguments;
    if (params.count >= 2) {
        NSError* error = params[1];
        LogVerbose(@"Push | recieve device token failed: %@", error);
    }
}

- (void)handleReciveNotification:(NSDictionary*)userInfo {
    if (userInfo.isNotEmpty) {
        self.remoteNotification = userInfo;
        LogVerbose(@"Push | recieve notification: %@", userInfo);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    [self handleReciveNotification:notification.request.content.userInfo];
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    
    [self handleReciveNotification:response.notification.request.content.userInfo];
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

- (void)registerRemoteNotification {
    if ([YJTools systemVersion] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                LogVerbose(@"Push | graunt authorization succeed");
            } else {
                LogError(@"Push | grant authorization failed: %@", error);
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([YJTools systemVersion] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    }
}

@end
