//
//  ZXViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZXViewController.h"
#import "PlaceholderTextView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "Toast+UIView.h"
#import "MBProgressHUD.h"
@interface ZXViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *photo_btn;//显示照片的按钮
- (IBAction)takePhotoAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;//一句话描述textview

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步按钮

@property (weak, nonatomic) IBOutlet UILabel *slLbl;//示例

@property (weak, nonatomic) IBOutlet UIButton *ncLbl;//内参

@property (weak, nonatomic) IBOutlet UIButton *zhLbl;//展会

@property (weak, nonatomic) IBOutlet UIButton *pxLbl;//培训

@property (weak, nonatomic) IBOutlet UIButton *hdLbl;//活动心得
@property (weak, nonatomic) IBOutlet UITextField *textField;//链接地址

@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;//拍照，获取头像
@property (strong,nonatomic)NSString * imgStr;//服务器获取的图片地址
@property (strong,nonatomic)NSMutableArray * buttonArray;//内参等按钮的数组
@end

@implementation ZXViewController
{
    NSString *type;//用户选择的类型

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发布资讯";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self viewWithStyle];
   
}
-(void)viewWithStyle{
    
    self.ncLbl.layer.cornerRadius=5;
    self.ncLbl.layer.borderWidth=0.5;
    self.ncLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    [self.ncLbl addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
    [self.ncLbl setTitle:@"内参" forState:UIControlStateNormal];
    self.ncLbl.tag=0;
    
    self.zhLbl.layer.cornerRadius=5;
    self.zhLbl.layer.borderWidth=0.5;
    self.zhLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    [self.zhLbl addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
    self.zhLbl.tag=1;
    
    self.pxLbl.layer.cornerRadius=5;
    self.pxLbl.layer.borderWidth=0.5;
    self.pxLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    [self.pxLbl addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
    self.pxLbl.tag=2;
    
    self.hdLbl.layer.cornerRadius=5;
    self.hdLbl.layer.borderWidth=0.5;
    self.hdLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
     [self.hdLbl addTarget:self action:@selector(changed:) forControlEvents:UIControlEventTouchUpInside];
    self.hdLbl.tag=3;
    
    [self.buttonArray addObject:self.ncLbl];
     [self.buttonArray addObject:self.zhLbl];
     [self.buttonArray addObject:self.pxLbl];
     [self.buttonArray addObject:self.hdLbl];
    
    self.slLbl.layer.cornerRadius=5;
    self.slLbl.layer.borderWidth=0.5;
    self.slLbl.layer.masksToBounds=YES;
    self.slLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.nextBtn.layer.cornerRadius=5;
    
    self.textView.Placeholder=@"一句话描述任务，不超过40字。";
    [self initImagePickerView];
    
}
//点击类型
-(void)changed:(id)sender
{
    UIButton *senderBtn=sender;
    NSLog(@"当前点击的按钮%ld",senderBtn.tag);
    for (UIButton *btn in self.buttonArray)
    {
        if (senderBtn.tag==btn.tag)
        {
             NSLog(@"遍历的按钮%ld",btn.tag);
             btn.layer.borderColor=[UIColor blueColor].CGColor;
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            type=[NSString stringWithFormat:@"%ld",btn.tag];
        }
        else
        {
           btn.layer.borderColor=[UIColor grayColor].CGColor;
          btn.titleLabel.textColor=[UIColor grayColor];
         [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        }
    }

}
//点击上传图片按钮
- (IBAction)takePhotoAction:(id)sender
{
    [self takephoto];
}
//提交
- (IBAction)nextAction:(id)sender {
    
    [self subMit];
}

-(void)initImagePickerView
{
    self.imagePikerViewController = [[UIImagePickerController alloc] init];
    self.imagePikerViewController.delegate = self;
    self.imagePikerViewController.allowsEditing = YES;
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
#pragma mark 发布提交
-(void)subMit
{
    [self.view makeToastActivity];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSString *title=self.textView.text;
    NSString *imgUrl=self.textField.text;
    NSString * ShouY = [NSString stringWithFormat:FBZXURL,UserIDs,type,imgUrl,title,_imgStr];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"提交成功返回的数据%@",responseObject);
        
        [self.view hideToastActivity];
        [self showHint:@"提交成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        [self showHint:@"提交失败"];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];

}
- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    //    hud.yOffset = IS_IPHONE_5?10.f:10.f;//修改了显示位置
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

#pragma mark ---向服务器上传头像图片
-(void)requestUploadImage:(UIImage *)image
{
    [self.view makeToastActivity];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    
    [manager POST:PICTUREURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //        for (int i=0; i<imageArray.count; i++) {
        //            UIImage *img=[imageArray objectAtIndex:i];
        //            //对于图片进行压缩
        //            //UIImage *image = [UIImage imageNamed:@"111"];
        //            NSData *data = UIImageJPEGRepresentation(img, 0.1);
                    NSData *data = UIImagePNGRepresentation(image);
                    [formData appendPartWithFileData:data name:@"Filedata"fileName:@"test.jpg"mimeType:@"image/jpg"];
        //        } //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        
        [self.view hideToastActivity];
       
        //保存上传的图片地址
        NSArray *array=[responseObject objectForKey:@"files"];
        NSMutableArray *secounArray=[NSMutableArray array];
        for (int i=0; i<array.count; i++) {
            NSString *img=[array objectAtIndex:i];
            [secounArray addObject:img];
            
        }
        _imgStr=[secounArray objectAtIndex:0];
//        判断图像头部有没有http
//        NSString *urlStr=[responseObject objectForKey:@"files"];
        NSString *str=@"http://";
        //代言城返回的图片
        NSString *headUrl=[NSString stringWithFormat:@"http://101.200.90.192:8180/dyc/%@",_imgStr];
        
        NSString *url;
        if ([_imgStr rangeOfString:str].location!=NSNotFound)
        {
            url=_imgStr;
        }
        else
        {
            url=headUrl;
            
        }
        UIImage *imgs=[self getImageFromURL:url];
        //显示图片
        [self.photo_btn setImage:imgs forState:UIControlStateNormal];
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        NSLog(@"#######upload error%@", error);
    }];
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
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
-(NSMutableArray *)buttonArray{
    if (_buttonArray==nil) {
        _buttonArray=[NSMutableArray array];
    }
    return _buttonArray;

}
@end
