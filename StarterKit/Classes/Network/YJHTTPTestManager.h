/*
 * @brief: 基于OHHTTPStubs设置HTTP的测试数据
* @author: Hj
* @date:   2016-10-02
*/

#import <Foundation/Foundation.h>
#import "YJSingletion.h"

@interface YJHTTPTestManager : NSObject

AS_SINGLETON(YJHTTPTestManager);

// requestDelayTime, 是从发起请求到获取header的时间
// responseDelayTime, 是从发起请求到获取body的时间, 如果是负数，比如-200，代表200KB/s的下载速度
- (void)addTestResponse:(NSString*)response
                 forURL:(NSString*)URL
       requestDelayTime:(NSTimeInterval)requestDelayTime
      responseDelayTime:(NSTimeInterval)responseDelayTime;

- (void)removeAllTest;

@property (nonatomic, strong) NSString* baseURL;

@end
