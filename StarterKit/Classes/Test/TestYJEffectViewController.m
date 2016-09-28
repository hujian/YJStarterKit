#import "TestYJEffectViewController.h"
#import "YJUserView.h"
#import "UIView+YJStarterKit.h"
#import "UIImageView+WebCache.h"

@interface TestYJEffectViewController ()

@end

@implementation TestYJEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YJUserView* userView = [[YJUserView alloc] initWithFrame:CGRectMake(30, 80, 60, 60)];
    [userView showImageURL:nil defaultImage:nil];
    [self.view addSubview:userView];
    [userView addGlow:[UIColor redColor] isCircle:YES cornerRadius:0 thick:0.5];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user-view-default.png"]];
    imageView.frame = CGRectMake(130, 80, 60, 60);
    [imageView addGlow:[UIColor redColor] isCircle:NO cornerRadius:6 thick:0.5];
    [self.view addSubview:imageView];
}

@end
