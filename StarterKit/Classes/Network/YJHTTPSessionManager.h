/*
 * @brief:  HTTP网络管理类
 * @author: Hj
 * @date:   2016-10-01
 */

#import <Foundation/Foundation.h>
#import "YJSingletion.h"
#import "YJHTTPResponse.h"

@interface YJHTTPSessionManager : NSObject

AS_SINGLETON(YJHTTPSessionManager);

// GET方法
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
 completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion;

// 必须设置
// 接口返回的实际数据和model的对应关系
// 接口返回的数据除了实际的model数据外，通常还会有一些meta data，这个就是对应关系
- (void)setup:(NSString*)serverBaseURL
     modelMap:(NSDictionary*)modelMap
  resourceMap:(NSDictionary*)resourceMap
     errorMap:(NSDictionary*)errorMap;

// 服务器地址，加上根路径也可以，允许动态修改
@property (nonatomic, strong) NSString* serverBaseURL;

@end
