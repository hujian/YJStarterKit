#import "YJRSASigner.h"
#import "RSA.h"

@implementation YJRSASigner

- (NSString *)signString:(NSString *)string publicKey:(NSString*)publicKey {
    NSString *encrypted = [RSA encryptString:string publicKey:publicKey];
    return encrypted;
}

- (NSString*)decrypt:(NSString*)encryptString privateKey:(NSString*)privateKey {
    NSString *decrypted = [RSA decryptString:encryptString privateKey:privateKey];
    return decrypted;
}

@end
