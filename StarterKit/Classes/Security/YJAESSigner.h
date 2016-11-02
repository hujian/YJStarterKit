/**
 * @brief   AES字符串加密
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

@interface YJAESSigner : NSObject

- (NSData*)signString:(NSString*)plainText password:(NSString*)key;
- (NSString*)decrypt:(NSData*)encryptData password:(NSString*)key;

@end
