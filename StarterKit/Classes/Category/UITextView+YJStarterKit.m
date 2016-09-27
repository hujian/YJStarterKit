#import "UITextView+YJStarterKit.h"

@implementation UITextView(YJStarterKit)

- (void)scrollToBottom {
    if(self.text.length > 0 ) {
        NSRange bottom = NSMakeRange(self.text.length - 1, 1);
        [self scrollRangeToVisible:bottom];
    }
}

@end