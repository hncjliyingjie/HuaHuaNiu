//
//  QudaiLiViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "QudaiLiViewController.h"
#import "ShenqingquyudaiViewController.h"
@interface QudaiLiViewController ()

@end

@implementation QudaiLiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"诚邀加入";
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
       [self.view addSubview:imaVie];
  
    UIImageView *iam =[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, 60)];
    iam.backgroundColor =BackColor;
    iam.image=[UIImage imageNamed:@"dailishengqing"];
    [self.view addSubview:iam];
    
    // 标题
    UILabel * BiaoTi=[[UILabel alloc]initWithFrame:CGRectMake(25, 110 , ConentViewWidth -50, 30)];
    BiaoTi.text =@"各区域代理商诚邀您的加入!";
    BiaoTi.textColor =[UIColor redColor];
[self.view addSubview:BiaoTi];
    
    /// 内容
    UILabel * concentLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 150, ConentViewWidth -60 ,120)];
    concentLabel.numberOfLines =0;
    concentLabel.font =[UIFont systemFontOfSize:13];
    concentLabel.text =@"移动互联网风暴来袭，眼球在哪里，经济就在哪里，如果您认可我们的经营模式，如果您认可我们的平台，就请加盟吧，让我们携手共创辉煌。";
    
    [self.view addSubview:concentLabel];
    
    
    UIButton * shenqinBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    shenqinBtn.frame =CGRectMake(10, ConentViewHeight - 40, ConentViewWidth -20, 30);
    [shenqinBtn setTitle:@"我要申请" forState:UIControlStateNormal];
    [shenqinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenqinBtn addTarget:self action:@selector(ShenAction) forControlEvents:UIControlEventTouchUpInside];
    shenqinBtn.backgroundColor =[UIColor colorWithRed:247/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    
    
    [self.view addSubview:shenqinBtn];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ShenAction{

    ShenqingquyudaiViewController * svc =[[ShenqingquyudaiViewController alloc]init];
    [self.navigationController pushViewController: svc animated:YES];

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
