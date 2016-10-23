#import "YJIAPStore.h"
#import "YJStoreManager.h"
#import <RMStore.h>

@interface YJIAPStore()
@property (nonatomic, assign) BOOL isLoaded;
@end

@implementation YJIAPStore
- (instancetype)init {
    if (self = [super init]) {
        _isLoaded = NO;
    }
    return self;
}

- (void)requestProducts:(NSArray *)items completion:(YJStoreRequestProductsCompletion)completion {
}

- (void)handlePaySuccess:(NSString *)productId {
}

- (void)handlePayFailure:(NSString *)productId error:(NSString *)error {
}

- (void)pay:(NSString *)productId {
}

- (void)addPayment:(NSString *)productId {
}


-(void)verify:(NSString *)receipt productId:(NSString *)productId {
}

@end
