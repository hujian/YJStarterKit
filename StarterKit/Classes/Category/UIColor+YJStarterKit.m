#import "UIColor+YJStarterKit.h"

@implementation UIColor (YJStarterKit)

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255 ) / 255.0 alpha:1.0];
}

@end
