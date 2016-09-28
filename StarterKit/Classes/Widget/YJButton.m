#import "YJButton.h"
#import <POP/POP.h>
#import "ReactiveCocoa.h"
#import "YJLogger.h"

@interface YJButton ()

@property (nonatomic, strong) UIActivityIndicatorView *loadingActivity;
@property (nonatomic, strong) NSString *textString;

@end

@implementation YJButton

+ (instancetype)button {
    return [self buttonWithType:UIButtonTypeCustom];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setup];
}

- (void)setup {
    [self addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (void)scaleToSmall {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation {
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

- (void)shake {
    [self.layer pop_removeAllAnimations];
    self.enabled = NO;
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @2000;
    positionAnimation.springBounciness = 20;
    @weakify(self);
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        @strongify(self);
        self.enabled = YES;
    }];
    [self.layer pop_addAnimation:positionAnimation forKey:@"shakeAnimation"];
}

- (void)startLoading:(UIActivityIndicatorViewStyle)style {
    if (!_loadingActivity) {
        _loadingActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        double size = self.bounds.size.height * 0.8;
        _loadingActivity.frame = CGRectMake(0, 0, (CGFloat)size, (CGFloat)size);
        _loadingActivity.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSubview:_loadingActivity];
    }
    _loadingActivity.hidden = NO;
    [_loadingActivity startAnimating];

    self.titleLabel.layer.opacity = 0;
    self.enabled = NO;
}

- (void)stopLoading {
    [_loadingActivity stopAnimating];
    _loadingActivity.hidden = YES;
    self.enabled = YES;

    self.titleLabel.layer.opacity = 1;
}

- (void)jump {
    POPBasicAnimation *jumpHigh = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    jumpHigh.toValue = @(self.center.y - 10);
    jumpHigh.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    @weakify(self);
    jumpHigh.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        @strongify(self);
        POPBasicAnimation *jumpHigh = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        jumpHigh.toValue = @(self.center.y - 10);
        jumpHigh.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];;
        jumpHigh.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        };
    };
}

- (void)stopJump {
}

- (void)dealloc {
    LogVerbose(@"YJButton dealloc");
}

@end
