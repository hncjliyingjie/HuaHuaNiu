//
//  GRZLooViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-27.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "GRZLooViewController.h"
#import "ChangeLabeViewController.h"
#import "ChangePhoneViewController.h"
@interface GRZLooViewController ()

@end

@implementation GRZLooViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"个人资料";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1]}];

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

- (IBAction)ChangeNameAction:(id)sender {
    ChangeLabeViewController *Cvc =[[ChangeLabeViewController alloc]initWithTitle:@"nicheng"];
    [self.navigationController pushViewController:Cvc animated:YES];
}

- (IBAction)ChangeQianMingAction:(id)sender {
    ChangeLabeViewController *Cvc =[[ChangeLabeViewController alloc]initWithTitle:@"signature"];
    [self.navigationController pushViewController:Cvc animated:YES];

    
    
}

- (IBAction)SexSheZhiAction:(id)sender {
    ChangeLabeViewController *Cvc =[[ChangeLabeViewController alloc]initWithTitle:@"nianling"];
    [self.navigationController pushViewController:Cvc animated:YES];
}
-(IBAction)PhoneShezhi:(id)sender{

    ChangePhoneViewController *Cvc =[[ChangePhoneViewController alloc]initWithTitle:@"Phone"];
    [self.navigationController pushViewController:Cvc animated:YES];


}
@end
