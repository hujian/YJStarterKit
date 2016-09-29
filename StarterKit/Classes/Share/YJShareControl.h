/*
 * @brief:  社会化分享登录工具
 * @author: hj
 * @date:   2015-10-11
 */

// 本身是依赖ShareSDK的，这货封装的挺好的，这里仅仅是对常规代码的一些包装，避免键盘损坏过快，所以适用范围很窄。
// 仅仅是对于QQ，微信，微博三种登录和分享的支持。
// 如果有其他需求的，请自行根据ShareSDK的文档来实现。

#import <Foundation/Foundation.h>

@interface YJShareControl : NSObject

// shareSDKAppID(必须)
//    请去到http://mob.com/login 登录后台进行应用注册
// weChatID / weChatToken
//    去微信开放平台申请https://open.weixin.qq.com/
// QQID / QQToken
//    去腾讯开放平台申请http://open.qq.com/

+ (void)setup:(NSString*)shareSDKAppID
     weChatID:(NSString*)weChatID
  weChatToken:(NSString*)weChatToken
         QQID:(NSString*)QQID
      QQToken:(NSString*)QQToken
     weiboID:(NSString*)weiboID
  weiboToken:(NSString*)weiboToken;

@end
