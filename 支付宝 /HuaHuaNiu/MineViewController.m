//
//  MineViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "MineViewController.h"
#import "SmaView.h"

#import "LogViewController.h"
#import "InViteViewController.h"
#import "WoDeViewController.h"
#import "GeRenCencentViewController.h"
#import "FaBuViewController.h"
#import "ZJGLViewController.h"
#import "SetViewController.h"
#import "HelpViewController.h"

#import "ZJGLNViewController.h"
#import "WZMTTableViewController.h"
#import "ShouCangViewController.h"
#import "DaiJinQuanViewController.h"
#import "TureViewController.h"
#import "RegistViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "Toast+UIView.h"

@interface MineViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic)UIImagePickerController * imagePikerViewController;//拍照，获取头像

@property (weak, nonatomic) IBOutlet UIButton *zjglBtn;//资金管理按钮
@property (weak, nonatomic) IBOutlet UIScrollView *mineScrollView;//我的页面的滑动VIEW
@property (weak, nonatomic) IBOutlet UIButton *setBtn;//设置按钮
@property (weak, nonatomic) IBOutlet UIButton *qdBtn;//签到按钮
@property (weak, nonatomic) IBOutlet UIButton *rzzxBtn;//认证中心按钮
@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;//昵称
@property (weak, nonatomic) IBOutlet UILabel *qianLbl;//签名
@property (weak, nonatomic) IBOutlet UIView *topView;//头部视图

@property (strong,nonatomic) UIButton *imaView;//头像

@end

@implementation MineViewController
{
    SmaView * sV ;
    BOOL Enter;  // 判断是否登录   yes  未登录
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self XinXi];
    [self viewWithStyle];
    [self makeTopView];
    [self initImagePickerView];
  
}

