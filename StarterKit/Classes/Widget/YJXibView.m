#import "YJXibView.h"

@implementation YJXibView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupContent];
}

- (void)setupContent {
    NSString *className = NSStringFromClass([self class]);
    if([[NSBundle mainBundle] pathForResource:className ofType:@"nib"]) {
        UINib* nib = [UINib nibWithNibName:className bundle:nil];
        if (nib) {
            _xibContainerView = [nib instantiateWithOwner:self options:nil][0];
            if (_xibContainerView) {
                _xibContainerView.frame = self.bounds;
                [self addSubview:_xibContainerView];
            }
        }
    }
}

@end
