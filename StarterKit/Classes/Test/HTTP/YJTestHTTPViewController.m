#import "YJTestHTTPViewController.h"
#import "ReactiveCocoa.h"
#import "YJHTTPSessionManager.h"
#import "YJHTTPTestManager.h"
#import "YJTools.h"

@interface YJTestHTTPViewController ()

@end

@implementation YJTestHTTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);

    [[YJHTTPSessionManager sharedInstance] setup:nil modelMap:nil resourceMap:nil errorMap:nil];

    YJButton* testButton = [self testButton:@"Get成功"];
    NSString* testURL = @"http://api.hjaok.com/test.json";
    [[YJHTTPTestManager sharedInstance] addTestResponse:[YJTools fileContent:@"YJTestHTTP.json"]
                                                 forURL:testURL
                                       requestDelayTime:0
                                      responseDelayTime:0];
    testButton.center = CGPointMake(60, 100);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [[YJHTTPSessionManager sharedInstance] GET:testURL parameters:nil completion:^(YJHTTPResponse* response, NSError* error) {
            @strongify(self);
            [self printDebugInfo:[NSString stringWithFormat:@"%@ 成功了, body: %@", testURL, response.result]];
        }];
    }];
    
    testButton = [self testButton:@"Get失败"];
    testURL = @"http://api.hjaok.com/dummy";
    testButton.center = CGPointMake(160, 100);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [[YJHTTPSessionManager sharedInstance] GET:testURL parameters:nil completion:^(YJHTTPResponse* response, NSError* error) {
            @strongify(self);
            if (error) {
                [self printDebugInfo:[NSString stringWithFormat:@"%@ 出错了", testURL]];
            }
        }];
    }];
    
    testButton = [self testButton:@"Get延迟"];
    testURL = @"http://api.hjaok.com/delay.json";
    [[YJHTTPTestManager sharedInstance] addTestResponse:[YJTools fileContent:@"YJTestHTTP.json"]
                                                 forURL:testURL
                                       requestDelayTime:10
                                      responseDelayTime:0];
    testButton.center = CGPointMake(260, 100);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [[YJHTTPSessionManager sharedInstance] GET:testURL parameters:nil completion:^(YJHTTPResponse* response, NSError* error) {
            @strongify(self);
            [self printDebugInfo:[NSString stringWithFormat:@"%@ 成功了, body: %@", testURL, response.result]];
        }];
    }];
}

@end
