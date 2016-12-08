//
//  GjrzViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "GjrzViewController.h"
#import "AddKfViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface GjrzViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;//拍照，获取头像

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步按钮
@property (weak, nonatomic) IBOutlet UIButton *kfBtn;//客服按钮
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;//点击微信号上传个人信息截图

@property (weak, nonatomic) IBOutlet UIButton *hyBtn;//上传好友数截图


@end

@implementation GjrzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"高级认证";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    //给XIB中的控件设置圆角添加按钮
    [self viewWithStyle];
     [self initImagePickerView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWithStyle{
    self.nextBtn.layer.cornerRadius=15;
//    self.nextBtn.layer.masksToBounds=YES;
    [self.nextBtn addTarget:self action:@selector(nextDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.kfBtn addTarget:self action:@selector(kfDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.wxBtn addTarget:self action:@selector(wxDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.hyBtn addTarget:self action:@selector(hyDo:) forControlEvents:UIControlEventTouchUpInside];
    
    

}
-(void)initImagePickerView
{
    self.imagePikerViewController = [[UIImagePickerController alloc] init];
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.allowsEditing = YES;
}
//上传个人信息截图
-(void)wxDo:(id)sender{
    [self takephoto];
    
}
//上传好友数截图
-(void)hyDo:(id)sender{
    [self takephoto];
    
}
//下一步
-(void)nextDo:(id)sender{
   

}
//点击联系客服
-(void)kfDo:(id)sender{
    
    AddKfViewController *vc=[[AddKfViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---点击头像，弹出照相选择器
-(void)takephoto
{
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"拍照" ,@"从手机相册选取", nil];
    [actionSheet showInView:self.view];
}

#pragma mark --- UIActionSheetDelegate <NSObject>
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(buttonIndex == 2)
        return;
    
    if(buttonIndex == 0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];  // 获取对摄像头的访问权限
        
        if(authStatus != AVAuthorizationStatusDenied && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePikerViewController.showsCameraControls = YES;
            
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
            
        }else{
            //[self showHint:ERROR_Camera_NoPermission];
            //应该给出相应提示
        }
        
    }
    else if(buttonIndex == 1)
    {
        self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
    }
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera ||
        picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary ||
        picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        
        NSData *data;
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        //将二进制数据生成UIImage
        UIImage *image = [UIImage imageWithData:data];
        [self requestUploadImage:image];
    }
    
}

#pragma mark ---向服务器上传头像图片
-(void)requestUploadImage:(UIImage *)image
{
    //    [[TTIHttpClient sharedClient]  uploadSinglePicturesRequestWithphotoFile:image
    //                                                                 folderName:@"folderName"
    //                                                               successBlock:^(TTIRequest *request, TTIResponse *response)
    //     {
    //         _photoImgView.image  = image;
    //         PictureModel *model = response.responseModel;
    //         photoUrl  = model.picturePath;
    //
    //     } failedBlock:^(TTIRequest *request, TTIResponse *response)
    //     {
    //     }];
    
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
