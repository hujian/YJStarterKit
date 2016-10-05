/*
 * @brief:  NSString扩展一些功能
 * @author: Hj
 * @date:   2016-09-23
 */

#import <Foundation/Foundation.h>

@interface NSString (YJStarterKit)

// string是url的情况下，加入参数，不会执行url encode
- (NSString *)urlByAppendingParams:(NSDictionary *)params;

- (NSString *)URLEncode;

@end
