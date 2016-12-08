//
//  ShangJRZViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShangJRZViewController.h"

@interface ShangJRZViewController ()

@end

@implementation ShangJRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"商家入驻申请";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self makeSHangJRUI];
}
-(void)makeSHangJRUI{

    
    // 顶部电话
    UIImageView * imaVie =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    imaVie.image =[UIImage imageNamed:@"rexian"];
    imaVie.userInteractionEnabled = YES;
    UITapGestureRecognizer * Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAACetio)];
    [imaVie addGestureRecognizer:Tap];
    
    [self.view addSubview:imaVie];
    // 顶部图片
    UIImageView *baView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, 200)];
    baView.image =[UIImage imageNamed: @"shangjiaruzhu"];
    [self.view addSubview:baView];
//    
//   UIImageView *baViewaa =[[UIImageView alloc]initWithFrame:CGRectMake(0, 160, ConentViewWidth, 80)];
//    baViewaa.image =[UIImage imageNamed: @"shangjiaruzhu"];
//    [self.view addSubview:baViewaa];
    
    
    
    
    //  申请步骤 1 

    int number = (ConentViewWidth -30)/(290/26);
    UILabel *GKlabel =[[UILabel alloc]initWithFrame:CGRectMake(20,baView.frame.origin.y+baView.frame.size.height, ConentViewWidth-30, 30)];
    GKlabel.text =@"移动互联网让您插上腾飞的翅膀，一个广阔的平台在您眼前。来吧，动动手不出家门，让您的信息在轻轻松松就传播万里。";
    GKlabel.frame =CGRectMake(GKlabel.frame.origin.x, GKlabel.frame.origin.y, GKlabel.frame.size.width, 15 * GKlabel.text.length/number +15);
    
    GKlabel.font =[UIFont systemFontOfSize:11];
    GKlabel.numberOfLines = 0;
    [self.view  addSubview:GKlabel];



}
-(void)TapAACetio{

    //(@"打电话 ");

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
