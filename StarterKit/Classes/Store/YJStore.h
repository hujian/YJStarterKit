/**
 * @brief   支付方式的基类
 * @author  hj
 * @date    16/10/21
 */
#import <Foundation/Foundation.h>

// 支付类型
typedef NS_ENUM(NSInteger, YJStoreType)  {
    NWStoreApple = 0,  //0:iap
    NWStoreWechat,     //1:微信支付
    NWStoreAlipay,     //2:alipay
};

// 支付成功和失败
FOUNDATION_EXPORT NSString *const YJStorePaySuccessNotification;
FOUNDATION_EXPORT NSString *const YJStorePayFailureNotification;

// 加载商品完成
typedef void(^YJStoreRequestProductsCompletion)(NSArray *products);

@protocol YJStoreProtocol <NSObject>
@required
/**
 * 支付
 * @param productId 产品id, 不为空
 * @param success 消息NWStorePaySuccessNotification, 带productId
 * @param failure 消息NWStorePayFailureNotification, 带productId, error
 */
- (void)pay:(NSString *)productId;

@optional

/**
 * 加载商品列表
 * @param items 支付商品列表
 * @param completion 加载完成
 */
- (void)requestProducts:(NSArray *)items completion:(YJStoreRequestProductsCompletion)completion;

@end

@interface YJStore : NSObject
@end
