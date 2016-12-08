//
//  RegistViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "RegistViewController.h"
#import "UserModel.h"
@interface RegistViewController ()

@end
static NSInteger seconds = 60;
@implementation RegistViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   

    self.navigationItem.title=@"注册";
    YanZhenStr =@"we";
    self.ReadBtn.selected = YES;
    self.YanZhengTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.PassWordTextField.keyboardType =UIKeyboardTypeNumberPad;
    self.PassWordTextField.secureTextEntry = YES;
    self.PhoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.PhoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;

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
#pragma mark - 倒计时
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.YZMButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.YZMButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.YZMButton setTitle:[NSString stringWithFormat:@"%@s后重新发送",strTime] forState:UIControlStateNormal];
                self.YZMButton.titleLabel.font = [UIFont systemFontOfSize:12];
                [UIView commitAnimations];
                self.YZMButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark 获取验证码
- (IBAction)YZBtnAction:(id)sender {
//验证码button变化
    [self startTime];
// 保存验证码    如果输入正确才能注册
   

    NSString *ShouY = YanZFORZHUCE;
    
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",self.PhoneTextField.text,@"mobile",nil];
    
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            if ([[NSString stringWithFormat:@"%@",[data objectForKey:@"result"]] isEqualToString:@"1"]) {
                UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码已发送，请注意查收。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [Alw  show];
                //(@"%@",[data objectForKey:@"vcode"]);
                YanZhenStr =[data objectForKey:@"vcode"];
            }else{
                // 获取短信 失败
                UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取验证码失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [Alw  show];
            }
        }
    }];
    //(@"手机号码 ： %@",self.PhoneTextField.text);
}


#pragma mark 协议
- (IBAction)TreatyAction:(id)sender {
    IOS_Frame
    
    if (WebView) {
        
    }
    else{
        WebView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight )];
    }
    NSString *ShouY = [NSString stringWithFormat:XIEYIStr];
    WebView.delegate =self;
    NSURLRequest * resquest =[NSURLRequest requestWithURL:[NSURL URLWithString:ShouY]];
    [self.view addSubview: WebView];
    [WebView loadRequest:resquest];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.NameTextField resignFirstResponder];
    [self.PhoneTextField resignFirstResponder];
    [self.YanZhengTextField resignFirstResponder];
    [self.PassWordTextField resignFirstResponder];

}
- (IBAction)BeginREgistAction:(id)sender {
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * zuobiao = [userdefault objectForKey:@"ZUOBIAO"];

    [self.YanZhengTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([YanZhenStr isEqualToString:self.YanZhengTextField.text]){
        if ( self.ReadBtn.selected) {
            //阅读协议
            //(@"name = %@   password = %@  phone = %@ ",self.NameTextField.text, self.PassWordTextField.text,self.PhoneTextField.text);
            [self.PassWordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.PhoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.NameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            [self.TuiJianNum.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *ShouY = ZhuCe;
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //member_id
            
            NSArray *key = @[@"ll",@"token",@"agreement_type",@"nick_name",@"password",@"mobile",@"par_mobile"];
            NSArray * value = @[zuobiao,@"test",@"member_reg_agreement",self.NameTextField.text,self.PassWordTextField.text,self.PhoneTextField.text,self.TuiJianNum.text];
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:value forKeys:key];
            //NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:zuobiao,@"ll",@"test",@"token",@"member_reg_agreement",@"agreement_type",self.NameTextField.text,@"nick_name",self.PassWordTextField.text,@"password",self.PhoneTextField.text,@"mobile",nil];
            //(@"%@",dict);
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        NSString * info ;
        if ([data objectForKey:@"error"]) {
            info =@"数据加载失败";
        }else{
            if ([[NSString stringWithFormat:@"%@",[data objectForKey:@"result"]] isEqualToString:@"1"]) {
                info =@"注册成功";
            }else{
                info =@"注册失败";
            }
        }
        UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        Alw.tag =1111;
        [Alw  show];
    }];
            
       }
        else{
        // 未阅读协议
            UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"请阅读用户注册协议" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [Alw  show];
        }
    }
    else{
    // 验证码错误
        UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"验证码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [Alw  show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1111) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)yueduActions:(id)sender {
    
    self.ReadBtn.selected =!self.ReadBtn.selected;
    
}
@end
