#import "YJTestViewMoveViewController.h"
#import "YJViewMoveAnimation.h"
#import "UIView+YJStarterKit.h"
#import "ReactiveCocoa.h"
#import "YJTools.h"

@interface YJTestViewMoveViewController ()

@end

@implementation YJTestViewMoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 160)];
    view.center = CGPointMake(self.view.centerInLocal.x, -100);
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    YJButton* testButton = [self testButton:@"显示"];
    testButton.center = CGPointMake(30, 80);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [YJViewMoveAnimation move:view toPosition:self.view.centerInLocal spring:YES completion:nil];
    }];
    
    testButton = [self testButton:@"隐藏"];
    testButton.center = CGPointMake(130, 80);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [YJViewMoveAnimation move:view toPosition:CGPointMake(self.view.centerInLocal.x, -100) spring:YES completion:nil];
    }];
    
    NSMutableArray* views = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, -100, 40, 40)];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        [views addObject:view];
    }
    testButton = [self testButton:@"飞一组"];
    testButton.center = CGPointMake(230, 80);
    [self.view addSubview:testButton];
    [[testButton rac_signalForControlEvents:UIControlEventTouchDown] subscribeNext:^(YJButton* button) {
        [YJTools repeat:10 Call:^(NSInteger index) {
            [YJViewMoveAnimation move:views[index] toPosition:self.view.centerInLocal spring:NO completion:nil];
        } interval:0.05];
    }];
}

@end
