/*
 * @brief:  测试用例列表
 * @author: Hj
 * @date:   2015-11-20
 */

#import <UIKit/UIKit.h>
#import "YJTableViewController.h"

@interface YJTestCaseListViewController : YJTableViewController

- (void)addTestCase:(NSString*)name toSection:(YJTestCaseSection*)section block:(void(^)())block;

@end
