#import "YJSplashView.h"
#import "UIImageView+WebCache.h"

@interface YJSplashView ()

@property (nonatomic, strong) UIImageView* defaultSplashView;

@end

@implementation YJSplashView {
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    UIImage *image = [UIImage imageNamed:[YJSplashView splashName]];
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

+ (NSString*)splashName {
    NSString *imageName = nil;
    int screenHeight = (int)[UIScreen mainScreen].bounds.size.height;
    switch (screenHeight) {
        case 480: {
            imageName = @"LaunchImage-700@2x.png";
            break;
        }
        case 568: {
            imageName = @"LaunchImage-700-568h@2x.png";
            break;
        }
        case 667: {
            imageName = @"LaunchImage-800-667h@2x.png";
            break;
        }
        case 736: {
            imageName = @"LaunchImage-800-Portrait-736h@3x.png";
            break;
        }
        default: {
            imageName = @"LaunchImage-700@2x.png";
            break;
        }
    }
    return imageName;
}

@end
