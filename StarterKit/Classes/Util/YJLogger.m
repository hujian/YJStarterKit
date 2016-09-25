#import "YJLogger.h"
#import "Aspects.h"

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
  
    LogVerbose(@"system | Logger start...");
}

+ (void)startLogVCProgress {
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        LogVerbose(@"flow | %@'s viewDidLoad called", NSStringFromClass([aspectInfo.instance class]));
    } error:NULL];
    
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        LogVerbose(@"flow | %@'s dealloc called", NSStringFromClass([aspectInfo.instance class]));
    } error:NULL];
}

@end