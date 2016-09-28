/*
 * @brief:  web的基类
 * @author: Hj
 * @date:   2016-07-28
 */

#import <UIKit/UIKit.h>

@interface YJWebViewController : UIViewController

- (void)reload;

@property (nonatomic, strong) NSString* url;

@end
