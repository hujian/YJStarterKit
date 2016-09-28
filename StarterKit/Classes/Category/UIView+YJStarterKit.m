#import "UIView+YJStarterKit.h"

@implementation UIView (YJStarterKit)

#pragma mark - Size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect newframe = self.frame;
    newframe.size = size;
    self.frame = newframe;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect newframe = self.frame;
    newframe.size.height = height;
    self.frame = newframe;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect newframe = self.frame;
    newframe.size.width = width;
    self.frame = newframe;
}

- (CGPoint)centerInLocal {
    return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

- (void) addGlow:(UIColor *)color isCircle:(BOOL)isCircle cornerRadius:(CGFloat)cornerRadius thick:(CGFloat)thick {
    CALayer *viewLayer = self.layer;
    viewLayer.shadowOffset = CGSizeMake(0,0);
    viewLayer.shadowColor = color.CGColor;
    
    if (isCircle) {
        CGFloat radius = CGRectGetWidth(self.bounds) / 2;
        viewLayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-thick / 2 * radius, -thick / 2 * radius, (2 + thick) * (radius), (2 + thick) * radius) cornerRadius:radius].CGPath;
    } else {
        viewLayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-cornerRadius / 2, -cornerRadius / 2, self.bounds.size.width + cornerRadius, self.bounds.size.height + cornerRadius) cornerRadius:cornerRadius].CGPath;
    }
    
    viewLayer.shadowRadius = 5.0f;
    viewLayer.shadowOpacity = 1.0f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    animation.duration = 0.9;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @1.0;
    animation.toValue = @0.6;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [viewLayer addAnimation:animation forKey:@"shadowOpacity"];
}

- (void)removeGlow {
    CALayer *viewLayer = self.layer;
    viewLayer.shadowColor = [[UIColor clearColor] CGColor];
    [viewLayer removeAnimationForKey:@"shadowOpacity"];
}

@end
