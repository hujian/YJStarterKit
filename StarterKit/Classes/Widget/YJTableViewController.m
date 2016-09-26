#import "YJTableViewController.h"

@interface YJTableViewController ()

@end

@implementation YJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 空白页处理
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
}

- (YJTestCaseSection*)addSection:(NSString*)name {
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    if (name) {
        section.headerTitle = name;
    }
    return section;
}

- (RETableViewManager*)manager {
    if (!_manager) {
        _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
        _manager.delegate = self;
    }
    return _manager;
}

// 空白页扩展请参考https://github.com/dzenbot/DZNEmptyDataSet
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}

@end
