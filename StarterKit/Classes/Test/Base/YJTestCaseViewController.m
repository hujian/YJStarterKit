#import "YJTestCaseViewController.h"
#import "UIView+YJStarterKit.h"
#import "UITextView+YJStarterKit.h"
#import "UIColor+YJStarterKit.h"

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
    [self.outputView scrollToBottom];
}

- (YJButton*)testButton:(NSString*)title {
    YJButton* button = [YJButton button];
    button.backgroundColor = [UIColor randomColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[button.backgroundColor reverseColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80, 30);
    [self.view addSubview:button];
    return button;
}

@end
