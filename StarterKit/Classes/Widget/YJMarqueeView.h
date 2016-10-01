/*
 * @brief:  跑马灯，基于SXMarquee，这里就是个壳，方便未来拓展
 * @author: Hj
 * @date:   2016-10-01
 */

#import <UIKit/UIKit.h>
#import "SXMarquee.h"

@interface YJMarqueeView : SXMarquee

// speed可以是 2,4,6,8. 越小越快
// msgGap是消息的间隔，实际上空格所以是整数个，具体的间隔和字体有关，使用的时候自己调试一下
- (instancetype)initWithFrame:(CGRect)frame
                        speed:(NSInteger)speed
                          msgs:(NSArray*)msgs
                       msgGap:(NSInteger)msgGap
                      bgColor:(UIColor*)bgColor
                      txtFont:(UIFont*)txtFont
                     txtColor:(UIColor*)txtColor;

@end
