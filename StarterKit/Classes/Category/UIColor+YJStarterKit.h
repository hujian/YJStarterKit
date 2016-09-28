/*
 * @brief:  扩展UIColor，加入hex和便捷宏
 * @author: Hj
 * @date:   2016-09-23
 */

#import <UIKit/UIKit.h>
#import "HexColors.h"
#import "UIColor+Wonderful.h"

#undef	RGB
#define RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#undef	RGBA
#define RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor hx_colorWithHexString:v]

#undef	HEX_RGBA
#define HEX_RGBA(V, A)	[UIColor hx_colorWithHexString:V alpha:A]

@interface UIColor (YJStarterKit)

+ (UIColor *)randomColor;

@end
