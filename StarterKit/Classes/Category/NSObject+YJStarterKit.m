#import "NSObject+YJStarterKit.h"

@implementation NSObject(YJStarterKit)

- (BOOL)isNotEmpty {
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
}

@end
