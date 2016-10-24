#import "YJIAPStore.h"
#import "YJStoreManager.h"
#import "RMStore.h"
#import "YJCommon.h"

// 支付凭证保持文件名
#define IAPReceiptFile @"IAPReceiptFile.plist"

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

- (NSString *)receiptPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documents[0] stringByAppendingPathComponent:IAPReceiptFile];
    return path;
}

- (void)restoreReceipts:(void(^)(NSMutableArray *))completion {
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @strongify(self);
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[self receiptPath]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (nil != completion) {
                completion(array);
            }
        });
    });
}

- (void)saveReceiptToDisk:(NSMutableArray *)receipts {
    if (receipts.isNotEmpty) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @synchronized (self) {
                [receipts writeToFile:[self receiptPath] atomically:YES];
            }
        });
    }
}

- (void)saveReceipt:(NSString *)receipt {
    if (receipt.isNotEmpty) {
        @weakify(self);
        [self restoreReceipts:^(NSMutableArray *receipts) {
            @strongify(self);
            receipts = receipts == nil ? [NSMutableArray array] : receipts;
            if (![receipts containsObject:receipt]) {
                [receipts addObject:receipt];
                [self saveReceiptToDisk:receipts];
            }
        }];
    }
}

- (void)removeReceipt:(NSString *)receipt {
    if (receipt.isNotEmpty) {
        @weakify(self);
        [self restoreReceipts:^(NSMutableArray* receipts) {
            @strongify(self);
            if (receipts.isNotEmpty) {
                [receipts removeObject:receipt];
                [self saveReceiptToDisk:receipts];
            }
        }];
    }
}

- (void)verifyReceipt:(NSString *)receipt completion:(void (^)(BOOL success))completion {
    if (completion) {
        completion(receipt.isNotEmpty);
    }
    LogWarn(@"subclass sould overidde verifyReceipt:completion:");
}

- (void)resumeReceipts {
    @weakify(self);
    [self restoreReceipts:^(NSMutableArray *receipts) {
        @strongify(self);
        if (receipts.isNotEmpty) {
            [self verify:receipts index:0];
        }
    }];
}

- (void)verify:(NSArray *)receipts index:(NSInteger)index {
    if (nil != receipts && index >= 0 && index < receipts.count) {
        NSString *receipt = receipts[index];
        @weakify(self);
        [self verifyReceipt:receipt completion:^(BOOL success) {
            @strongify(self);
            if (success) {
                [self removeReceipt:receipt];
                [self verify:receipts index:index + 1];
            }
        }];
    }
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
