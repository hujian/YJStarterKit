/*
* @brief:  splash展示完后，该页面显示，然后做一个渐隐的动画
* @author: Hj
* @date:   2015-11-20
*/

#import <UIKit/UIKit.h>

@class YJSplashView;

@protocol YJSplashViewDelegate

- (void)splashViewDismissed:(YJSplashView *)splashView;

@end

@interface YJSplashView : UIView

// delay后去除splash
- (void)dismiss:(CGFloat)delay;

// 显示广告
- (void)showAD:(NSString*)url;

// 获取当前分辨率下面的splash图片名称
+ (NSString*)splashName;

// 跳过广告的按钮，只有在有广告的情况下才会显示
// 注意跳过本身的事件，需要调用者自己实现，调用上面的dismiss即可
@property (nonatomic, strong) UIButton* skipButton;

@property (nonatomic, weak) id<YJSplashViewDelegate> delegate;

@end
