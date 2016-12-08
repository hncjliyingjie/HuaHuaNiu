//
//  ChangePhoneViewController.m
//  HuaHuaNiu
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "AFNetworking.h"
@interface ChangePhoneViewController (){
    NSString * _currentphoneNumber;
    UITextField * _XphoneNumber;
    UITextField * _yanZengNumber;
    UILabel * _phoneNumber;
    NSString * _YanZhenStr;
    BOOL CanTiJiao;

}
@end


@implementation ChangePhoneViewController


-(instancetype)initWithTitle:(NSString *)phone{
    self =[super init];
    if (self) {
        CanTiJiao =YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"修改绑定手机号";
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];


    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],

       NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1]}];
    self.view.backgroundColor =BackColor;

    [self createUI];
}

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUI{



    UIImageView * iv1 =[[UIImageView alloc]initWithFrame:CGRectMake(17, 10, 25, 25)];
    iv1.image =[UIImage imageNamed:@"app_phone_denglu"];
    [self.view addSubview:iv1];

    UIImageView * iv2=[[UIImageView alloc]initWithFrame:CGRectMake(17, 60, 25, 25)];
    iv2.image =[UIImage imageNamed:@"app_phone_denglu"];
    [self.view addSubview:iv2];



    _currentphoneNumber = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Phone"]];
    //(@"%@",_currentphoneNumber);
    _phoneNumber =[[UILabel alloc]initWithFrame:CGRectMake(50, 10, ConentViewWidth-50, 30)];
    _phoneNumber.text =[NSString stringWithFormat:@":%@",_currentphoneNumber];
    _XphoneNumber =[[UITextField alloc]initWithFrame:CGRectMake(50, 60, ConentViewWidth-50, 30)];
    _yanZengNumber =[[UITextField alloc]initWithFrame:CGRectMake(15, 110, ConentViewWidth-80, 30)];
    _XphoneNumber.placeholder =@":请输入需要更换的手机号码..";
    _yanZengNumber.placeholder =@"请输入验证码";
    [self.view addSubview:_phoneNumber];
    [self.view addSubview:_yanZengNumber];
    [self.view addSubview:_XphoneNumber];

    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(ConentViewWidth -110, 110, 100, 30)];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];


    UIButton * btn2 =[UIButton buttonWithType:UIButtonTypeSystem];;
    btn2.frame =CGRectMake(ConentViewWidth/2 -100/2, ScreenHeight -50-64 , 100, 30);
    [btn2 setTitle:@"修改" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn2  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];

    [btn2 addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_XphoneNumber resignFirstResponder];
    [_yanZengNumber resignFirstResponder];
}




-(void)save{

    [_yanZengNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([_YanZhenStr isEqualToString:_yanZengNumber.text]){
        NSUserDefaults * UserDefaulet =[NSUserDefaults standardUserDefaults];
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        BOOL ret = [phoneTest evaluateWithObject:_XphoneNumber.text];
        if ( !ret) {
            if (_XphoneNumber.text >0){
                UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号码格式不正确！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alew  show];
                CanTiJiao = NO;
            }
        }
        if (CanTiJiao) {
            [UserDefaulet synchronize];
            NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
            NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
            _XphoneNumber.text =[_XphoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            // 暂时没有用到 userid
            NSString * ShouY = [NSString stringWithFormat:CHANGMESSAGE, userID,@"mobile",_XphoneNumber.text];
            //(@"%@",ShouY);
            ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
            [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
                //(@"%@",[responseObject objectForKey:@"msg"]);
                if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]] isEqualToString:@"1"]) {
                    [UserDefaulet setObject:_XphoneNumber.text forKey:@"Phone"];
                    [UserDefaulet synchronize];
                    UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"该手机号已经绑定了其它帐号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alew  show];
                }else{
                    UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    alew.tag =99;
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [failAlView show];
                //(@"cook load failed ,%@",error);
            }];
        }

    }
    else{
        // 验证码错误
        UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"错误提示" message:@"验证码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [Alw  show];
    }



    }

-(void)btnClick{
    // 保存验证码    如果输入正确才能注册


    NSString *ShouY = YanZFORZHUCE;

    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",_XphoneNumber.text,@"mobile",nil];
    //(@"%@",dict);
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            if ([[NSString stringWithFormat:@"%@",[data objectForKey:@"result"]] isEqualToString:@"1"]) {
                UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码已发送，请注意查收。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [Alw  show];
                //(@"%@",[data objectForKey:@"vcode"]);
                _YanZhenStr =[data objectForKey:@"vcode"];
            }else{
                // 获取短信 失败
                UIAlertView * Alw=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取验证码失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [Alw  show];
            }
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==99) {
        [self.navigationController popViewControllerAnimated:YES];

    }
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
