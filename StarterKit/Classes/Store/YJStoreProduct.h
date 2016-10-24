/**
 * @brief   商品
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

@interface YJStoreProduct : NSObject

// ---------------- 必需 ---------------------

// 自定义的商品ID，和iAP相同也可以
@property (nonatomic, strong) NSString* ID;

// apple支付的商品ID，必须和iTunes建的商品ID一致
@property (nonatomic, strong) NSString* iAPProductID;

// 商品价格
@property (nonatomic, assign) double totalFee;

// ---------------- 可选 ---------------------

// 商品名称
@property (nonatomic, strong) NSString* name;

// 商品描述
@property (nonatomic, strong) NSString* productDescrtion;

@end
