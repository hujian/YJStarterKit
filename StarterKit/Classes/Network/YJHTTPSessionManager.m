#import "YJHTTPSessionManager.h"
#import "YJHTTPLogger.h"
#import "Overcoat.h"
#import "OVCModelResponseSerializer.h"
#import "OVCURLMatcher.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "ReactiveCocoa.h"
#import "PINCache.h"
#import "YJHTTPLogger.h"

@interface YJHTTPInternalSessionManager : OVCHTTPSessionManager

@end

@implementation YJHTTPInternalSessionManager

+ (NSDictionary *)modelClassesByResourcePath {
    return nil;
}

@end

@interface YJHTTPSessionManager ()

@property (nonatomic, strong) YJHTTPInternalSessionManager* manager;

@end

@implementation YJHTTPSessionManager

DEF_SINGLETON(YJHTTPSessionManager);

- (id)init {
    self = [super init];
    if (self) {
        self.manager = [[YJHTTPInternalSessionManager alloc] init];
    }
    return self;
}

- (void)setup:(NSString*)serverBaseURL
     modelMap:(NSDictionary*)modelMap
  resourceMap:(NSDictionary*)resourceMap
     errorMap:(NSDictionary*)errorMap {
    self.serverBaseURL = serverBaseURL;
        
    self.manager.responseSerializer = [OVCModelResponseSerializer
     serializerWithURLMatcher:[OVCURLMatcher matcherWithBasePath:self.manager.baseURL.path
                                              modelClassesByPath:modelMap]
     responseClassURLMatcher:[OVCURLMatcher matcherWithBasePath:self.manager.baseURL.path
                                             modelClassesByPath:resourceMap]
     errorModelClassURLMatcher:[OVCURLMatcher matcherWithBasePath:self.manager.baseURL.path
                                               modelClassesByPath:errorMap]];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
#if DEBUG
    [[YJHTTPLogger sharedInstance] startLogging];
#endif
}

- (void)setServerBaseURL:(NSString *)serverBaseURL {
    NSAssert(![_serverBaseURL hasPrefix:@"http://"], @"server base url has to start with http://");
    _serverBaseURL = serverBaseURL;
}

- (NSURL*)fullURL:(NSString*)url {
    if (self.serverBaseURL && ![url hasPrefix:@"http://"]) {
        return [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:self.serverBaseURL]];
    } else {
        return [NSURL URLWithString:url];
    }
}

- (NSString*)responseSsavingKey:(NSString*)URL parameters:(id)parameters {
    
}

- (void)handleResponse:(OVCResponse*)_response error:(NSError*)error completion:(void(^)(YJHTTPResponse* response, NSError* error))completion {
    YJHTTPResponse* response = [[YJHTTPResponse alloc] init];
    response.result = _response.result;
    if (completion) {
        completion(response, error);
        
        if (!error && response.result) {
            [[PINCache sharedCache] setObject:response.result forKey:_response.HTTPResponse.URL.absoluteString];
        }
    }
}

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
 completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
    
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    @weakify(self);
    [self.manager GET:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        @strongify(self);
        [self handleResponse:response error:error completion:completion];
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
  completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
 
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    @weakify(self);
    [self.manager POST:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        @strongify(self);
        [self handleResponse:response error:error completion:completion];
    }];
}

@end
