#import "YJHTTPTestManager.h"
#import "OHHTTPStubs.h"

@implementation YJHTTPTestManager

DEF_SINGLETON(YJHTTPTestManager);

- (void)addTestResponse:(NSString*)response
                 forURL:(NSString*)URL
       requestDelayTime:(NSTimeInterval)requestDelayTime
      responseDelayTime:(NSTimeInterval)responseDelayTime {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:[self fullURL:URL].absoluteString];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        OHHTTPStubsResponse* response =  [OHHTTPStubsResponse responseWithData:data
                                                                    statusCode:200
                                                                       headers:@{@"Content-Type":@"application/json, text/plain"}];
        response.requestTime = requestDelayTime;
        response.responseTime = responseDelayTime;
        return response;
    }];
}

- (void)removeAllTest {
    [OHHTTPStubs removeAllStubs];
}

- (NSURL*)fullURL:(NSString*)url {
    if (self.baseURL) {
        return [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:self.baseURL]];
    } else {
        return [NSURL URLWithString:url];
    }
}

@end
