#import "YJReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"
#import "YJLogger.h"

static const char* __statusNames[] = {
    "Unknown",
    "NotReachable",
    "ReachableViaWWAN",
    "ReachableViaWiFi"
};
static const int __statusNamesCount = sizeof(__statusNames) / sizeof(char*);

@implementation YJReachabilityManager

DEF_SINGLETON(YJReachabilityManager);

- (void)start {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [self.racDidNetworkChanges subscribeNext:^(NSNumber* status) {
        NSInteger index = MIN(MAX(0, status.integerValue + 1), __statusNamesCount);
        LogVerbose(@"reachability | %s", __statusNames[index]);
    }];
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
