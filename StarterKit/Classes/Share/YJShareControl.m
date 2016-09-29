#import "YJShareControl.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#define YJShareSDKAppID @"178d0350deb00"

@implementation YJShareControl

+ (void)setup:(NSString*)shareSDKAppID
     weChatID:(NSString*)weChatID
  weChatToken:(NSString*)weChatToken
         QQID:(NSString*)QQID
      QQToken:(NSString*)QQToken
      weiboID:(NSString*)weiboID
   weiboToken:(NSString*)weiboToken {
    
    NSMutableArray* platforms = [NSMutableArray array];
    if (weChatID && weChatToken) {
        [platforms addObject:@(SSDKPlatformTypeWechat)];
    }
    if (QQID && QQToken) {
        [platforms addObject:@(SSDKPlatformTypeQQ)];
    }
    if (weiboID && weiboToken) {
        [platforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    }
    
    [ShareSDK registerApp:shareSDKAppID
          activePlatforms:platforms
                 onImport:^(SSDKPlatformType platformType) {
         switch (platformType) {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
         switch (platformType) {
             case SSDKPlatformTypeSinaWeibo:
                 [appInfo SSDKSetupSinaWeiboByAppKey:weiboID
                                           appSecret:weiboToken
                                         redirectUri:nil
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:weChatID
                                       appSecret:weChatToken];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQID
                                      appKey:QQToken
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

@end
