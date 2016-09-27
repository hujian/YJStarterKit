/*
 * @brief:  圆形进度条
 * @author: Hj
 * @date:   2016-05-22
 */

#import <UIKit/UIKit.h>

@interface YJCircleView : UIView

@property(nonatomic) UIColor *strokeColor;
@property(nonatomic, assign) CGFloat progress;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
