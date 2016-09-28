#import "YJTestUserViewViewController.h"
#import "YJUserView.h"
#import "YJButton.h"
#import "ReactiveCocoa.h"

@interface YJTestUserViewViewController ()

@end

@implementation YJTestUserViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJUserView* userView = [[YJUserView alloc] initWithFrame:CGRectMake(30, 80, 60, 60)];
    [userView showImageURL:@"http://7xll9k.com2.z0.glb.qiniucdn.com/mymen.png" defaultImage:nil];
    [self.view addSubview:userView];
    
    userView = [[YJUserView alloc] initWithFrame:CGRectMake(130, 80, 60, 60)];
    [userView showImageURL:nil defaultImage:nil];
    [self.view addSubview:userView];
    
    userView = [[YJUserView alloc] initWithFrame:CGRectMake(230, 80, 60, 60)];
    [userView showImageURL:nil defaultImage:nil];
    [self.view addSubview:userView];

    YJButton* button = [self testButton:@"加载"];
    button.center = CGPointMake(userView.center.x, userView.center.y + 60);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(UIButton* button) {
        [userView startLoading:UIActivityIndicatorViewStyleGray];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [userView stopLoading];
        });
    }];
    
    userView = [[YJUserView alloc] initWithFrame:CGRectMake(330, 80, 60, 60)];
    [userView showImageURL:nil defaultImage:nil];
    [userView setBorderWidth:2 borderColor:[UIColor blueColor]];
    [self.view addSubview:userView];
}

@end
