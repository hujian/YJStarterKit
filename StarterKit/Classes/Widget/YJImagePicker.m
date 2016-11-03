#import "YJImagePicker.h"

@interface YJImagePicker()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) ImagePickerCompletion pickerCompletion;

@end

@implementation YJImagePicker

DEF_SINGLETON(YJImagePicker);

- (void)showPickerInController:(UIViewController *)controller completion:(ImagePickerCompletion)completion {
    if (nil != controller) {
        self.pickerCompletion = completion;

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        @weakify(self);
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            [alert addAction:[UIAlertAction actionWithTitle:@"照片库" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self);
                [self showImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary presentController:controller];
            }]];
        }

        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self);
                [self showImagePickerController:UIImagePickerControllerSourceTypeSavedPhotosAlbum presentController:controller];
            }]];
        }

        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self);
                [self showImagePickerController:UIImagePickerControllerSourceTypeCamera presentController:controller];
            }]];
        }

        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];

        [controller presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showImagePickerController:(UIImagePickerControllerSourceType)sourceType presentController:(UIViewController *)controller {
    if (nil != controller) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = sourceType;
        picker.allowsEditing = YES;
        [controller presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:NO completion:nil];

    if (nil != self.pickerCompletion) {
        self.pickerCompletion(image);
    }
    
    LogVerbose(@"pick image finished");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];

    if (nil != self.pickerCompletion) {
        self.pickerCompletion(nil);
    }
    
    LogVerbose(@"pick image cancelled");
}

@end
