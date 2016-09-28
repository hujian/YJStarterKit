/*
 * @brief:  view运动动画
 * @author: Hj
 * @date:   2016-09-23
 */

#import <UIKit/UIKit.h>

@interface YJViewMoveAnimation : NSObject

// 移动view从当前到特定位置，spring：是否有弹性效果
// 这函数不提供动画时间，主要是运来做弹性的快速运动，如果要控制时间的，不要用
+ (void)move:(UIView*)view toPosition:(CGPoint)toPosition spring:(BOOL)spring completion:(void(^)(UIView *))block;

@end
