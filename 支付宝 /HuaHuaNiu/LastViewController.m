//
//  LastViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "LastViewController.h"
#import "SmaView.h"
#import "LogViewController.h"
#import "BiglogView.h"
#import "GeRenCencentViewController.h"
#import "ZJGLViewController.h"
#import "SheZhiViewController.h"
#import "RegistViewController.h"
#import "InViteViewController.h"
#import "ShouCangViewController.h"
#import "GouWuCheViewController.h"
#import "UIImageView+WebCache.h"
#import "DingDanceViewController.h"
#import "HelpViewController.h"
#import "AFNetworking.h"
#import "FaBuViewController.h"
#import "WoDeViewController.h"
@interface LastViewController (){
    SmaView * sV ;
}

@end

@implementation LastViewController

-(void)makeZJdata{

    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];

    NSString * ShouY = [NSString stringWithFormat:YONGHUMessage, userID];

    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //(@"xxxxxxxx%@",responseObject);
        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
        [userDefault setObject:responseObject  forKey:@"gerenxinxi"];
        [userDefault synchronize];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
        //(@"cook load failed ,%@",error);
    }];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewDidLoad {
    //隐藏导航栏
     self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
//       
//    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
 //  logo
//    [self makeLeftTIem];
    [self refresh];
    [super viewDidLoad];
    [self makeUI];
    [self makeTopView];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeLeftTIem{
    UIImageView *leftIma =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftIma.image =[UIImage imageNamed:@"代言城-32px"];
    
    UIBarButtonItem *imaItem =[[UIBarButtonItem alloc]initWithCustomView:leftIma];
    self.navigationItem.leftBarButtonItem =imaItem;

}
-(void)makeTopView{
    
    IOS_Frame
    if (topVIew) {
        
    }
    else{
    
     topVIew =[[UIView alloc]initWithFrame:CGRectMake(0,0 ,ConentViewWidth , 230)];
     topVIew.backgroundColor =[UIColor whiteColor];
    UIImageView *baIma =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 160)];
    baIma.image =[UIImage imageNamed:@"app_myxinxi_bg.jpg"];
   
   [topVIew addSubview:baIma];

    }
       
    UIImageView *imaView =[[UIImageView alloc]init];
    imaView.frame =CGRectMake(20,15, 75, 75);
    imaView.layer.masksToBounds  = YES;
    imaView.layer.cornerRadius = 37;
    imaView.image =[UIImage imageNamed:@"未标题1-1"];
    [topVIew addSubview:imaView];
    for (int i = 0 ; i<2; i++) {
        NSArray * DengArr =@[@"登录",@"注册"];
        UIButton *Btn =[UIButton buttonWithType:UIButtonTypeCustom];
        Btn.layer.cornerRadius = 4;
        [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Btn.tag =  31+i;
        [Btn setBackgroundColor: [UIColor whiteColor]];
        [Btn setTitle:DengArr[i] forState:UIControlStateNormal];
        
        UILabel * Lbe =[[UILabel alloc]init];
     
        Lbe.textColor=[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
        if (i == 0) {
            Btn.frame =CGRectMake(120, 40, 70, 30);
            [Btn addTarget:self action:@selector(DengLutAction) forControlEvents:UIControlEventTouchUpInside];
            
            
            Lbe.frame =CGRectMake(120, 20, 180, 20);
            Lbe.font =[UIFont systemFontOfSize:13];
            NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
            Lbe.tag =33;
            Lbe.text =[NSString stringWithFormat:@"昵称：%@", [userdefault objectForKey:@"UserName"]];
            
            
//            UILabel *setLbl=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, ConentViewWidth, 30)];
//            setLbl.text=@"设置";
//            setLbl.backgroundColor=[UIColor redColor];
//            [topVIew addSubview:setLbl];
            
            
        }
        else if ( i == 1){
            NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
            Lbe.tag =34;
            Btn.frame =CGRectMake(200, 40, 70, 30);
            [Btn addTarget:self action:@selector(ZhuCeccAction) forControlEvents:UIControlEventTouchUpInside];
            

            Lbe.frame =CGRectMake(120, 60, 200, 20);
            Lbe.font =[UIFont systemFontOfSize:12];
       Lbe.text =[NSString stringWithFormat:@"个性签名:%@",[userdefault objectForKey:@"qianming"]];

        }
                [topVIew addSubview: Btn];
        [topVIew addSubview:Lbe];
 
   }

    NSArray *tetleArr =@[@"我的订单",@"我的购物车",@"我的收藏"];
    NSArray *ImaArr =@[@"app_dingdan_wode",@"app_gouwuche_wode",@"app_shoucang_wode"];
    for (int i = 0 ; i<3; i++) {
        UIButton *middleBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        middleBtn.frame =CGRectMake(20+ ConentViewWidth/3 *i, 170, 70, 70);
        middleBtn.tag = 120+i;
        [middleBtn setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
        UIImageView * imamaa =[[UIImageView alloc]init];
        
        imamaa.frame =CGRectMake(20+ 10+ ConentViewWidth/3 *i, 170, 45,30);
        imamaa.image =[UIImage imageNamed:ImaArr[i]];
        
        
        middleBtn.titleLabel.font =[UIFont systemFontOfSize:13];
        [middleBtn setTitle:tetleArr[i] forState:UIControlStateNormal];
        [middleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [middleBtn addTarget:self action:@selector(ActionInMiddleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topVIew addSubview:imamaa];
        [topVIew addSubview:middleBtn];
    }
    [BackScroll addSubview:topVIew];
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

        UILabel *Lae  = (UILabel *)[topVIew viewWithTag:33+i];
        if (i == 0) {
        Lae.text =[NSString stringWithFormat:@"昵称：%@", [userdefault objectForKey:@"UserName"]];

        }
       else{
         Lae.text =[NSString stringWithFormat:@"签名：%@", [userdefault objectForKey:@"qianming"]];
        
        }
        
        
        
     }


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
-(void)ActionInMiddleBtn:(UIButton *)Btn{
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
        
        
    }
    else{
    if (Btn.tag ==120){
        DingDanceViewController * dvc =[[DingDanceViewController alloc]init];
        dvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController: dvc animated:YES];
    }
    else if (Btn.tag ==121){
        GouWuCheViewController *Gvc =[[GouWuCheViewController alloc]init];
        Gvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Gvc animated:YES];
    }
    else if (Btn.tag ==122){
        ShouCangViewController *Svc =[[ShouCangViewController alloc]init];
        Svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Svc animated:YES];
    }
    }
  //  //(@"%ld",(long)Btn.tag);
}
-(void)refresh{
    UIButton *RigBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    RigBtn.frame =CGRectMake(0, 0, 40, 30);
    RigBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [RigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [RigBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [RigBtn addTarget:self action:@selector(RefreshAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)RefreshAction{
   //
    //(@"实现刷新");

}
-(void)makeUI{
     IOS_Frame
    BackScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    BackScroll.contentSize= CGSizeMake(ConentViewWidth, 500);
    BackScroll.showsHorizontalScrollIndicator = NO;
    BackScroll.showsVerticalScrollIndicator = NO;
    BackScroll.scrollEnabled = YES;
    BackScroll.pagingEnabled = NO;
 
    BackScroll.backgroundColor =BackColor;
    [self.view addSubview:BackScroll];
  // 未登录
    [self XinXi];
    
// 存放 图片的文字
//    NSArray *imArr =@[@""];
    //  退出登录
    
    UIButton *quitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame =CGRectMake(10,480, ConentViewWidth- 20, 30);
    if (ConentViewHeight > 568) {
        quitBtn.frame =CGRectMake(10,ConentViewHeight - 60 - 49, ConentViewWidth- 20, 30);

    }
    [quitBtn setTitle:@"切换用户" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitBtn setBackgroundColor:ZHUSE];
    [quitBtn addTarget:self action:@selector(QuitAction) forControlEvents:UIControlEventTouchUpInside];
    [BackScroll addSubview:quitBtn];
}
-(void)XinXi{
    NSArray *titleArr =@[@"邀请粉丝",@"我的消息",@"个人中心",@"我的发布",@"资金管理",@"设置",@"帮助中心"];
    
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
            sV.frame =CGRectMake(0,40*i+180, ConentViewWidth , 39);
        }
        else if(i<7){
            sV.frame =CGRectMake(0,40*i +190, ConentViewWidth , 39);
        }
        
        [BackScroll addSubview:sV];
    }

}
//头像点击
-(void)IconTapAction{
    //  更改图片
    UIAlertView *PhotoAlview =[[UIAlertView alloc]initWithTitle:@"更改头像" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册选取", nil];
    PhotoAlview.tag =22;
    [PhotoAlview show];
    //(@"dian ji le ");
}
-(void)QuitAction{
    // 如果登录状态
// 退出
    UIAlertView *AlView =[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"切换用户" otherButtonTitles:nil];
    AlView.tag = 21;
    [AlView show];
    
    // 如果未登录
    //(@"退出");
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
         //  判断是否登录  进行处理
    //判断 AlerVIew
    if (alertView.tag == 21) {
        if(buttonIndex ==0){
            //(@"退出登录");
            Enter = YES;
            
            
            UIButton   *btn =(UIButton *)[self.view viewWithTag:31];
            UIButton *  btnw =(UIButton *)[self.view viewWithTag:32];
            
            UILabel * labe =(UILabel *)[self.view viewWithTag:33];
            UILabel * labee =(UILabel *)[self.view viewWithTag:34];
            // userdefault 定义登录状态
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
                //  Lbe.hidden = YES;
                
            }

            
            
         
            
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSString *  DingWeistr =[NSString stringWithFormat:@"%@",[defs objectForKey:@"ZUOBIAO"]];
            
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isfirstcome"];
            [[NSUserDefaults standardUserDefaults]setObject:DingWeistr forKey:@"ZUOBIAO"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            LogViewController *Lvc =[[LogViewController alloc]init];
            Lvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:Lvc animated:YES];

        }
        
    }
    //  选择照片的 AlerView
    else if (alertView.tag ==22){
        if (buttonIndex == 0) {
          //  //(@"取消");
        }
        else if(buttonIndex ==1){
            // 开始拍照
            //(@"拍照");
           //  检测是否可以使用相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker =[[UIImagePickerController alloc]init];
                picker.delegate =self;
                // 图片不可编辑
                picker.allowsEditing = NO;
                [self presentViewController:picker animated:YES completion:^{
            
                }];
                
            }
            else{
                //(@"模拟器 无法使用相机请在真机中测试");
            }
          
        }
        else if(buttonIndex ==2){
            // 打开本地相册
            UIImagePickerController *picker =[[UIImagePickerController alloc]init];
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate =self;
            picker.allowsEditing = NO;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
            //(@"相册选择");
        }
    }
}
// 图片选择完之后 进入此方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    Bvc.IconImage.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)TapAction:(UITapGestureRecognizer *)tap{

    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
        
    }
        else{
    if (tap.view.tag ==50) {
        InViteViewController *Ivc =[[InViteViewController alloc]init];
        Ivc.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:Ivc animated:YES];
    
    }
    else if(tap.view.tag ==51){
        
        WoDeViewController *Gvc =[[WoDeViewController alloc]init];
        Gvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Gvc animated:YES];
        
        
    }

    else if(tap.view.tag ==52){
        
        GeRenCencentViewController *Gvc =[[GeRenCencentViewController alloc]init];
        Gvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Gvc animated:YES];
        

    }
    else if(tap.view.tag ==53){
        
        FaBuViewController *fvc =[[FaBuViewController alloc]initWithNibName:@"FaBuViewController" bundle:nil];
        fvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fvc animated:YES];
        
        
    }
    else if(tap.view.tag ==54){
        ZJGLViewController *Zvc =[[ZJGLViewController alloc]init];
        Zvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Zvc animated:YES];
    }else if(tap.view.tag ==55){
        SheZhiViewController *Svc =[[SheZhiViewController alloc]init];
//        Svc.currentPhoneNumber =
        Svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Svc animated:YES];
    }else if(tap.view.tag ==56){
        HelpViewController *Svc =[[HelpViewController alloc]init];
        //        Svc.currentPhoneNumber =
        //添加标示
        Svc.idStr = @"帮助详情";
        Svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Svc animated:YES];
    }
    }
    
}
-(void)logAction{// //(@"登陆");
    LogViewController *loVc =[[LogViewController alloc]init];
    [self.navigationController pushViewController:loVc animated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
