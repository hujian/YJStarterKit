#import <Foundation/Foundation.h>

@interface YJStringSigner : NSObject

- (NSString *)algorithmName;

- (NSString *)signString:(NSString *)string;

@end
