/*
* @brief:  用户头像
* @author: Hj
* @date:   2016-05-22
*/

#import <UIKit/UIKit.h>

@interface YJUserView : UIView

// 网络图片url, default如果是nil的话，会有一张默认的放在框架的资源里面
// 不管下载图片有没有成功，都会调用
- (void)showImageURL:(NSString*)imageURL defaultImage:(UIImage*)image;
- (void)showImageURL:(NSString*)imageURL defaultImage:(UIImage*)image completedBlock:(void(^)(UIImage*))completedBlock;

// 边框
- (void)setBorderWidth:(CGFloat)width borderColor:(UIColor*)borderColor;

// 中间显示加载的菊花
- (void)startLoading:(UIActivityIndicatorViewStyle)style;
- (void)stopLoading;

@end
