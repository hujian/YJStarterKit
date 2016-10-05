#import "YJTestHTTPViewController.h"
#import "ReactiveCocoa.h"
#import "YJHTTPSessionManager.h"

@interface YJTestHTTPViewController ()

@end

@implementation YJTestHTTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[YJHTTPSessionManager sharedInstance] setup:nil modelMap:nil resourceMap:nil errorMap:nil];
    
    NSString* testURL = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html";
    
    YJButton* testButton = [self testButton:@"Get"];
    testButton.center = CGPointMake(60, 100);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [[YJHTTPSessionManager sharedInstance] GET:testURL parameters:nil completion:^(OVCResponse* response, NSError* error) {
        }];
    }];
}

@end
