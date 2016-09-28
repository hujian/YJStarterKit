#import "YJUserView.h"
#import "UIImageView+WebCache.h"
#import "UIView+YJStarterKit.h"

@interface YJUserView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation YJUserView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    _imageView.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = [UIColor colorWithRed:30 green:194 blue:123 alpha:0].CGColor;
    _imageView.layer.borderWidth = 2.0;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _imageView.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
}

- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor*)borderColor {
    _imageView.layer.borderWidth = width;
    _imageView.layer.borderColor = borderColor.CGColor;
}

- (void)showImageURL:(NSString*)imageURL defaultImage:(UIImage*)image {
    [self showImageURL:imageURL defaultImage:image completedBlock:nil];
}

- (void)showImageURL:(NSString*)imageURL defaultImage:(UIImage*)defaultImage completedBlock:(void(^)(UIImage*))completedBlock {
    defaultImage = defaultImage == nil ? [UIImage imageNamed:@"user-view-default.png"] : defaultImage;
    
    if (imageURL) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                      placeholderImage:defaultImage
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (completedBlock) {
                completedBlock(image);
            }
        }];
    } else {
        _imageView.image = defaultImage;
    }
}

- (void)startLoading:(UIActivityIndicatorViewStyle)style {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        [self addSubview:_indicatorView];
        _indicatorView.center = self.centerInLocal;
    }
    [_indicatorView startAnimating];
}

- (void)stopLoading{
    [_indicatorView stopAnimating];
}

@end
