#import "YJHTTPSessionManager.h"
#import "Overcoat.h"

@interface YJHTTPInternalSessionManager : OVCHTTPSessionManager

@end

@implementation YJHTTPInternalSessionManager

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

- (NSURL*)fullURL:(NSString*)url {
    if (self.baseURL) {
        return [NSURL URLWithString:url relativeToURL:[NSURL URLWithString:self.baseURL]];
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

@end
