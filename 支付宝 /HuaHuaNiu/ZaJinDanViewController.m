//
//  ZaJinDanViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ZaJinDanViewController.h"
#import "LogViewController.h"
#import "Toast+UIView.h"

extern NSString *str;

@interface ZaJinDanViewController ()

@end

@implementation ZaJinDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
   [self  makeJD];
    
    //返回按钮
    UIImage *lbbImage = [UIImage imageNamed:@"back_new"];
    lbbImage = [lbbImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * lbbItem = [[UIBarButtonItem alloc] initWithImage:lbbImage style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = lbbItem;
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)makeJD{

    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    int denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        LogViewController *logview =[[LogViewController alloc]init];
        
        [self.navigationController pushViewController:logview animated:YES];
        
        
    }
    else{
      
        IOS_Frame
       WebView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
        NSString *ShouY = [NSString stringWithFormat:JINDAN,UserIDs];
        //(@"%@",ShouY);
        WebView.delegate =self;
        NSURLRequest * resquest =[NSURLRequest requestWithURL:[NSURL URLWithString:ShouY]];
        [self.view addSubview: WebView];
        [WebView loadRequest:resquest];

        
        
        
        
    
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view makeToastActivity];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideToastActivity];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view hideToastActivity];
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
