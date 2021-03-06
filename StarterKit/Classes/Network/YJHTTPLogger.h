/*
 * @brief:  基于AF Networking的log工具
 * @author: Hj
 * @date:   2016-10-02
 */

#import <Foundation/Foundation.h>
#import "YJSingletion.h"

@interface YJHTTPLogger : NSObject

AS_SINGLETON(YJHTTPLogger);

- (void)startLogging;

- (void)stopLogging;

@end
