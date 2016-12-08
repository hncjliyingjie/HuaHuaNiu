//
//  YHHelpDetailViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHHelpDetailViewController.h"

@interface YHHelpDetailViewController ()
@property (nonatomic,strong) UIWebView *web;
@end

@implementation YHHelpDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationItem.title=@"帮助中心";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //拼接参数
    NSString *curent = [NSString stringWithFormat:@"<head><meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\"><style>img{max-width:310px !important;}</style></head>%@",self.currentStr];
    //加载 webVIew
    NSData *data = [curent dataUsingEncoding:NSUTF8StringEncoding];
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadData:data MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"http://daiyancheng.cn/"]];
    
    [self.view addSubview:web];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
