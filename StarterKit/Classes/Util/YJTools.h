/*
 * @brief:  通用的工具函数
 * @author: hj
 * @date:   2015-10-11
 */

#import <UIKit/UIKit.h>

@interface YJTools : NSObject

// 每次生成一个新的vendorID
+ (NSString*)vendorID;

// 缓存到UserDefault的venderID，没有删除app的话，会一直返回同一个
+ (NSString *)cachedVendorID;

// 每次生成一个新的UUID
+ (NSString *)UUID;

// 广告ID，用户可以在隐私里面重置
+ (NSString *)IDFA;

// 主版本号
+ (NSString *)appVersion;

// build号
+ (NSString *)appBuild;

// 设备名称，比如xx' iPhone这种
+ (NSString *)deviceName;

// 利用dispatch批量间隔调用block
+ (void)repeat:(NSInteger)count Call:(void(^)(NSInteger index))block interval:(CGFloat)interval;

// 设置随机算法的时间种子
+ (void)initRandomTimeSeed;

// 加载resource文件到NSString
+ (NSString*)fileContent:(NSString*)fileName;

/*
 电话号码
 移动  134［0-8］ 135 136 137 138 139 150 151 152 158 159 182 183 184 157 187 188 147 178
 联通  130 131 132 155 156 145 185 186 176
 电信  133 153 180 181 189 177
 
 上网卡专属号段
 移动 147
 联通 145
 
 虚拟运营商专属号段
 移动 1705
 联通 1709
 电信 170 1700
 
 卫星通信 1349
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;

@end
