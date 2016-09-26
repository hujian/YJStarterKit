#import "YJTestCaseViewController.h"

@interface YJTestCaseViewController ()

@end

@implementation YJTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"测试用例";
}

- (void)addTestCase:(NSString*)name toSection:(YJTestCaseSection*)section block:(void(^)())block {
    [section addItem:[RETableViewItem itemWithTitle:name accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        if (block) {
            block();
        }
    }]];
}

@end
