#import "YJTestCaseViewController.h"
#import "UIView+YJStarterKit.h"

@interface YJTestCaseViewController ()

@property (nonatomic, strong) UITextView* outputView;

@end

@implementation YJTestCaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)printDebugInfo:(NSString*)info {
    if (!self.outputView) {
        self.outputView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.height / 2, self.view.width, self.view.height / 2)];
        [self.view addSubview:self.outputView];
    }
    self.outputView.text = [[self.outputView.text stringByAppendingString:info] stringByAppendingString:@"\n"];
}

@end
