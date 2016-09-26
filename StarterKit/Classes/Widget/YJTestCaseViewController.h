/*
 * @brief:  测试用例基类
 * @author: Hj
 * @date:   2015-11-20
 */

#import <UIKit/UIKit.h>
#import "YJTableViewController.h"

@interface YJTestCaseViewController : YJTableViewController

- (void)addTestCase:(NSString*)name toSection:(YJTestCaseSection*)section block:(void(^)())block;

@end
