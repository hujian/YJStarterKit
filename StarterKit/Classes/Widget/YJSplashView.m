#import "YJSplashView.h"
#import "UIImageView+WebCache.h"
#import "YJLogger.h"
#import "YJTools.h"

@interface YJSplashView ()

@property (nonatomic, strong) UIImageView* defaultSplashView;

@end

@implementation YJSplashView {
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    UIImage *image = [UIImage imageNamed:[YJTools splashName]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
    _defaultSplashView = imageView;
    
    return self;
}

- (void)dismiss:(CGFloat)delay {
    [self fadeOut:delay];
}

- (void)showAD:(NSString*)url {
    UIImageView* ad = [[UIImageView alloc] initWithFrame:self.bounds];
    [ad sd_setImageWithURL:[NSURL URLWithString:url]];
    [self addSubview:ad];
    
     if (_skipButton) {
        [self addSubview:_skipButton];
    }
}

- (void)fadeOut:(CGFloat)delay {
    __weak YJSplashView *weakSelf = self;
    
    [UIView animateWithDuration:0.6 delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(1.2, 1.2);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (weakSelf.delegate) {
            [weakSelf.delegate splashViewDismissed:self];
        }
        [weakSelf removeFromSuperview];
    }];
}

- (void)dealloc {
}

@end