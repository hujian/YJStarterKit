/**
 * @brief   支付方式的基类
 * @author  hj
 * @date    16/10/21
 */
#import <Foundation/Foundation.h>
#import "YJStorePayResult.h"

// 加载商品完成 (iAP使用)
typedef void(^YJStoreRequestProductsCompletion)(NSArray *products);

@protocol YJStoreProtocol <NSObject>

@required
- (void)pay:(NSString *)productId;

@optional
// iAP使用，加载商品列表, items是iAP商品id列表
- (void)requestProducts:(NSArray *)items completion:(YJStoreRequestProductsCompletion)completion;
@end

@interface YJStore : NSObject
@end
