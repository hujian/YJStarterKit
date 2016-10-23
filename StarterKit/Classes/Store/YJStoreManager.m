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

- (void)registerStore:(id <YJStoreProtocol>)store forPayment:(YJStoreType)type {
    if (nil != store) {
        self.storeMap[@(type)] = store;
    }
}

- (id <YJStoreProtocol>)store:(YJStoreType)type {
    return self.storeMap[@(type)];
}

- (void)checkOrders {
}

- (void)prepare {
    id<YJStoreProtocol> s = [self store:NWStoreApple];
    if (nil != s) {
        [s requestProducts:self.itemList completion:nil];
    }
}

@end
