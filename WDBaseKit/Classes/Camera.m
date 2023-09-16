//
//  CAMERA.m
//  BaseSDK
//
//  Created by summer on 16/8/29.
//  Copyright © 2016年 summer. All rights reserved.
//

#import "Camera.h"
#import "Alert.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface Camera()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property  (nonatomic,strong)Callback callback;
@property  (nonatomic,strong)VideoCallback videoCallback;

@property UIImage *m_image;
@end
static Camera *camera_Instance = nil;
bool  isChoosePhoto =NO;//是否是选择照片
@implementation Camera

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        camera_Instance = [[Camera alloc] init];
    });
    return camera_Instance;
}

+(void)openCamera:(Callback)callback allowEdit:(BOOL)edit isShow:(ShowCompleted)showCompleted
{
    NSString *mediaTyoe =AVMediaTypeVideo;
    AVAuthorizationStatus status =[AVCaptureDevice authorizationStatusForMediaType:mediaTyoe];
    if (status==AVAuthorizationStatusRestricted||status==AVAuthorizationStatusDenied) {
        //拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            [Alert alert:@"请将'设置->隐私->相机->'设置为允许" callback:^{
                //跳转到设置
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:url];
            }];
        });
        showCompleted(NO);
    }else{
        isChoosePhoto =YES;
        if(camera_Instance==nil){
            [Camera shareInstance];
        }
        camera_Instance.callback = callback;
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            [Alert alert:@"当前相机不可用,请前往相册"];
            showCompleted(YES);
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        UIImagePickerController*picker = [[UIImagePickerController alloc]init];
        picker.delegate = camera_Instance;
        picker.allowsEditing = edit;//设置可编辑
        picker.sourceType = sourceType;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [[camera_Instance getCurrentVC] presentViewController:picker animated:YES completion:^{
            showCompleted(YES);
        }];//进入照相界面
    }
}
+(void)openRecord:(VideoCallback)callback isShow:(ShowCompleted )showCompleted
{
    isChoosePhoto =NO;
    if(camera_Instance==nil){
        [Camera shareInstance];
    }
    camera_Instance.videoCallback = callback;
    //    UIViewController* viewController = [[UIViewController alloc]init];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = camera_Instance;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 600.0f; //录像最长时间
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    } else {
        
        [Alert alert:@"当前设备不支持录像功能"];
        showCompleted(YES);
        
    }
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    //跳转到拍摄页面
    [[camera_Instance getCurrentVC] presentViewController:picker animated:YES completion:^{
        showCompleted(YES);
    }];
}
+(void)openGallery:(Callback)callback isShow:(ShowCompleted )showCompleted

{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];//IOS 11 不需要用户同意直接能进入
    if (status==PHAuthorizationStatusDenied||status==PHAuthorizationStatusRestricted) {
        //拒绝
        dispatch_async(dispatch_get_main_queue(), ^{
            [Alert alert:@"请将'设置->隐私->照片->'设置为读取和写入." callback:^{
                //跳转到设置
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication]openURL:url];
            }];
        });
        showCompleted(NO);
        
    }else{
        isChoosePhoto =YES;
        if(camera_Instance==nil){
            [Camera shareInstance];
        }
        camera_Instance.callback = callback;
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            //         pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            pickerImage.mediaTypes =@[[NSString stringWithFormat:@"%@",kUTTypeImage]];
        }
        pickerImage.delegate = camera_Instance;
        pickerImage.allowsEditing = YES;
        pickerImage.modalPresentationStyle = UIModalPresentationFullScreen;
        [[camera_Instance getCurrentVC] presentViewController:pickerImage animated:YES completion:^{
            showCompleted(YES);
        }];
        
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.movie"]) {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        if (!isChoosePhoto) {
            self.videoCallback(videoURL);
        }
    }
    else{
        UIImage *image = nil;
        if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){//如果打开相册
            image = [info objectForKey:UIImagePickerControllerMediaURL];
        }
        else{//照相机
            image = [info objectForKey:UIImagePickerControllerEditedImage];
            if (!image){
                image = [info objectForKey:UIImagePickerControllerOriginalImage];
            }
        }
		dispatch_async(dispatch_get_main_queue(), ^{
			if (self.callback) {
				self.callback(image);
			}
		});
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
