/*
 * @brief:  圆形进度条
 * @author: Hj
 * @date:   2016-05-22
 */

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface YJCircleView : UIView

@property (nonatomic, assign) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat progress;

// 宽度必须一开始制定，后面也不能变
- (id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;

// duration > 0，代表需要动画
- (RACSignal *)setProgress:(CGFloat)progress duration:(CGFloat)duration;

// 颜色也可以变化


@end
