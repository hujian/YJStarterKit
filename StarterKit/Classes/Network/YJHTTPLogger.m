#import "YJHTTPLogger.h"
#import "AFURLSessionManager.h"
#import <objc/runtime.h>
#import "YJLogger.h"

static void * AFNetworkRequestStartDate = &AFNetworkRequestStartDate;

static NSError * AFNetworkErrorFromNotification(NSNotification *notification) {
    NSError *error = nil;
    if ([[notification object] isKindOfClass:[NSURLSessionTask class]]) {
        error = [(NSURLSessionTask *)[notification object] error];
        if (!error) {
            error = notification.userInfo[AFNetworkingTaskDidCompleteErrorKey];
        }
    }
    return error;
}

@implementation YJHTTPLogger

DEF_SINGLETON(YJHTTPLogger);

- (void)startLogging {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:AFNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
}

- (void)stopLogging {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkRequestDidStart:(NSNotification *)notification {
    NSURLSessionTask *task = [notification object];
    NSURLRequest *request = task.originalRequest;
    
    if (!request) {
        return;
    }
    
    // 计算响应时间
    objc_setAssociatedObject(notification.object, AFNetworkRequestStartDate, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString *body = nil;
    if ([request HTTPBody]) {
        body = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    }
    
    LogVerbose(@"HTTP | %@ %@", [request HTTPMethod], [[request URL] absoluteString]);
}

- (void)networkRequestDidFinish:(NSNotification *)notification {
    NSURLSessionTask *task = [notification object];
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSError *error = AFNetworkErrorFromNotification(notification);
    
    if (!request && !response) {
        return;
    }
    
    NSData* responseData = nil;
    if (notification.userInfo) {
        responseData = notification.userInfo[AFNetworkingTaskDidCompleteResponseDataKey];
    }

    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(notification.object, AFNetworkRequestStartDate)];
    
    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = (NSUInteger)[(NSHTTPURLResponse *)task.response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *)task.response allHeaderFields];
    }
    
    if (error) {
        LogError(@"HTTP | failed | %@ %@ | code: %ld, time: %.04fs | error: %@", [task.originalRequest HTTPMethod], [[task.response URL] absoluteString], (long)responseStatusCode, elapsedTime, error);
    } else {
        LogError(@"HTTP | succeed | %@ %@ | time: %.04fs | body: %@", [task.originalRequest HTTPMethod], [[task.response URL] absoluteString], elapsedTime, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    }

}

@end
