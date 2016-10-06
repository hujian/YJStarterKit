/*
 * @brief:  扩展一些基础功能
 * @author: Hj
 * @date:   2016-09-23
 */

#import <Foundation/Foundation.h>

@interface NSObject(YJStarterKit)

// 空数组，空字符串，长度为零的NSData也会认为是empty
- (BOOL)isNotEmpty;

// 各种格式都会尝试去转换，如果失败NSNull会返回nil，其他会返回空字符串
- (NSString*)toString;

// 失败会返回nil
- (NSNumber*)toNumber;

@end
