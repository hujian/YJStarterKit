/*
 * @brief:  日志工具
 * @author: Hj
 * @date:   2015-10-09
 */

#import <UIKit/UIKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifndef Logger_h
#define Logger_h

#define LogError DDLogError
#define LogWarn DDLogWarn
#define LogInfo DDLogInfo
#define LogDebug DDLogDebug
#define LogVerbose DDLogVerbose

#define DDLogFlagNoLevel DDLogFlagVerbose + 1
#define LogNoLevel(frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagNoLevel, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#endif

@interface YJLogger : NSObject

+ (void)setup;

@end