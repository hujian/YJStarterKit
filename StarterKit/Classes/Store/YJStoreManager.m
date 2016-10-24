#import "YJStoreManager.h"

@interface YJStoreManager()

@property (nonatomic, strong) NSMutableDictionary *storeMap;

@end

@implementation YJStoreManager

DEF_SINGLETON(YJStoreManager);

- (instancetype)init {
    if (self = [super init]) {
        _storeMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerStore:(id<YJStoreProtocol>)store name:(NSString*)name {
    if (nil != store) {
        self.storeMap[name] = store;
    }
}

- (id<YJStoreProtocol>)store:(NSString*)name {
    return self.storeMap[name];
}

- (NSDictionary*)registeredStores {
    return _storeMap;
}

- (void)checkOrders {
}

- (void)prepare {
}

@end
