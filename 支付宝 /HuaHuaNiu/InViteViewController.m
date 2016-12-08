//
//  InViteViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "InViteViewController.h"
#import "AFNetworking.h"
#import "LogViewController.h"
#import "UMSocial.h"
#import "CoreUmengShare.h"

@interface InViteViewController ()

@end

@implementation InViteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // 邀请粉丝
    [self makeYaoqingData];
    [self makeUI];
}
#pragma mark 邀请粉丝
-(void)makeYaoqingData{
}

-(void)makeUI{
    NSUserDefaults * userdefaults=[NSUserDefaults standardUserDefaults];

    NSString  *urlStr  =[NSString stringWithFormat:INVITATE,[userdefaults objectForKey:@"Useid"]];
    self.navigationItem.title=@"二维码名片";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
    self.IconImage.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2, 50, 200, 250);

    self.IconImage.image =[QRCodeGenerator qrImageForString:urlStr imageSize:self.IconImage.bounds.size.width];
    [self.IconImage sizeToFit];
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(BackAction)];
    self.navigationItem.leftBarButtonItem = lbbItem;
    
#pragma mark - 添加 rightButton
    
    UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn1 setFrame:CGRectMake(0, 0, 15, 15)];
    [cancelBtn1 addTarget:self action:@selector(ShareActComeIn) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn1 setBackgroundImage:[UIImage imageNamed:@"app_top_fenxiang"] forState:UIControlStateNormal];
    [cancelBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn1.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *pauseBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn1];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: pauseBtn,nil]];

}

-(void)ShareActComeIn{
    
    NSUserDefaults * userdefaults=[NSUserDefaults standardUserDefaults];
    
    NSString  *Useid  =[userdefaults objectForKey:@"Useid"];
    NSString * ShareStr =[NSString stringWithFormat:FenXiangErWeiMa,Useid];
    //获取用户手机号
    NSString *Phone = [userdefaults objectForKey:@"Phone"];
    Phone = [Phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    NSString * concentStr =[NSString stringWithFormat:@"你的好友%@发现了一个赚钱利器快来试试吧",Phone];
    [UMSocialData defaultData].extConfig.qqData.url = ShareStr;
    [UMSocialData defaultData].extConfig.qzoneData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = ShareStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url =ShareStr;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5507c758fd98c5cdd1000244"
                                      shareText:concentStr
                                     shareImage:[UIImage imageNamed:@"60"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:nil];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"会员注册";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"会员注册";
    [UMSocialData defaultData].extConfig.qqData.title = @"会员注册";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"会员注册";
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
