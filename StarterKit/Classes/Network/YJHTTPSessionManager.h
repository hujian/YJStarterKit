/*
 * @brief:  HTTP网络管理类, 只支持接口返回JSON
 * @author: Hj
 * @date:   2016-10-01
 */

#import <Foundation/Foundation.h>
#import "YJSingletion.h"
#import "YJHTTPResponse.h"

@interface YJHTTPSessionManager : NSObject

AS_SINGLETON(YJHTTPSessionManager);

// 在调用其他任何方法必须调用该方法
- (void)setup:(NSString*)serverBaseURL
     modelMap:(NSDictionary*)modelMap
  resourceMap:(NSDictionary*)resourceMap
     errorMap:(NSDictionary*)errorMap;

// GET方法
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
 completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion;

// POST方法
- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
  completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion;

// 服务器地址，加上根路径也可以，允许动态修改
@property (nonatomic, strong) NSString* serverBaseURL;

// GET请求是否缓存，其他类型的请求没有缓存功能（想不出来什么需求用的着）
// 默认NO
@property (nonatomic, assign) BOOL responseCached;

@end
