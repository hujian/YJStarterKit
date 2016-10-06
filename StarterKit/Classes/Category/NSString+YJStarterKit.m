#import "NSString+YJStarterKit.h"
#import "NSObject+YJStarterKit.h"

@implementation NSString (YJStarterKit)

- (NSString *)urlByAppendingParams:(NSDictionary*)params {
    if (params.isNotEmpty) {
        NSString * queryPrefix = [self rangeOfString:@"?"].location != NSNotFound ? @"&" : @"?";
        NSString * query = [NSString queryStringFromDictionary:params];
        return [NSString stringWithFormat:@"%@%@%@", self, queryPrefix, query];
    }
    return self;
}

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict {
    NSMutableArray * pairs = [NSMutableArray array];
    for ( NSString * key in dict.allKeys) {
        NSString * value = [(NSObject *)[dict objectForKey:key] toString];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)URLEncode:(NSString*)string {
    if (![string length]) {
        return @"";
    }
    
    if ([string respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        return [string stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@".:/%"] invertedSet]];
    }
    else {
        CFStringRef static const charsToEscape = CFSTR(".:/%");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringRef escapedString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                            (__bridge CFStringRef)string,
                                                                            NULL,
                                                                            charsToEscape,
                                                                            kCFStringEncodingUTF8);
#pragma clang diagnostic pop
        return (__bridge_transfer NSString *)escapedString;
    }
}

- (NSString *)URLDecode:(NSString *)string {
    if (![string length]) {
        return @"";
    }
    
    if ([string respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [string stringByRemovingPercentEncoding];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringRef unescapedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                              (__bridge CFStringRef)string,
                                                                                              CFSTR(""),
                                                                                              kCFStringEncodingUTF8);
#pragma clang diagnostic pop
        return (__bridge_transfer NSString *)unescapedString;
    }
}

@end
