/*
* @brief:  按钮类
* @author: Hj
* @date:   2016-05-18
*/

#import <UIKit/UIKit.h>

@interface YJButton : UIButton

// 默认效果：
//    点击会有一点缩放
+ (instancetype)button;

// 左右水平摇晃，可以作为操作失败的交互
- (void)shake;

// 在中间显示loading菊花
- (void)startLoading:(UIActivityIndicatorViewStyle)style;
- (void)stopLoading;

// 像mac工具栏里那种跳动
- (void)jump;
- (void)stopJump;

@end
