/**
 * @brief   base64字符串加密
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

@interface YJBase64Signer : NSObject

- (NSString *)signString:(NSString *)string;

- (NSString *)signData:(NSData *)data;

@end
