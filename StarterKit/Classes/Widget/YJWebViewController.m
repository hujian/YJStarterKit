#import "YJWebViewController.h"
#import "UIView+YJStarterKit.h"
#import "YJLogger.h"

@interface YJWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) UIActivityIndicatorView* indicatorView;

@end

@implementation YJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [self reload];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-back"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(barButtonItemAction)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)reload {
    if (_url) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [_webView loadRequest:request];
        [self showLoading];
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.navigationItem.title = self.title;
}

- (void)showLoading {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    _indicatorView.hidden = NO;
    _indicatorView.center = self.view.centerInLocal;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
}

- (void)hideLoadding {
    if (_indicatorView) {
        _indicatorView.hidden = NO;
        [_indicatorView stopAnimating];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    LogVerbose(@"web | start to load, url: %@", _url);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideLoadding];
    LogVerbose(@"web | load succeed, url: %@", _url);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideLoadding];
    LogVerbose(@"web | load failed, url: %@, error: %@", _url, error);
}

- (void)barButtonItemAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
