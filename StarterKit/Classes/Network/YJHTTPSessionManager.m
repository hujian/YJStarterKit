#import "YJHTTPSessionManager.h"
#import "YJHTTPLogger.h"
#import "Overcoat.h"
#import "OVCModelResponseSerializer.h"
#import "OVCURLMatcher.h"
#import "AFNetworkActivityIndicatorManager.h"

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

- (NSURL*)fullURL:(NSString*)url {
    if (self.serverBaseURL) {
        return [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:self.serverBaseURL]];
    } else {
        return [NSURL URLWithString:url];
    }
}

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
 completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
    
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    [self.manager GET:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        if (completion) {
            completion((YJHTTPResponse*)response, error);
        }
    }];
}

- (void)POST:(NSString *)URLString
  parameters:(id)parameters
  completion:(void(^)(YJHTTPResponse* response, NSError* completion))completion {
 
    NSString* fullURL = [self fullURL:URLString].absoluteString;
    [self.manager POST:fullURL parameters:parameters completion:^(OVCResponse* response, NSError* error) {
        if (completion) {
            completion((YJHTTPResponse*)response, error);
        }
    }];
}

@end
