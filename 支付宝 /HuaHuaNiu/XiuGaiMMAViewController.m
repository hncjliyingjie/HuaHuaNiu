//
//  XiuGaiMMAViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "XiuGaiMMAViewController.h"
#import "AFNetworking.h"
@interface XiuGaiMMAViewController ()<UIAlertViewDelegate>

@end

@implementation XiuGaiMMAViewController

- (void)viewDidLoad {
    self.view.backgroundColor =BackColor;
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
    
    self.navigationItem.title=@"修改密码";
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
    
    self.OldTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.NewTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.SecondTextField.keyboardType =UIKeyboardTypeNumberPad;
  

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

- (IBAction)QueDingActionnn:(id)sender {
    
    NSUserDefaults *Userdefault =[NSUserDefaults  standardUserDefaults];    
    
    NSString * URL= [NSString stringWithFormat:CHANGEMIMA];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    NSArray *KeyArr =@[@"token",@"mobile",@"new_pwd",@"old_pwd",@"member_id"];
    //    NSArray *ValueArr =@[NameTextField.text,PassTextField.text];
    NSArray *ValueArr =@[@"test",[Userdefault objectForKey:@"Phone"],self.NewTextField.text,self.OldTextField.text,[Userdefault objectForKey:@"Useid"]];
    NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
    //(@"%@",dic);
    [manager POST:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"%@",[responseObject objectForKey:@"msg"]);
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               
               UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
               [failAlView show];

        //(@"%@",error);
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
