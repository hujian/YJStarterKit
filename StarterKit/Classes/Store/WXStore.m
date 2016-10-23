#import "WXStore.h"
#import "NWStoreManager.h"
//#import "WXSecenModel.h"
#import "AppDelegate.h"

//@interface WXStoreHandler() <WXApiDelegate>
//
//@end
//
//@implementation WXStoreHandler

//DEF_SINGLETON(WXStoreHandler);

//- (void)onResp:(BaseResp *)resp{
//    if ([resp isKindOfClass:[PayResp class]]){
//        PayResp *response = (PayResp *)resp;
//        switch (response.errCode) {
//            case WXSuccess: {
//                [[NSNotificationCenter defaultCenter] postNotification:NWStorePaySuccessNotification withObject:nil];
//                LogVerbose(@"pay | WXPay | succeed");
//                break;
//            }
//            default: {
//                [[NSNotificationCenter defaultCenter] postNotification:NWStorePayFailureNotification withObject:nil];
//                LogVerbose(@"pay | WXPay | failed");
//                break;
//            }
//        }
//    }
//}

//@end

#define WeChatAppID @"wx5a2607979c97e1a1"

@interface WXStore ()

//@property (nonatomic, strong) WXSecenModel* sceneModel;
//@property (nonatomic, strong) PayItem* payItem;

@end

@implementation WXStore

- (void)pay:(NSString *)productId {
//    PayItem* payItem = [[NWStoreManager defaultManager] payItem:productId];
//    _payItem = payItem;
//    [self.sceneModel requestOrder:payItem.idstr];
}

//- (NSString*)createMd5Sign:(NSMutableDictionary*)dict {
//    NSMutableString *contentString  =[NSMutableString string];
//    NSArray *keys = [dict allKeys];
//    
//    //按字母顺序排序
//    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        return [obj1 compare:obj2 options:NSNumericSearch];
//    }];
//    
//    //拼接字符串
//    for (NSString *categoryId in sortedArray) {
//        if (![[dict objectForKey:categoryId] isEqualToString:@""]
//            && ![categoryId isEqualToString:@"sign"]
//            && ![categoryId isEqualToString:@"key"]
//            ){
//            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
//        }
//    }
//    
//    //添加key字段
//    [contentString appendFormat:@"key=%@", @"hangzhounacaiwangluo123456789hiH"];
//    //得到MD5 sign签名
//    NSString *md5Sign =[WXUtil md5:contentString];
//    
//    return md5Sign;
//}

//- (void)payWithWX:(WXModel*)model {
//    if (_payItem) {
//        NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
//        [dicM setObject:WeChatAppID forKey:@"appid"];
//        [dicM setObject:model.nonceStr forKey:@"noncestr"];
//        [dicM setObject:@"Sign=WXPay" forKey:@"package"];
//        [dicM setObject:@"1326168301" forKey:@"partnerid"];
//        [dicM setObject:model.timestamp forKey:@"timestamp"];
//        [dicM setObject:model.prepay_id forKey:@"prepayid"];
//        
//        PayReq* req             = [[PayReq alloc] init];
//        req.openID              = WeChatAppID;
//        req.partnerId           = @"1326168301";
//        req.prepayId            = model.prepay_id;
//        req.nonceStr            = model.nonceStr;
//        req.timeStamp           = [model.timestamp intValue];
//        req.package             = @"Sign=WXPay";
//        req.sign                = [self createMd5Sign:dicM];
//        
//        [WXApi sendReq:req];
//    }
//}
//
//- (WXSecenModel*)sceneModel {
//    if (_sceneModel == nil) {
//        _sceneModel = [WXSecenModel SceneModel];
//        @weakify(self);
//        
//        // 成功数据
//        [[RACObserve(_sceneModel, wxModel) filter:^BOOL(WXModel* model) {
//            return model.isNotEmpty;
//        }] subscribeNext:^(WXModel* model) {
//            @strongify(self);
//            [self payWithWX:model];
//            LogVerbose(@"pay | WXPay get order: %@", [model mj_JSONString]);
//        }];
//        
//        // 失败处理
//        [[RACObserve(_sceneModel.request, state) filter:^BOOL(NSNumber *state) {
//            @strongify(self);
//            return self.sceneModel.request.failed;
//        }] subscribeNext:^(NSNumber* state) {
//            @strongify(self);
//            [[NSNotificationCenter defaultCenter] postNotification:NWStorePayFailureNotification withObject:self.payItem.ios_key];
//            LogVerbose(@"pay | WXPay get orderID failed");
//        }];
//    }
//    return _sceneModel;
//}

@end
