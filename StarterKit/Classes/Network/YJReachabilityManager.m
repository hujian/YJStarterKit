#import "YJReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

@implementation YJReachabilityManager

DEF_SINGLETON(YJReachabilityManager);

- (void)start {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)stop {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (YJNetworkReachabilityStatus)networkReachabilityStatus {
    return (YJNetworkReachabilityStatus)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (RACSignal*)racDidNetworkChanges {
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    return RACObserve(manager, networkReachabilityStatus);
}

- (BOOL)reachable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (BOOL)reachableViaWiFi {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

- (BOOL)reachableViaWWAN {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

@end
