#import "YJTestHTTPViewController.h"
#import "ReactiveCocoa.h"
#import "YJHTTPSessionManager.h"
#import "YJHTTPTestManager.h"
#import "YJTools.h"

@interface YJTestHTTPViewController ()

@end

@implementation YJTestHTTPViewController

- (void)printInfo:(NSString*)url response:(YJHTTPResponse*)response error:(NSError*)error {
    if (!error) {
        if (response.responseType == YJHTTPResponseTypeDisk) {
            [self printDebugInfo:[NSString stringWithFormat:@"从磁盘恢复 %@, body: %@", url, response.result]];
        } else {
            [self printDebugInfo:[NSString stringWithFormat:@"从网络获取 %@, body: %@", url, response.result]];
        }
    } else {
        [self printDebugInfo:[NSString stringWithFormat:@"%@ 出错了", url]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);

    [[YJHTTPSessionManager sharedInstance] setup:nil modelMap:nil resourceMap:nil errorMap:nil];
    [YJHTTPSessionManager sharedInstance].responseCached = YES;

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
            [self printInfo:testURL response:response error:error];
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
                [self printInfo:testURL response:response error:error];
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
            [self printInfo:testURL response:response error:error];
        }];
    }];
}

@end
