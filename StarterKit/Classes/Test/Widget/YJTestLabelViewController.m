#import "YJTestLabelViewController.h"
#import "YJLabel.h"
#import "UIView+YJStarterKit.h"

@interface YJTestLabelViewController ()

@end

@implementation YJTestLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJLabel* label = [[YJLabel alloc] init];
    label.center = self.view.centerInLocal;
    [self.view addSubview:label];
}

@end
