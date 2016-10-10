/*
 * @brief:  网络状态管理类
 * @author: Hj
 * @date:   2016-10-06
 */

#import <Foundation/Foundation.h>
#import "YJSingletion.h"
#import "ReactiveCocoa.h"

typedef NS_ENUM(NSInteger, YJNetworkReachabilityStatus) {
    YJNetworkReachabilityStatusUnknown          = -1,
    YJNetworkReachabilityStatusNotReachable     = 0,
    YJNetworkReachabilityStatusReachableViaWWAN = 1,
    YJNetworkReachabilityStatusReachableViaWiFi = 2,
};

@interface YJReachabilityManager : NSObject

AS_SINGLETON(YJReachabilityManager);

// 刚start的时候，status是unknown的，要特别小心，不要reachable是fasle就认为没通
- (void)start;
- (void)stop;

// 网络状态变化信号量，返回的数据是YJNetworkReachabilityStatus
- (RACSignal*)racDidNetworkChanges;

// 不要observer这个变量，没用的。要判断变化用上面的rac observer
@property (readonly, nonatomic, assign) YJNetworkReachabilityStatus networkReachabilityStatus;

// 网络通不通，注意不是说能不能访问某个host，而是本地路由能不能通
// 不要
@property (readonly, nonatomic, assign) BOOL reachable;
@property (readonly, nonatomic, assign) BOOL reachableViaWWAN;
@property (readonly, nonatomic, assign) BOOL reachableViaWiFi;

@end
