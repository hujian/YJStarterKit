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
    
    [ShareSDK registerApp:shareSDKAppID
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
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
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:Sina_AppKey
                                           appSecret:Sina_AppSecret
                                         redirectUri:Sina_AppUri
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WeChat_AppID
                                       appSecret:WeChat_AppSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QZone_AppKey
                                      appKey:QZone_AppSecret
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

@end
