//
//  XiuGaiJYMmaViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "XiuGaiJYMmaViewController.h"

@interface XiuGaiJYMmaViewController ()

@end

@implementation XiuGaiJYMmaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationItem.title=@"修改交易密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeUI{
    self.OldTextField.delegate =self;
    self.NewTextField.delegate =self;
    self.SecondTextField.delegate =self;
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.OldTextField resignFirstResponder];
    [self.NewTextField resignFirstResponder];
    [self.SecondTextField resignFirstResponder];
    
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

- (IBAction)YanZhengMaGAction:(id)sender {
}

- (IBAction)QueDingActionn:(id)sender {
}
@end
