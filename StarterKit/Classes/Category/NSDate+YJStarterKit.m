#import "NSDate+YJStarterKit.h"

@implementation NSDate (YJStarterKit)

+ (long long)timeStamp {
    return (long long)[[NSDate date] timeIntervalSince1970];
}

@end
