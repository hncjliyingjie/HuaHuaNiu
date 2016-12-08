//
//  ForgetPWViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "AFNetworking.h"
@interface ForgetPWViewController ()

@end

@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.PassWorldAgain.secureTextEntry = YES;
    self.NewPassWorld.secureTextEntry = YES;
    self.navigationItem.title=@"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]}];
    // Do any additional setup after loading the view from its nib.
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

    [self.phoneTextField resignFirstResponder];
    [self.YZMTextField resignFirstResponder];
    [self.NewPassWorld resignFirstResponder];
    [self.PassWorldAgain resignFirstResponder];
  

}
// 获取验证码
- (IBAction)GetYZMAction:(id)sender {
    
    BOOL CanHuoqu ;
      CanHuoqu  =  [self  isValidateMobile:self.phoneTextField.text];
    
    if (CanHuoqu) {  // 可以
   
        
     NSString *ShouY = [NSString stringWithFormat:FORGETGETYZM,self.phoneTextField.text];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"%@",responseObject);
        NSString *str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ([str isEqualToString:@"1"]) {
            YanZhenStr =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"vcode"]];
            //(@"  %@",YanZhenStr);
            
        }
        else{
            // 获取短信 失败
            NSString * mess =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
            UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            Alw.tag =  40;
            [Alw  show];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        failAlView.tag = 11;
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
        
    }
    else{
        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        al.tag = 41;
        [al show];
    }
    
    
    
    
}
- (IBAction)enterAction:(id)sender {
    
    
      self.PassWorldAgain.text =[self.PassWorldAgain.text stringByReplacingOccurrencesOfString:@" " withString:@""];
     self.phoneTextField.text =[self.phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
      self.NewPassWorld.text =[self.NewPassWorld.text stringByReplacingOccurrencesOfString:@" " withString:@""];
      self.YZMTextField.text =[self.YZMTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([YanZhenStr isEqualToString:self.YZMTextField.text]) {
    
       
        NSString *ShouY = [NSString stringWithFormat:FORGETMIMA,self.phoneTextField.text,self.NewPassWorld.text];
        ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        
        [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //(@"%@",responseObject);
            if([responseObject objectForKey:@"msg"]){
                UIAlertView * alView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alView.tag = 43;
                [alView show];
                
                            }
            else{
                
                UIAlertView * alViewl =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
               
                [alViewl show];

           //( @"修改失败")
            }
                
            
         
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView * alViewl =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alViewl show];

            //(@"cook load failed ,%@",error);
        }];
 
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(alertView.tag == 43||alertView.tag == 11){
    // 修改成功
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
@end
