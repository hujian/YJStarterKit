#import "TestProgressViewController.h"
#import "YJCircleView.h"
#import "ReactiveCocoa.h"

@interface TestProgressViewController ()

@end

@implementation TestProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJCircleView* view = [[YJCircleView alloc] initWithFrame:CGRectMake(30, 80, 60, 60) lineWidth:4];
    RACSignal* signal = [view setProgress:0.8 duration:2];
    [[signal map: ^id(NSNumber* value) {
        return [NSString stringWithFormat:@"%.1f%%", [value floatValue] * 100];
    }] subscribeNext:^(NSString* string) {
        [self printDebugInfo:string];
    }];

    
    [self.view addSubview:view];
    
}

@end