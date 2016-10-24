/**
 * @brief   支付结果数据
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

// 支付成功或失败后发消息通知, 返回YJStorePayResult, 如果error是nil，就是成功了
FOUNDATION_EXPORT NSString *const YJStorePayResultNotification;

@interface YJStorePayResult : NSObject

@property (nonatomic, strong) NSString* storeName;
@property (nonatomic, strong) NSError* error;

@end
