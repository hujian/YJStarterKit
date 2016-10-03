/*
 * @brief:  HTTP网络管理类
 * @author: Hj
 * @date:   2016-10-01
 */

#import <Foundation/Foundation.h>
#import "Overcoat.h"
#import "YJSingletion.h"

@interface YJHTTPSessionManager : OVCHTTPSessionManager

AS_SINGLETON(YJHTTPSessionManager);

@end
