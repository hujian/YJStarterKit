#import "YJTestCaseMainListViewController.h"
#import "ReactiveCocoa.h"
#import "YJTableViewController.h"
#import "YJTestProgressViewController.h"
#import "YJTestSplahViewController.h"

@interface YJTestCaseMainListViewController ()

@end

@implementation YJTestCaseMainListViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        @weakify(self);
        
        YJTestCaseSection* section = [self addSection:@"工具箱"];
        [self addTestCase:@"待定" toSection:section block:^() {
        }];
        
        section = [self addSection:@"UI控件"];
        [self addTestCase:@"空白页" toSection:section block:^() {
            @strongify(self);
            
            YJTableViewController* vc = [[YJTableViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self addTestCase:@"进度条" toSection:section block:^() {
            @strongify(self);
            
            YJTestProgressViewController* vc = [[YJTestProgressViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self addTestCase:@"splash页面" toSection:section block:^() {
            @strongify(self);
            
            YJTestSplahViewController* vc = [[YJTestSplahViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
