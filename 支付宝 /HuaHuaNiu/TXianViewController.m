//
//  TXianViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "TXianViewController.h"
#import "AFNetworking.h"
#import "CardViewController.h"
@interface TXianViewController ()

@end

@implementation TXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self makeTextField];
    
    
    self.jineTextField.keyboardType =UIKeyboardTypeNumberPad;
    
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    
    self.MYmoneyLabel.text =[userdefault objectForKey:@"account"];
    
    
    
    
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

-(void)makeTextField{

    self.jineTextField.layer.cornerRadius = 4;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.jineTextField resignFirstResponder];

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
  
    return  YES;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//  申请提现
- (IBAction)BankCardAction:(id)sender {
    CardViewController *CVc =[[CardViewController alloc]initWitHTXian:YES];
   [CVc MakeWithBlocks:^(NSDictionary *dic) {
    //   //(@"gei 卡号和 name 赋值");
       BanKID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"bankcard_id"]];
       nameStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
      
       // self.MYmoneyLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@""]];
       
       [self.BankCard setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"card_number"]] forState:UIControlStateNormal];
   }];
    
    [self.navigationController pushViewController:CVc animated:YES];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==11) {
        
    }
    else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)YesActon:(id)sender {
   
    if (self.jineTextField.text.length ==0) {
        
        //(@"不符合");
    }
    else{
          //(@"%d",BanKID.length);

        if(BanKID.length ==0){
            UIAlertView *allll =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全您的消息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            allll.tag =11;
            [allll show];
            
                  }else{
            
    NSUserDefaults *  UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserID =[NSString stringWithFormat:@"%@",[UserDefault objectForKey:@"Useid"]];
    
    NSString * ShouY = [NSString stringWithFormat:TIXIAN];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    NSArray *KeyArr =@[@"member_id",@"bank_id",@"money",@"token"];
    
    NSArray *ValueArr =@[UserID,BanKID,self.jineTextField.text,@"test"];
    
    NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
                      //(@"%@",dic);
    [manager POST:ShouY parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"%@",[responseObject objectForKey:@"msg"]);
        UIAlertView *alView =[[UIAlertView alloc]initWithTitle:@"提现" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alView show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

        //(@"%@",error);
    }];
        }
    }
    
    
}
@end
