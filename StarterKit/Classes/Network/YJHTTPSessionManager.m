#import "YJHTTPSessionManager.h"
#import "Overcoat.h"
#import "OVCModelResponseSerializer.h"
#import "OVCURLMatcher.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "ReactiveCocoa.h"
#import "PINCache.h"
#import "YJHTTPLogger.h"
#import "YJLogger.h"
#import "NSString+YJStarterKit.h"

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
    return nil;
}

- (void)handleResponse:(OVCResponse*)_response error:(NSError*)error completion:(void(^)(YJHTTPResponse* response, NSError* error))completion {
    YJHTTPResponse* response = [[YJHTTPResponse alloc] init];
    response.result = _response.result;
    response.responseType = YJHTTPResponseTypeServer;
    if (completion) {
        completion(response, error);
    }
}

- (void)GET:(NSString *)URLString
 parameters:(NSDictionary*)parameters
 completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
    
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    NSString* savingKey = [fullURL urlByAppendingParams:parameters];
    @weakify(self);
    
    // 网络读取数据
    [self.manager GET:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        @strongify(self);
        [self handleResponse:response error:error completion:completion];
        
        // 缓存到disk
        if (self.responseCached && !error && response.result) {
            [[PINCache sharedCache] setObject:response.result forKey:savingKey];
            LogVerbose(@"cache | HTTP response saving to %@", savingKey);
        }
    }];
    
    // 本地磁盘获取数据
    [[PINCache sharedCache] objectForKey:savingKey block:^(PINCache *cache, NSString *key, id object) {
        dispatch_async(dispatch_get_main_queue(), ^() {
            YJHTTPResponse* response = [[YJHTTPResponse alloc] init];
            response.result = object;
            response.responseType = YJHTTPResponseTypeDisk;
            if (completion) {
                completion(response, nil);
            }
            LogVerbose(@"cache | HTTP response %@ restore from disk", savingKey);
        });
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(NSDictionary*)parameters
  completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
 
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    @weakify(self);
    [self.manager POST:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        @strongify(self);
        [self handleResponse:response error:error completion:completion];
    }];
}

@end
