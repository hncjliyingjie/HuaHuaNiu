//
//  saomiajieguoViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15/5/26.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "saomiajieguoViewController.h"

@interface saomiajieguoViewController ()

@end

@implementation saomiajieguoViewController
-(id)initWithSte:(NSString *)str{
    self =[super init];
    if (self ) {
        urlStr =str;
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    
     [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
      [self makeVebView];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeVebView{

    
    IOS_Frame
    MYView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
    
   
    MYView.delegate =self;
    NSURLRequest * resquest =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.view addSubview: MYView];
    [MYView loadRequest:resquest];
    
    


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
