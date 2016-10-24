/**
 * @brief   支付管理类
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>
#import "YJStore.h"
#import "YJSingletion.h"
#import "YJStoreProduct.h"

@interface YJStoreManager : NSObject

AS_SINGLETON(YJStoreManager);

// 商品列表，是YJStoreProduct的数组
@property (nonatomic, strong) NSArray *itemList;

// name: 商店名称， store: 支付实现
- (void)registerStore:(id<YJStoreProtocol>)store name:(NSString*)name;

// 按照商店名称，返回支付实现
- (id<YJStoreProtocol>)store:(NSString*)name;

// 返回已注册的，商店名称/支付实现
- (NSDictionary*)registeredStores;

/**
 * 恢复失败订单
 */
- (void)checkOrders;

/**
 * 准备支付前的一些事情, eg: 苹果支付先请求商店商品
 */
- (void)prepare;

@end
