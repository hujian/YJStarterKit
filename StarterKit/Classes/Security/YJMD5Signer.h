/**
 * @brief   MD5字符串加密
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

@interface YJMD5Signer : NSObject

- (NSString *)signString:(NSString *)string;

@end
