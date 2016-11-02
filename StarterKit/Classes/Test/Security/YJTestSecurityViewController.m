#import "YJTestSecurityViewController.h"
#import "YJCommon.h"

@implementation YJTestSecurityViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        YJTestCaseSection* section = [self addSection:@"加解密"];
        
        [self addTestCase:@"HTTP框架" toSection:section block:^() {
        }];
    }
 
    return self;
}

@end
