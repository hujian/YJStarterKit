#import "YJMarqueeView.h"

@implementation YJMarqueeView

- (instancetype)initWithFrame:(CGRect)frame
                        speed:(NSInteger)speed
                         msgs:(NSArray*)msgs
                       msgGap:(NSInteger)msgGap
                      bgColor:(UIColor*)bgColor
                      txtFont:(UIFont*)txtFont
                     txtColor:(UIColor*)txtColor {

    NSString* padding = [@" " stringByPaddingToLength:msgGap - 1 withString:@" " startingAtIndex:0];
    NSString* msg = [msgs componentsJoinedByString:padding];
    
    self = [super initWithFrame:frame speed:speed Msg:msg bgColor:bgColor txtColor:txtColor];
    
    if (self) {
        [self changeMarqueeLabelFont:txtFont];
    }
    
    return self;
}

@end
