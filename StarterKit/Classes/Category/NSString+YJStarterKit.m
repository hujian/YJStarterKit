#import "NSString+YJStarterKit.h"
#import "NSObject+YJStarterKit.h"

@implementation NSString (YJStarterKit)

- (NSString *)urlByAppendingParams:(NSDictionary *)params {
    NSString * queryPrefix = [self rangeOfString:@"?"].location != NSNotFound ? @"&" : @"?";
    NSString * query = [NSString queryStringFromDictionary:params];
    return [NSString stringWithFormat:@"%@%@%@", self, queryPrefix, query];
}

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict {
    NSMutableArray * pairs = [NSMutableArray array];
    for ( NSString * key in dict.allKeys) {
        NSString * value = [(NSObject *)[dict objectForKey:key] toString];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)URLEncode {
    return self;
}

@end
