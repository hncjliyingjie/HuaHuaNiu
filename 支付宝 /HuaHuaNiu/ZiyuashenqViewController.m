//
//  ZiyuashenqViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-12.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ZiyuashenqViewController.h"
#import "AFNetworking.h"
@interface ZiyuashenqViewController ()

@end

@implementation ZiyuashenqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 568);
    self.backScrollview.backgroundColor = BackColor;
    self.backScrollview.showsVerticalScrollIndicator = NO;
    
    self.CompanyTextFiel.delegate =self;
    self.DizhiTextFiel.delegate =self;
    self.LianXiRenTextFiel.delegate =self;
    self.PhoneTextFiel.delegate =self;
    self.PhoneTextFiel.keyboardType =UIKeyboardTypeNumberPad;
    self.WangZhanTextFiel.delegate =self;
    self.WangZhanTextFiel.keyboardType =UIKeyboardTypeURL;
    self.EmailTextFiel.delegate =self;
    self.QQTextFiel.delegate =self;
    self.QQTextFiel.keyboardType =UIKeyboardTypeNumberPad;
    self.BeiZhuTextView.delegate =self;
    
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAActops)];
    [self.backScrollview addGestureRecognizer:tap];
    
  //  self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"诚邀入驻";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)TapAActops{
//
    [self.CompanyTextFiel resignFirstResponder];
    [self.DizhiTextFiel resignFirstResponder];
    [self.LianXiRenTextFiel resignFirstResponder];
    [self.PhoneTextFiel resignFirstResponder];
    [self.WangZhanTextFiel resignFirstResponder];
    [self.EmailTextFiel resignFirstResponder];
    [self.QQTextFiel resignFirstResponder];
    [self.BeiZhuTextView resignFirstResponder];
    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 568 );

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 568+200);
    if (textField== self.EmailTextFiel||textField== self.QQTextFiel) {
         self.backScrollview.contentOffset =CGPointMake(0, 50);
    }
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    self.CompanyTextFiel.text =[self.CompanyTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.DizhiTextFiel.text =[self.DizhiTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.LianXiRenTextFiel.text =[self.LianXiRenTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.PhoneTextFiel.text =[self.PhoneTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.WangZhanTextFiel.text =[self.WangZhanTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.EmailTextFiel.text =[self.EmailTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.QQTextFiel.text =[self.QQTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
self.backScrollview.contentSize =CGSizeMake(ConentViewWidth, 568 +300);
    self.backScrollview.contentOffset =CGPointMake(0, 140);
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.BeiZhuTextView.text =[self.BeiZhuTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];

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

- (IBAction)TijiaoShenQing:(id)sender {
    BOOL  CanTiJiao; // 判断是否可以提交
    CanTiJiao = YES; // 有一条不满意就  不能提交
    
    /*
     self.CompanyTextFiel.delegate =self;
     self.DizhiTextFiel.delegate =self;
     self.LianXiRenTextFiel.delegate =self;
     self.PhoneTextFiel.delegate =self;
     self.WangZhanTextFiel.delegate =self;
     self.EmailTextFiel.delegate =self;
     self.QQTextFiel.delegate =self;
     self.BeiZhuTextView.delegate =self;
     */
    if(self.CompanyTextFiel.text.length == 0){
        CanTiJiao = NO;
    }
    if(self.DizhiTextFiel.text.length==0){
        CanTiJiao = NO;
    }
    
    if(self.LianXiRenTextFiel.text.length ==0){
        CanTiJiao = NO;
    }
    //CanTiJiao = [self isValidateMobile:self.PhoneTextFiel.text];
    //(@"bool   = %d",[self isValidateMobile:self.PhoneTextFiel.text]);
    CanTiJiao =[self isValidateMobile:self.PhoneTextFiel.text]; // 电话

    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *Username =[userdefault objectForKey:@"UserName"];
   
    if (CanTiJiao) {
        
        // 申请
        
        NSString *LoginStr =[NSString stringWithFormat:ZIYUANZHENHE] ;
        LoginStr =[LoginStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        /*
         user_name 用户名  company_name 公司名称
         link_man 联系人
         area 所在区域
         phone_mob 电话号码	email 电子邮箱	qq qq	introduce 资源整合意向
         */
        NSString * str1 =[[[NSString stringWithFormat:@"%@",self.CompanyTextFiel.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * str2 =[[[NSString stringWithFormat:@"%@",self.DizhiTextFiel.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * str3 =[[[NSString stringWithFormat:@"%@",self.LianXiRenTextFiel.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * str4 =[[[NSString stringWithFormat:@"%@",self.BeiZhuTextView.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


        
        NSArray *KeyArr =@[@"token",@"member_id",@"company_name",@"link_man",@"address",@"website",@"link_mobile",@"email",@"qq",@"introduce"];
        
        NSArray *ValueArr =@[@"test",Username,str1,str3,str2,self.WangZhanTextFiel.text,self.PhoneTextFiel.text,self.EmailTextFiel.text,self.QQTextFiel.text,str4];
        
        NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
        //(@"%@",dic);
        
        [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString * tureStr =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
            if([tureStr isEqualToString:@"1"]){
            UIAlertView * al =[[UIAlertView alloc ]initWithTitle:@"提示" message:@"信息提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            al.tag =98;
            [al show];
            }
            else{
                UIAlertView * al =[[UIAlertView alloc ]initWithTitle:@"提示" message:@"信息提交失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [al show];
                //(@"提交的结果为:%@",[responseObject objectForKey:@"msg"]);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];

            //(@"%@",error);
        }];
    }
    else{
        
        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息不完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [al show];
    }
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==98) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }


}
// 正则电话
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
// 邮箱
- (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(BOOL)isvalidateWangzhan:(NSString *)wangzhi{

    NSString *emailRegex = @"[a-zA-z]+://[^/s]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:wangzhi];



}
@end
