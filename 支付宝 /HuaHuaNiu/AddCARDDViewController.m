//
//  AddCARDDViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AddCARDDViewController.h"
#import "AFNetworking.h"
@interface AddCARDDViewController ()

@end

@implementation AddCARDDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self makeTExtFiel];
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

-(void)makeTExtFiel{
    self.NameTextfile.layer.cornerRadius = 4;
    self.CardTextField.layer.cornerRadius = 4;
    self.CardTextField.keyboardType=UIKeyboardTypeNumberPad;

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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.CardTextField resignFirstResponder];
    [self.NameTextfile resignFirstResponder];
}
- (IBAction)EnterActions:(id)sender {
    ///添加银行卡
    
    
    self.CardTextField.text =[NSString stringWithFormat:@"%@",[self.CardTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    self.NameTextfile.text =[NSString stringWithFormat:@"%@",[self.NameTextfile.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    //(@"%@",self.NameTextfile.text);
    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[UserDefault objectForKey:@"Useid"];
    
    NSString * ShouY = [NSString stringWithFormat:ADDBANKCARD,UserID,self.CardTextField.text,self.NameTextfile.text];
    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //(@"%@",ShouY);
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"xx%@",responseObject);
        
        UIAlertView *alView =[[UIAlertView alloc]initWithTitle:@"银行卡添加" message:@"银行卡添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alView show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated: YES];

}

@end
