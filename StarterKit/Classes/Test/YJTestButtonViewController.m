#import "YJTestButtonViewController.h"
#import "YJButton.h"
#import "ReactiveCocoa.h"

@interface YJTestButtonViewController ()

@end

@implementation YJTestButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJButton* button = [YJButton button];
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"普通" forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 80, 100, 60);
    [self.view addSubview:button];
    
    button = [YJButton button];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"加载" forState:UIControlStateNormal];
    button.frame = CGRectMake(160, 80, 100, 60);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* b) {
        [b startLoading:UIActivityIndicatorViewStyleGray];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [b stopLoading];
        });
    }];
    
    button = [YJButton button];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"摇动" forState:UIControlStateNormal];
    button.frame = CGRectMake(290, 80, 100, 60);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* b) {
        [b shake];
    }];
}

@end
