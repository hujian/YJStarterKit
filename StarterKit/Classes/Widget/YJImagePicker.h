/*
 * @brief:  选择图片控件
 * @author: Hj
 * @date:   2016-05-22
 */

#import <UIKit/UIKit.h>
#import "YJCommon.h"

// iOS10 以后需要在plist里面设置, 否则crash
//  Privacy - Camera Usage Description
//  Privacy - Photo Library Usage Description

typedef void(^ImagePickerCompletion)(UIImage *image);

@interface YJImagePicker : NSObject

AS_SINGLETON(YJImagePicker);

- (void)showPickerInController:(UIViewController *)controller completion:(ImagePickerCompletion)completion;

@end
