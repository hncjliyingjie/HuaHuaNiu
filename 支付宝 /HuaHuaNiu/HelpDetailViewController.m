//
//  HelpDetailViewController.m
//  HuaHuaNiu
//
//  Created by alex on 15/12/25.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "HelpDetailViewController.h"
#import "HelpWebView.h"
#import "AFNetworking.h"

@interface HelpDetailViewController ()
@property (nonatomic,strong) UIWebView *web;
@end

@implementation HelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor =BackColor;
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
    
    UIWebView * web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    web.backgroundColor = [UIColor redColor];
    NSString *curent = [NSString stringWithFormat:@"<head><meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\"><style>img{max-width:310px !important;}</style></head>%@",self.currentStr];
    
    
    
        NSData *data = [curent dataUsingEncoding:NSUTF8StringEncoding];
    
        [data writeToFile:@"/Users/mac/Desktop/untitled.html" atomically:YES];
    
        NSData *fileData = [NSData dataWithContentsOfFile:@"/Users/mac/Desktop/untitled.html"];
        self.web.backgroundColor = [UIColor redColor];
        // 浏览器直接加载 二进制数据! MIMEType :文件类型 == "Content-Type" = "text/html;  textEncodingName :编码方式 baseURL:基准地址
        [self.web loadData:fileData MIMEType:nil textEncodingName:nil baseURL:[NSURL URLWithString:@"http://daiyancheng.cn/"]];
    self.web = web;
    

    [self.view addSubview:self.web];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setCurrentStr:(NSString *)currentStr{
    _currentStr = currentStr;
//    NSString *curent = [NSString stringWithFormat:@"<head><meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\"><style>img{max-width:310px !important;}</style></head>%@",currentStr];
//
//    NSData *data = [curent dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [data writeToFile:@"/Users/mac/Desktop/untitled.html" atomically:YES];
//    
//    NSData *fileData = [NSData dataWithContentsOfFile:@"/Users/mac/Desktop/untitled.html"];
//    self.web.backgroundColor = [UIColor redColor];
//    // 浏览器直接加载 二进制数据! MIMEType :文件类型 == "Content-Type" = "text/html;  textEncodingName :编码方式 baseURL:基准地址
//    [self.web loadData:fileData MIMEType:@"text/html" textEncodingName:nil baseURL:[NSURL URLWithString:@"http://daiyancheng.cn/"]];
//    
//    [self.view addSubview:self.web];
}

@end
