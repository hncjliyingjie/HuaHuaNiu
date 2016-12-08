//
//  JIanJieViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "JIanJieViewController.h"

@interface JIanJieViewController ()

@end

@implementation JIanJieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self  makeJUI];
    [self makeConcent];
    
    self.navigationItem.title=@"公司简介";
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
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)makeJUI{
 
    BackScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight -49)];
    BackScroll.backgroundColor = [UIColor whiteColor];
    BackScroll.contentSize =CGSizeMake(ConentViewWidth, 1000);
    BackScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:BackScroll];
    
    
    // 顶部电话
    UIImageView * imaVie =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 40)];
    imaVie.image =[UIImage imageNamed:@"rexian"];
    imaVie.userInteractionEnabled = YES;
    UITapGestureRecognizer * Tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAACtio)];
    [imaVie addGestureRecognizer:Tap];
    
    [BackScroll addSubview:imaVie];
    UILabel * Label =[[UILabel alloc]initWithFrame:CGRectMake(0, 40, ConentViewWidth, 30)];
    Label.textAlignment =NSTextAlignmentCenter;
    
    Label.font =[UIFont systemFontOfSize:18];

    
    Label.text =@"关于笨笨鸟";
    [BackScroll addSubview:Label];
    
    // 顶部图片
    UIImageView *baView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 70, ConentViewWidth, 100)];
    baView.image =[UIImage imageNamed: @"default"];
    [BackScroll addSubview:baView];
    




}

-(void)makeConcent{

#pragma mark 概况
    UILabel *GKL =[[UILabel  alloc]initWithFrame:CGRectMake(20, 180, 100, 30)];
    GKL.text =@"概况";
   // 一行的字数
      // concenet/(290/26)
    
    int number = (ConentViewWidth -30)/(290/26);
    
    UILabel *GKlabel =[[UILabel alloc]initWithFrame:CGRectMake(GKL.frame.origin.x,GKL.frame.origin.y+GKL.frame.size.height, ConentViewWidth-30, 30)];
    GKlabel.text =@"河南笨笨鸟科技有限公司是一家专注于移动互联网平台创新和产品运营的电子商务公司，笨笨鸟始终坚持创新商业模式，实现多方共赢为核心竞争力，于国内首创“人人皆为代言人”的新型盈利模式，通过线上用户和商家的代言互动和线下代理的用心的配送，以及众多商家的营销推送来达到一种良性的生态平衡，打造多方受益，用户最大的互联网平台。实现互联网以人为本，一切围绕人行为展开的最高境界。";
    GKlabel.frame =CGRectMake(GKlabel.frame.origin.x, GKlabel.frame.origin.y, GKlabel.frame.size.width, 15 * GKlabel.text.length/number +15);
    
    GKlabel.font =[UIFont systemFontOfSize:11];
    GKlabel.numberOfLines = 0;
    [BackScroll addSubview:GKlabel];
    GKL.textColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [BackScroll addSubview:GKL];
    
#pragma mark 企业文化
    
    UILabel *QYWH =[[UILabel  alloc]initWithFrame:CGRectMake(GKlabel.frame.origin.x, GKlabel.frame.origin.y+GKlabel.frame.size.height, 100, 30)];
    QYWH.text =@"企业文化";
    QYWH.textColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [BackScroll addSubview:QYWH];
    
    UILabel *QUWHlabel =[[UILabel alloc]initWithFrame:CGRectMake(QYWH.frame.origin.x, QYWH.frame.origin.y+QYWH.frame.size.height, ConentViewWidth-30, 30)];
    QUWHlabel.font =[UIFont systemFontOfSize:11];
    QUWHlabel.numberOfLines = 0;
    QUWHlabel.text =@"企业理念：梦想无极限  分享更精彩\n企业使命：传承智慧  用心服务 共创美好生活\n企业精神：专业 责任 创新 分享\n企业价值观：服务为本 尊重个人  助力行业  共赢未来\n企业口号：相信 成长 我们在一起";
    QUWHlabel.frame =CGRectMake(QUWHlabel.frame.origin.x, QUWHlabel.frame.origin.y, QUWHlabel.frame.size.width, 15 * QUWHlabel.text.length/number +15);
    [BackScroll addSubview:QUWHlabel];

   
#pragma mark 企业口号
    UILabel *QYKH =[[UILabel  alloc]initWithFrame:CGRectMake(QUWHlabel.frame.origin.x, QUWHlabel.frame.origin.y+QUWHlabel.frame.size.height, 100, 30)];
    QYKH.text =@"企业口号";
    QYKH.textColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    
    [BackScroll addSubview:QYKH];

    UILabel *QYKHlabel =[[UILabel alloc]initWithFrame:CGRectMake(QYKH.frame.origin.x, QYKH.frame.origin.y+QYKH.frame.size.height, ConentViewWidth-30, 30)];
    QYKHlabel.text =@"企业口号：相信 成长 我们在一起";
    
     QYKHlabel.frame =CGRectMake(QYKHlabel.frame.origin.x, QYKHlabel.frame.origin.y, QYKHlabel.frame.size.width, 15 * QYKHlabel.text.length/number +15);
    QYKHlabel.font =[UIFont systemFontOfSize:11];
    QYKHlabel.numberOfLines = 0;
    
    [BackScroll addSubview:QYKHlabel];
    

    
    
    
#pragma mark 愿景目标
    UILabel *YJMB =[[UILabel  alloc]initWithFrame:CGRectMake(QYKHlabel.frame.origin.x, QYKHlabel.frame.origin.y+QYKHlabel.frame.size.height, 100, 30)];
    YJMB.text =@"愿景目标";
    YJMB.textColor =[UIColor colorWithRed:246/255.0 green:125/255.0 blue:137/255.0 alpha:1];
    [BackScroll addSubview:YJMB];
    
    UILabel *YJMBlabel =[[UILabel alloc]initWithFrame:CGRectMake(YJMB.frame.origin.x, YJMB.frame.origin.y+YJMB.frame.size.height, ConentViewWidth-30, 30)];
    YJMBlabel.text =@"笨笨鸟公司本着“一切为用户着想，助商家发展腾飞”为公司经营理念，以帮助别人，快乐大家为企业文化，以创新商业模式，打造全国平台为公司目标，致力于移动互联网创新模式的发展，同时我们拥有一批高级专业人才，从公司战略，数据分析，产品结构，平台运营和优质服务等方面提供全套方案，助企业插上互联网腾飞的翅膀，让用户享受移动互联网发展的盛宴， 代言城是笨笨鸟公司旗下的主打产品，以用来为商家代言。平台给用户奖励的新颖模式让用户在享受服务的同时轻松愉悦的赚钱。";
    YJMBlabel.frame =CGRectMake(YJMBlabel.frame.origin.x, YJMBlabel.frame.origin.y, YJMBlabel.frame.size.width, 15 * YJMBlabel.text.length/number +15);

    
    YJMBlabel.font =[UIFont systemFontOfSize:11];
    YJMBlabel.numberOfLines = 0;

    BackScroll.contentSize= CGSizeMake(ConentViewWidth,  YJMBlabel.frame.origin.y+YJMBlabel.frame.size.height);
    [BackScroll addSubview:YJMBlabel];
    

}











-(void)TapAACtio{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://037165990055"]];
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
