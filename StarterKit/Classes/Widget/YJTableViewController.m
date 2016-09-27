#import "YJTableViewController.h"

@interface YJTableViewController ()

@property (strong, nonatomic) RETableViewManager *manager;

@end

@implementation YJTableViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 空白页处理
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        // A little trick for removing the cell separators
        self.tableView.tableFooterView = [UIView new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (YJTestCaseSection*)addSection:(NSString*)name {
    return [self addSection:name index:self.manager.sections.count];
}

- (YJTestCaseSection*)addSection:(NSString*)name index:(NSInteger)index {
    RETableViewSection *section = [RETableViewSection section];
    [self.manager insertSection:section atIndex:index];
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
    return [UIImage imageNamed:@"no-data-page-icon"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"NO data right now.";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
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

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

@end
