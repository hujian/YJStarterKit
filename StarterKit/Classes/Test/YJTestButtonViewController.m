#import "YJTestButtonViewController.h"
#import "YJButton.h"
#import "ReactiveCocoa.h"

@interface YJTestButtonViewController ()

@end

@implementation YJTestButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJButton* button = [self testButton:@"普通"];
    button.frame = CGRectMake(30, 80, 100, 60);
    [self.view addSubview:button];
    
    button = [self testButton:@"加载"];
    button.frame = CGRectMake(160, 80, 100, 60);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* b) {
        [b startLoading:UIActivityIndicatorViewStyleGray];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [b stopLoading];
        });
    }];
    
    button = [self testButton:@"摇动"];
    button.frame = CGRectMake(290, 80, 100, 60);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* b) {
        [b shake];
    }];
}

@end
