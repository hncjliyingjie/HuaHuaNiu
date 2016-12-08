//
//  GUANGGAOViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "GUANGGAOViewController.h"

@interface GUANGGAOViewController ()

@end

@implementation GUANGGAOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"广告投放申请";
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
    [self makeSHangJRUIl];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeSHangJRUIl{
    
    
    // 顶部电话
    UIImageView * imaVie =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    imaVie.image =[UIImage imageNamed:@"rexian"];
    imaVie.userInteractionEnabled = YES;
    UITapGestureRecognizer * Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAACetio)];
    [imaVie addGestureRecognizer:Tap];
    
    [self.view addSubview:imaVie];
    // 顶部图片
    UIImageView *baView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, 200)];
    baView.image =[UIImage imageNamed: @"guanggoutoufang"];
    [self.view addSubview:baView];
    
    
//    UIImageView *baViewaa =[[UIImageView alloc]initWithFrame:CGRectMake(0, 160, ConentViewWidth, 80)];
//    baViewaa.image =[UIImage imageNamed: @"555.jpg"];
//    [self.view addSubview:baViewaa];
    
    
    //  申请步骤 1
    int number = (ConentViewWidth -30)/(290/26);
    UILabel *GKlabel =[[UILabel alloc]initWithFrame:CGRectMake(20,baView.frame.origin.y+baView.frame.size.height, ConentViewWidth-30, 30)];
    GKlabel.text =@"精准用户的投放，得到的即是你想要的，万千代言人的分类传播，让您和互联网互动起来，指尖上的财富瞬间拥有。";
    GKlabel.frame =CGRectMake(GKlabel.frame.origin.x, GKlabel.frame.origin.y, GKlabel.frame.size.width, 15 * GKlabel.text.length/number +15);
    
    GKlabel.font =[UIFont systemFontOfSize:11];
    GKlabel.numberOfLines = 0;
    [self.view  addSubview:GKlabel];

    
}
-(void)TapAACetio{
    
    //(@"打电话 ");
    
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
