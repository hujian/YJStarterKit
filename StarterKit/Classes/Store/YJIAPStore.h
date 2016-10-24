/**
 * @brief   苹果支付
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>
#import "YJStore.h"

@interface YJIAPStore : NSObject<YJStoreProtocol>

/**
 * 保存支付凭证
 * @param receipt 凭证, 不为空
 */
- (void)saveReceipt:(NSString *)receipt;

/**
 * 删除凭证
 * @param receipt 凭证, 不为空
 */
- (void)removeReceipt:(NSString *)receipt;

// 验证凭证，子类需要继承，默认没有直接返回成功
- (void)verifyReceipt:(NSString *)receipt completion:(void(^)(BOOL success))completion;

/**
 * 恢复失败订单
 */
- (void)resumeReceipts;

@end
