/*
 * @brief:  UIView扩展了一些布局相关的代码
 * @author: Hj
 * @date:   2016-09-23
 */

#import <UIKit/UIKit.h>

@interface UIView (YJStarterKit)

// 布局
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;

// 在view的本地坐标系里面的中点
@property (nonatomic, assign, readonly) CGPoint centerInLocal;

// 外发光, thick = 0 ~ 1, 越大光圈越大
- (void) addGlow:(UIColor *)color isCircle:(BOOL)isCircle cornerRadius:(CGFloat)cornerRadius thick:(CGFloat)thick;
- (void) removeGlow;

@end
