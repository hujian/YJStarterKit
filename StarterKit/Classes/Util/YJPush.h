/*
 * @brief:  推送
 * @author: hj
 * @date:   2015-10-11
 */

#import <Foundation/Foundation.h>
#import "YJCommon.h"

@interface YJPush : NSObject

AS_SINGLETON(YJPush);

- (void)setup;

@property (nonatomic, strong) NSString* deviceToken;
@property (nonatomic, strong) NSDictionary* remoteNotification;

@end
