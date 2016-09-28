/*
* @brief:  自动从nib加载内容
* @author: Hj
* @date:   2016-05-21
*/

// 自动从同名xib中加载内容到xibContainerView, 注意xib中不要把根view的class设置成自定义类
// 要把owner的class设置成自己的类

#import <UIKit/UIKit.h>

@interface YJXibView : UIView

// xib的根view会赋值到这个view，子类继承时注意不要重名了
@property (nonatomic, strong) UIView *xibContainerView;

@end
