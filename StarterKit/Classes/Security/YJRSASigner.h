/**
 * @brief   RSA字符串加密
 * @author  hj
 * @date    16/10/21
 */

#import <Foundation/Foundation.h>

@interface YJRSASigner : NSObject

- (NSString *)signString:(NSString *)string publicKey:(NSString*)publicKey;
- (NSString*)decrypt:(NSString*)encryptString privateKey:(NSString*)privateKey;

@end
