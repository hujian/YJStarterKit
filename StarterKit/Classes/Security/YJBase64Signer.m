#import "YJBase64Signer.h"

@implementation YJBase64Signer

- (NSString *)signString:(NSString *)string {
    return [self signData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)signData:(NSData *)data {
    return [data base64EncodedStringWithOptions:0];
}

@end
