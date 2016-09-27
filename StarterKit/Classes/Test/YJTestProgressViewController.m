#import "YJTestProgressViewController.h"
#import "YJCircleView.h"
#import "ReactiveCocoa.h"

@interface YJTestProgressViewController ()

@end

@implementation YJTestProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    YJCircleView* view = [[YJCircleView alloc] initWithFrame:CGRectMake(30, 80, 60, 60) lineWidth:4];
    RACSignal* signal = [view setProgress:0.8 duration:2];
    
    [[signal map: ^id(NSNumber* value) {
        return [NSString stringWithFormat:@"%.1f%%", [value floatValue] * 100];
    }] subscribeNext:^(NSString* string) {
        @strongify(self);
        [self printDebugInfo:string];
    }];
    
    [self.view addSubview:view];
}

@end