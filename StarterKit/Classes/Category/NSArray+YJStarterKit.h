/*
 * @brief:  扩展数组的一些操作
 * @author: Hj
 * @date:   2016-09-23
 */

#import <Foundation/Foundation.h>

@interface NSArray (YJStarterKit)

- (NSArray *)head:(NSUInteger)count;
- (NSArray *)tail:(NSUInteger)count;
- (id)random;

@end

@interface NSMutableArray (YJStarterKit)

- (void)shuffle;

@end
