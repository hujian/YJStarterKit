/*
 * @brief:  table view controller的基类
 * @author: Hj
 * @date:   2015-11-20
 */

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "UIScrollView+EmptyDataSet.h"

#define YJTestCaseSection RETableViewSection

@interface YJTableViewController : UITableViewController <RETableViewManagerDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

// 表格的数据
- (YJTestCaseSection*)addSection:(NSString*)name;
- (YJTestCaseSection*)addSection:(NSString*)name index:(NSInteger)index;

// 空白页的图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;
// 空白页描述标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;
// 空白页描述
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;
// 空白页按钮title
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
// 空白页按钮图片
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
// 空白页背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView;
// 空白页自定义view
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;

@end
