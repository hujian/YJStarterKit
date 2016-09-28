#import "YJTestCaseMainListViewController.h"
#import "ReactiveCocoa.h"
#import "YJTableViewController.h"
#import "YJTestProgressViewController.h"
#import "YJTestSplahViewController.h"
#import "YJTestButtonViewController.h"
#import "YJWebViewController.h"
#import "YJTestUserViewViewController.h"
#import "YJTestViewMoveViewController.h"

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
        
        section = [self addSection:@"基础UI控件"];
        
        [self addTestCase:@"按钮" toSection:section block:^() {
            @strongify(self);
            
            YJTestButtonViewController* vc = [[YJTestButtonViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self addTestCase:@"进度条" toSection:section block:^() {
            @strongify(self);
            
            YJTestProgressViewController* vc = [[YJTestProgressViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        section = [self addSection:@"扩展UI控件"];

        [self addTestCase:@"splash页面" toSection:section block:^() {
            @strongify(self);
            
            YJTestSplahViewController* vc = [[YJTestSplahViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self addTestCase:@"web页面" toSection:section block:^() {
            @strongify(self);
            
            YJWebViewController* vc = [[YJWebViewController alloc] initWithNibName:nil bundle:nil];
            vc.url = @"http://m.163.com";
            [self.navigationController pushViewController:vc animated:YES];
        }];

        [self addTestCase:@"空白页" toSection:section block:^() {
            @strongify(self);
            
            YJTableViewController* vc = [[YJTableViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        [self addTestCase:@"用户头像" toSection:section block:^() {
            @strongify(self);
            
            YJTestUserViewViewController* vc = [[YJTestUserViewViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        section = [self addSection:@"动画"];
        
        [self addTestCase:@"动作类动画" toSection:section block:^() {
            @strongify(self);
            
            YJTestViewMoveViewController* vc = [[YJTestViewMoveViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
