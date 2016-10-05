/*
 * @brief:  HTTP返回数据
 * @author: Hj
 * @date:   2016-10-01
 */

#import <Overcoat/Overcoat.h>

typedef enum __YJHTTPResponseType {
    YJHTTPResponseTypeUnknown = 0,
    YJHTTPResponseTypeDisk,      // 从本地磁盘获取
    YJHTTPResponseTypeServer,    // 从远端服务器获取
} YJHTTPResponseType;

@interface YJHTTPResponse : NSObject

@property (nonatomic, assign) YJHTTPResponseType responseType;

@property (nonatomic, strong) id result;

@property (nonatomic, strong) 

@end
