/*
 * @brief:  测试用例基类
 * @author: Hj
 * @date:   2015-11-20
 */

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"

#define YJTestCaseSection RETableViewSection

@interface YJTestCaseViewController : UITableViewController <RETableViewManagerDelegate>

- (YJTestCaseSection*)addSection:(NSString*)name;

- (void)addTestCase:(NSString*)name toSection:(YJTestCaseSection*)section block:(void(^)())block;

@property (strong, nonatomic) RETableViewManager *manager;

@end