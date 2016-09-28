#import "YJViewMoveAnimation.h"
#import "pop.h"
#import "ReactiveCocoa.h"

@implementation YJViewMoveAnimation

+ (void)move:(UIView*)view toPosition:(CGPoint)toPosition spring:(BOOL)spring completion:(void(^)(UIView *))block {
    @weakify(view);
    
    if (spring) {
        // 缩放
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.springBounciness = 20;
        scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
        [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        // 移动
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.springBounciness = 10;
        positionAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            @strongify(view);
            if (block) {
                block(view);
            }
        };
        [view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    } else {
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
            @strongify(view);
            if (block) {
                block(view);
            }
        };
        [view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    }
}

@end
