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

- (NSString *)toString {
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    } else if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        NSData * data = (NSData*)self;
        NSString * text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        if (nil == text) {
            text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (nil == text) {
                text = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            }
        }
        return text;
    } else {
        return [NSString stringWithFormat:@"%@", self];	
    }
}

- (NSNumber*)toNumber {
    if ([self isKindOfClass:[NSNumber class]]) {
        return (NSNumber *)self;
    } else if ([self isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
    } else if ([self isKindOfClass:[NSDate class]]) {
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    } else if ( [self isKindOfClass:[NSNull class]] ) {
        return [NSNumber numberWithInteger:0];
    }
    return nil;
}

@end
