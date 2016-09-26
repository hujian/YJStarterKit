#import "YJTestCaseViewController.h"

@interface YJTestCaseViewController ()

@end

@implementation YJTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"测试用例";
}

- (YJTestCaseSection*)addSection:(NSString*)name {
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    if (name) {
        section.headerTitle = name;
    }
    return section;
}

- (void)addTestCase:(NSString*)name toSection:(YJTestCaseSection*)section block:(void(^)())block {
    [section addItem:[RETableViewItem itemWithTitle:name accessoryType:UITableViewCellAccessoryDisclosureIndicator
                                   selectionHandler:^(RETableViewItem *item) {
        if (block) {
            block();
        }
    }]];
}

- (RETableViewManager*)manager {
    if (!_manager) {
      _manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
      _manager.delegate = self;
    }
    return _manager;
}

@end