-(void)viewWithStyle{
    self.setBtn.layer.cornerRadius=5;
    self.qdBtn.layer.cornerRadius=5;
    [self.rzzxBtn addTarget:self action:@selector(rzDo:) forControlEvents:UIControlEventTouchUpInside];
    [self.zjglBtn addTarget:self action:@selector(zjglDo:) forControlEvents:UIControlEventTouchUpInside];

}
//点击认证中心
-(void)rzDo:(id)sender{
    WZMTTableViewController *VC=[[WZMTTableViewController alloc]init];
    VC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:VC animated:YES];

}
//点击资金管理
-(void)zjglDo:(id)sender{
    ZJGLNViewController *vc=[[ZJGLNViewController alloc]init];
    vc .hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];

}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)makeTopView{
        
        IOS_Frame
        if (_topView) {
            
        }
        else{
            
//            _topView =[[UIView alloc]initWithFrame:CGRectMake(0,0 ,ConentViewWidth , 170)];
            _topView.backgroundColor =[UIColor whiteColor];
//            UIImageView *baIma =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 150)];
//            baIma.image =[UIImage imageNamed:@"background"];
//            
//            [_topView addSubview:baIma];
            
        }
    
    [self.setBtn addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.qdBtn addTarget:self action:@selector(qdAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
        _imaView =[[UIButton alloc]init];
        _imaView.frame =CGRectMake(20,60, 75, 75);
        _imaView.layer.masksToBounds  = YES;
        _imaView.layer.cornerRadius = 37;
        [_imaView setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        [_imaView addTarget:self action:@selector(takephoto) forControlEvents:UIControlEventTouchUpInside];
        [self initImagePickerView];
    
    
    
        [_topView addSubview:_imaView];
        for (int i = 0 ; i<2; i++) {
            NSArray * DengArr =@[@"登录",@"注册"];
            UIButton *Btn =[UIButton buttonWithType:UIButtonTypeCustom];
            Btn.layer.cornerRadius = 4;
            [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            Btn.tag =  31+i;
            [Btn setBackgroundColor: [UIColor whiteColor]];
            [Btn setTitle:DengArr[i] forState:UIControlStateNormal];
            
            UILabel * Lbe =[[UILabel alloc]init];
            
            Lbe.textColor=[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
            if (i == 0) {
                Btn.frame =CGRectMake(120, 100, 70, 30);
                [Btn addTarget:self action:@selector(DengLutAction) forControlEvents:UIControlEventTouchUpInside];
                
                
                Lbe.frame =CGRectMake(120, 90, 180, 20);
                Lbe.font =[UIFont systemFontOfSize:13];
                NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
                Lbe.tag =33;
                Lbe.text =[NSString stringWithFormat:@"昵称：%@", [userdefault objectForKey:@"UserName"]];
                
            }
            else if ( i == 1){
                NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
                Lbe.tag =34;
                Btn.frame =CGRectMake(200, 100, 70, 30);
                [Btn addTarget:self action:@selector(ZhuCeccAction) forControlEvents:UIControlEventTouchUpInside];
                
                
                Lbe.frame =CGRectMake(120, 115, 200, 20);
                Lbe.font =[UIFont systemFontOfSize:12];
                Lbe.text =[NSString stringWithFormat:@"个性签名:%@",[userdefault objectForKey:@"qianming"]];
                
            }
            [_topView addSubview: Btn];
            [_topView addSubview:Lbe];
            
        }
}
-(void)viewWillAppear:(BOOL)animated{
    UIButton   *btn =(UIButton *)[self.view viewWithTag:31];
    UIButton *  btnw =(UIButton *)[self.view viewWithTag:32];
    
    UILabel * labe =(UILabel *)[self.view viewWithTag:33];
    UILabel * labee =(UILabel *)[self.view viewWithTag:34];
    // userdefault 定义登录状态
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    if (!UserID.length ==  0) {// 未登录
        Enter = NO;
    }
    else{
        Enter =YES;
    }
    if (Enter) {// 未登录
        
        
        btn.hidden = NO;
        btnw.hidden = NO;
        labe.hidden = YES;
        labee.hidden = YES;
    }
    // 登录
    else{
        btn.hidden = YES;
        btnw.hidden = YES;
        labee.hidden = NO;
        labe.hidden = NO;
        //        NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
        NSString *ShouY = [NSString stringWithFormat:mainUrl];
        NSLog(@" shouYie =%@ ",ShouY);
        NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",@"",@"adfloor",@"413",@"ll",[UserDefault objectForKey:@"Useid"],@"member_id",nil];
        NSLog(@"dict is =%@",dict);
        
        [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary * data) {
            NSLog(@"this is data = %@",data);
            if ([data objectForKey:@"error"]) {
                //            [self.view hideToastActivity];
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
            }else{
                _str= [NSString stringWithFormat:@"%@",[data objectForKey:@"notReadMsg"]];
                
                
                
                //                [sV setWithImaStr:@"我的消息" AndLabelStr:@"" WoDeLable:_str];
                [self XinXi];
                if (![[NSString stringWithFormat:@"%@",[data objectForKey:@"notReadMsg"]] isEqualToString:@"0"]) {
                    self.navigationController.tabBarItem.badgeValue= [NSString stringWithFormat:@"%@",[data objectForKey:@"notReadMsg"] ];
                }
                
            }
        }];
        
        //  Lbe.hidden = YES;
        
    }
    
    for (int  i = 0 ; i<2; i++) {
        NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
        
        UILabel *Lae  = (UILabel *)[_topView viewWithTag:33+i];
        if (i == 0) {
            Lae.text =[NSString stringWithFormat:@"昵称：%@", [userdefault objectForKey:@"UserName"]];
            
        }
        else{
            Lae.text =[NSString stringWithFormat:@"签名：%@", [userdefault objectForKey:@"qianming"]];
            
        }
      

    }
      self.navigationController.navigationBar.hidden = YES;
      
    
}

-(void)DengLutAction{
    //(@"登录");
    LogViewController *Lvc =[[LogViewController alloc]init];
    Lvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Lvc animated:YES];
    // 登录之后 要重新给TopView赋值
    
}
-(void)ZhuCeccAction{
    RegistViewController *Rvc =[[RegistViewController alloc]init];
    Rvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Rvc animated:YES];
    //(@"注册");
}

//加载收藏等
-(void)XinXi{
    NSArray *titleArr =@[@"收藏",@"我的发布",@"邀请代言人",@"代金券",@"免费领",@"帮助中心",@"设置"];
    
    NSArray *imaaaArr =@[@"app_yaoqingfans_wode",@"icon_reply.png",@"app_gerenzhongxin_wode",@"app_aboutus_wode",@"app_zijinguanli_wode",@"app_shezhi_wode",@"icon_customize_activitys"];
    // 关于我们  暂时隐藏起来  出来的时候循环改为5
    for (int i = 0 ;i<7;i++){
        sV =[[[NSBundle mainBundle]loadNibNamed:@"SmaView" owner:self options:nil] lastObject];
        
        //        [sV setWithImaStr:imaaaArr[i] AndLabelStr:titleArr[i]];
        NSLog(@"%@",_str);
        if (i==1) {
            [sV setWithImaStr:imaaaArr[i] AndLabelStr:titleArr[i] WoDeLable:_str];
            
            sV.Label.layer.cornerRadius=10;
            sV.Label.clipsToBounds=YES;
        }else{
            [sV setWithImaStr:imaaaArr[i] AndLabelStr:titleArr[i] WoDeLable:@""];
            sV.Label.hidden=YES;
        }
        
        sV.tag = 50+i;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        [sV addGestureRecognizer:tap];
        if (i<1) {
            sV.frame =CGRectMake(0,40*i+345+10, ConentViewWidth+20 , 39);
        }
        else if(i<7){
            sV.frame =CGRectMake(0,40*i+345+10, ConentViewWidth+20 , 39);
        }
        
        [self.mineScrollView addSubview:sV];
    }
    
}

-(void)TapAction:(UITapGestureRecognizer *)tap{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        logview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logview animated:YES];
        
    }
    else
    {
        if (tap.view.tag ==50) {
            //收藏
            ShouCangViewController *Svc =[[ShouCangViewController alloc]init];
            Svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Svc animated:YES];
            
        }
        else if(tap.view.tag ==51){
            //我的发布
            FaBuViewController *fvc =[[FaBuViewController alloc]initWithNibName:@"FaBuViewController" bundle:nil];
            fvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fvc animated:YES];
            
            
        }
        
        else if(tap.view.tag ==52){
            //邀请代言人
            InViteViewController *Ivc =[[InViteViewController alloc]init];
            Ivc.hidesBottomBarWhenPushed = YES;
            [self.navigationController  pushViewController:Ivc animated:YES];
            
        }
        else if(tap.view.tag ==53){
            //代金券
            DaiJinQuanViewController *Dvc =[[DaiJinQuanViewController alloc]init];
            Dvc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:Dvc animated:YES];
            
        }
        else if(tap.view.tag ==54){
            //免费领
            TureViewController *TVC =[[TureViewController alloc]init];
            TVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:TVC  animated:YES];
        }
        else if(tap.view.tag ==55){
            //帮助中心
            HelpViewController *Svc =[[HelpViewController alloc]init];
            //        Svc.currentPhoneNumber =
            //添加标示
            Svc.idStr = @"帮助详情";
            Svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Svc animated:YES];
            
        }
        else if(tap.view.tag ==56){
            //设置中心
             SetViewController*Svc =[[SetViewController alloc]initWithEnter:Enter];
            Svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Svc animated:YES];
        }
    }
    
}
//topview上的设置
-(void)setAction:(id)sender{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        logview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logview animated:YES];
        
    }
    else{
        SetViewController*Svc =[[SetViewController alloc]initWithEnter:Enter];
        Svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Svc animated:YES];
    
    }

}
//签到
-(void)qdAction:(id)sender{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        logview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logview animated:YES];
        
    }
    else{
//        SetViewController*Svc =[[SetViewController alloc]initWithEnter:Enter];
//        Svc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:Svc animated:YES];
        
    }
    
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
    
    //来源于相机
    if(buttonIndex == 0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];  // 获取对摄像头的访问权限
        
        if(authStatus != AVAuthorizationStatusDenied && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePikerViewController.showsCameraControls = YES;
            
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
            
        }else{
            //            [self showHint:ERROR_Camera_NoPermission];
            //应该给出相应提示
        }
        
    }
    else if(buttonIndex == 1)
    {
        
        
                //来源于相册
            self.imagePikerViewController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePikerViewController animated:YES completion:NULL];
        
            self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:nil action:nil];
        
        
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

        UIImage *images = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [_imaView setImage:images forState:UIControlStateNormal];
    
    }

}

#pragma mark ---向服务器上传头像图片
-(void)requestUploadImage:(UIImage *)image
{
//    [self.view makeToastActivity];
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
//            //NSData *data = UIImagePNGRepresentation(image);
//            [formData appendPartWithFileData:data name:@"Filedata"fileName:@"test.jpg"mimeType:@"image/jpg"];
//        } //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
    }success:^(AFHTTPRequestOperation *operation,id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        
        //        [self.view hideToastActivity];
        //        //保存分享链接上传的图片地址
        //        NSString *str=[responseObject objectForKey:@"files"];
        //        [_link_pic addObject:str];
        
        // upload succ
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"图片上传失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        NSLog(@"#######upload error%@", error);
    }];
    
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
