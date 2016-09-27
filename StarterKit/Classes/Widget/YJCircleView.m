#import "YJCircleView.h"
#import "pop.h"
#import "YJLogger.h"

@interface YJCircleView()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) UIColor* startColor;
@property (nonatomic, strong) UIColor* endColor;

@end

@implementation YJCircleView

- (id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth {
    self = [super initWithFrame:frame];
    if (self) {
        NSAssert(frame.size.width == frame.size.height, @"A circle must have the same height and width.");
        [self addCircleLayer:lineWidth];
        self.progress = 0;
    }
    return self;
}

- (RACSignal *)setProgress:(CGFloat)progress duration:(CGFloat)duration {
    if (duration > 0) {
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable* (id<RACSubscriber> subscriber) {
            @strongify(self);
            POPBasicAnimation *strokeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            strokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            strokeAnimation.toValue = @(progress);
            strokeAnimation.duration = duration;
            strokeAnimation.removedOnCompletion = NO;
            strokeAnimation.animationDidApplyBlock = ^(POPAnimation *anim) {
                @strongify(self);
                [subscriber sendNext:@(self.progress)];
            };
            [self.circleLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
            return nil;
        }];
    } else {
        self.progress = progress;
        return nil;
    }
}

- (void)setProgress:(CGFloat)progress {
    self.circleLayer.strokeEnd = progress;
}

- (CGFloat)progress {
    return self.circleLayer.strokeEnd;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

- (void)addCircleLayer:(CGFloat)lineWidth {
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius * 2, radius * 2);
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                  cornerRadius:radius].CGPath;
    self.circleLayer.strokeColor = self.tintColor.CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineJoinRound;

    [self.layer addSublayer:self.circleLayer];
}

- (void)dealloc {
}

@end
