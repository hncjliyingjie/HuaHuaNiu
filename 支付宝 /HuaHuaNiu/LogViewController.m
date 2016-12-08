//
//  LogViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "LogViewController.h"
#import "RegistViewController.h"
#import "ForgetPWViewController.h"
#import "UserModel.h"
@interface LogViewController ()
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PassWordTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.navigationItem.title=@"登录";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1]}];
    
    
    // Do any additional setup after loading the view from its nib.
    [self makeUI];
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
-(void)makeUI{
    IOS_Frame
    TSlabel =[[UILabel alloc]initWithFrame:CGRectMake(50, ConentViewHeight - 100, ConentViewWidth - 100 ,20)];
    TSlabel.backgroundColor =[UIColor blackColor];
    TSlabel.textColor =[UIColor whiteColor];
    TSlabel.hidden = YES;
    TSlabel.font =[UIFont systemFontOfSize:13];
    [self.view addSubview:TSlabel];
    
    self.IconImage.layer.masksToBounds = YES;
    self.IconImage.layer.cornerRadius = 40;
  
    
    self.AccountTextField.delegate = self;
    self.PassWordTextField.delegate= self;
    self.PassWordTextField.secureTextEntry = YES;


}
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    // 判断手机格式
//    if(textField == self.AccountTextField){
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    BOOL ret = [phoneTest evaluateWithObject:self.AccountTextField.text];
//    if ( !ret) {
//        if (self.AccountTextField.text.length >0){
//        //(@"您输入的手机号码有误！请重新输入");
//        TSlabel.text=@" 您输入的手机号码有误！请重新输入!";
//            TSlabel.hidden = NO;
//        }
//    }
//    else{
//        TSlabel.hidden = YES;
//        //(@"格式正确");
//    }
//    }
//    // 密码 的判断在 登录失败的时候
//    else{
//    //
//    
//    }
//
//    return YES;
//}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.AccountTextField resignFirstResponder];
    [self.PassWordTextField resignFirstResponder];
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

// 每次进入看是不是已经登录
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSInteger denglu  = UserIDs.length;
    if (denglu ==  0) {// 未登录 进入登陆
        }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}


//  登陆
- (IBAction)LogAction:(id)sender {

  //  账号  self.AccountTextField.text;
  //  密码  self.PassWordTextField.text;
    
    [self.PassWordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.AccountTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //(@" account  =  %@  password =  %@",self.AccountTextField.text,self.PassWordTextField.text);
    NSString *ShouY = DengLu;
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",self.AccountTextField.text,@"member_name",self.PassWordTextField.text,@"password",nil];
    
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        //(@"%@",data);
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            UserModel *userModel =[UserModel makeModelWithDict:data];
            if (userModel.result ==1) {
                //  写大 磁盘里面
                NSUserDefaults *Userdefaults =[NSUserDefaults standardUserDefaults];
                //ID
                [Userdefaults setValue:userModel.member_id forKey:@"Useid"];
                //昵称
                [Userdefaults setValue:userModel.member_name forKey:@"UserName"];
                
                // 签名
                [Userdefaults setValue:userModel.signature forKey:@"qianming"];
                // 电话
                [Userdefaults setValue:userModel.phone forKey:@"Phone"];
                
                [Userdefaults synchronize];
                NSLog(@"%@",[Userdefaults objectForKey:@"Useid"]);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                // 登录失败  提示
                NSString * sreee =[NSString stringWithFormat:@"%@",[data objectForKey:@"msg"]];
                            if (sreee.length == 0) {
                                sreee =@"密码或账号输入错误";
                            }
                            UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"登录提示" message:sreee delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                            [al show];
                        }
        }
    }];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

}
// 注册
- (IBAction)registAction:(id)sender {
    
    RegistViewController *rvc =[[RegistViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:YES];
}
// 忘记密码
- (IBAction)ForgetPassWordAction:(id)sender {
    ForgetPWViewController *fvc =[[ForgetPWViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}
@end
