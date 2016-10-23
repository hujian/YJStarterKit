/**
 * @brief   支付管理类
 * @author  wudb
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>
#import "YJStore.h"
#import "YJSingletion.h"

@interface YJStoreManager : NSObject

AS_SINGLETON(YJStoreManager);

// 从服务器取回来的商品列表, [PayItem]
@property (nonatomic, strong) NSArray *itemList;

/**
 * 注册支付方式
 * @param store 对应支付方式实例
 * @param type 商店类型
 */
- (void)registerStore:(id<YJStoreProtocol>)store forPayment:(YJStoreType)type;

/**
 * 根据类型获取商店句柄
 * @param type 商店类型
 * @return
 */
- (id<YJStoreProtocol>)store:(YJStoreType)type;

/**
 * 恢复失败订单
 */
- (void)checkOrders;

/**
 * 准备支付前的一些事情, eg: 苹果支付先请求商店商品
 */
- (void)prepare;

@end
