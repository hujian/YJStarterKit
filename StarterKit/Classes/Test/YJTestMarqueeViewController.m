#import "YJTestMarqueeViewController.h"
#import "YJMarqueeView.h"
#import "UIColor+YJStarterKit.h"
#import "UIView+YJStarterKit.h"

@interface YJTestMarqueeViewController ()

@end

@implementation YJTestMarqueeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJMarqueeView *adView = [[YJMarqueeView alloc]initWithFrame:CGRectMake(0, 255, self.view.width, 35)
                                                          speed:2
                                                            msgs:@[@"重大活动，天猫的双十一，然而并没卵用", @"京东就没更没啥花头了"]
                                                         msgGap:30
                                                        bgColor:[UIColor salmonColor]
                                                        txtFont:[UIFont systemFontOfSize:13]
                                                       txtColor:[UIColor whiteColor]];
    [adView changeMarqueeLabelFont:[UIFont systemFontOfSize:26]];
    [adView changeTapMarqueeAction:^{
    }];
    [adView start];
    [self.view addSubview:adView];
}

@end
