#import "YJLogger.h"
#import "XAspect.h"

@interface MyCustomFormatter : NSObject <DDLogFormatter>

@end


@implementation MyCustomFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"E"; break;
        case DDLogFlagWarning  : logLevel = @"W"; break;
        case DDLogFlagInfo     : logLevel = @"I"; break;
        case DDLogFlagDebug    : logLevel = @"D"; break;
        case DDLogFlagVerbose  : logLevel = @"V"; break;
        default                : logLevel = @""; break;
    }
    
    // 如果不是默认的等级，就不要输出等级信息
    if (logMessage->_flag > DDLogFlagVerbose) {
        return [NSString stringWithFormat:@"%@\n", logMessage->_message];
    } else {
        return [NSString stringWithFormat:@"%@ | %@\n", logLevel, logMessage->_message];
    }
}

@end

@implementation YJLogger {
}

+ (void)setup {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDTTYLogger sharedInstance].logFormatter = [[MyCustomFormatter alloc] init];
  
    LogVerbose(@"Logger system start...");
}

@end


#define AtAspect Log

// ----------------------- 页面流程的切面 ------------------

#ifdef DEBUG

#define AtAspectOfClass UIViewController
@classPatchField(UIViewController)

AspectPatch(-, void, viewDidLoad) {
    LogVerbose(@"%@'s view did load.", NSStringFromClass([self class]));
    
    XAMessageForward(viewDidLoad);
}

AspectPatch(-, void, dealloc) {
    LogVerbose(@"%@ dealloc.", NSStringFromClass([self class]));
    
    XAMessageForwardDirectly(dealloc);
}

@end

#undef AtAspectOfClass
#undef AtAspect

#endif
