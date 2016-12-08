//
//  ShenqingquyudaiViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-12.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ShenqingquyudaiViewController.h"
#import "AFNetworking.h"
@interface ShenqingquyudaiViewController ()

@end

@implementation ShenqingquyudaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BackView.backgroundColor =BackColor;
    self.navigationItem.title=@"商家入驻";
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
    
    
    
    [self makeShenqingView];
    // Do any additional setup after loading the view from its nib.
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeShenqingView{
    self.BackView.contentSize =CGSizeMake(ConentViewWidth, 568);
    self.BackView.showsVerticalScrollIndicator = NO;
   self.YXTextFiel.delegate =self;
    self.LianXITextFiel.delegate =self;
    self.DizhiTextField.delegate =self;
    self.PhoneTextFiel.delegate =self;
    self.EmailTextFiel.delegate =self;
    self.QQtextFiel.delegate =self;
//    self.PhoneTextFiel.keyboardType =UIKeyboardTypeNumberPad;
//    self.QQtextFiel.keyboardType =UIKeyboardTypeNumberPad;
    self.BeiZhuTextView.delegate =self;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TaopAction)];
    [self.BackView addGestureRecognizer:tap];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
   self.BackView.contentSize =CGSizeMake(ConentViewWidth, 568+200);
    if (textField== self.EmailTextFiel||textField== self.QQtextFiel) {
        self.BackView.contentOffset =CGPointMake(0, 50);
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.YXTextFiel.text =[self.YXTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.LianXITextFiel.text =[self.LianXITextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.DizhiTextField.text =[self.DizhiTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.PhoneTextFiel.text =[self.PhoneTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.EmailTextFiel.text =[self.EmailTextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.QQtextFiel.text =[self.QQtextFiel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
      self.BackView.contentSize =CGSizeMake(ConentViewWidth, 568);
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
self.BackView.contentSize =CGSizeMake(ConentViewWidth, 568+300);
    self.BackView.contentOffset =CGPointMake(0, 140);

}
-(void)textViewDidEndEditing:(UITextView *)textView{
    self.BeiZhuTextView.text =[self.BeiZhuTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
self.BackView.contentSize =CGSizeMake(ConentViewWidth, 568);

}






// 取消 第一反应
-(void)TaopAction{
    [self.YXTextFiel resignFirstResponder];
    [self.LianXITextFiel resignFirstResponder];
    [self.DizhiTextField resignFirstResponder];
    [self.PhoneTextFiel resignFirstResponder];
    [self.EmailTextFiel resignFirstResponder];
    [self.QQtextFiel resignFirstResponder];
    [self.BeiZhuTextView resignFirstResponder];
   

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

- (IBAction)TouACtionss:(id)sender {
    BOOL  CanTiJiao; // 判断是否可以提交
    CanTiJiao = YES; // 有一条不满意就  不能提交
//    if(self.YXTextFiel.text.length == 0){
//        CanTiJiao = NO;
//    }
//    if(self.LianXITextFiel.text.length==0){
//        CanTiJiao = NO;
//    }
//    
//    if(self.DizhiTextField.text.length ==0){
//        CanTiJiao = NO;
//    }
    //CanTiJiao = [self isValidateMobile:self.PhoneTextFiel.text];
    //(@"bool   = %d",[self isValidateMobile:self.PhoneTextFiel.text]);
//    CanTiJiao =[self isValidateMobile:self.PhoneTextFiel.text];
//    if (CanTiJiao ) {
//       
//        CanTiJiao =[self validateEmail:self.EmailTextFiel.text];
//    }


    NSUserDefaults *userdefault =[NSUserDefaults standardUserDefaults];
    NSString *Username =[userdefault objectForKey:@"UserName"];

    if (CanTiJiao) {
    // 申请
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];

        NSString *LoginStr =[NSString stringWithFormat:@"http://daiyancheng.cn/appjon/agenter_add.do?token=test&member_id=%@&link_man=%@&link_mobile=%@&store_name=%@&address=%@&introduce=%@",userID,[[self.LianXITextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[self.DizhiTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[self.PhoneTextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[self.EmailTextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[[self.QQtextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
 
     /*
      user_name 用户名
      link_man 联系人
      area 所在区域
      phone_mob 电话号码
      email 电子邮箱	
      qq qq	
      introduce 备注
     */

    NSArray *KeyArr =@[@"member_id",@"link_man",@"link_mobile",@"store_name",@"address",@"introduce"];

        [[Username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[self.LianXITextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[self.DizhiTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[self.PhoneTextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[self.EmailTextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[self.QQtextFiel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

     
        NSLog(@"%@",userID);
        NSLog(@"%@",self.LianXITextFiel.text);
        NSLog(@"%@",self.DizhiTextField.text);
        NSLog(@"%@",self.PhoneTextFiel.text );
        NSLog(@"%@",_EmailTextFiel.text);
        NSLog(@"%@",self.QQtextFiel.text);

    NSArray *ValueArr =@[userID,self.LianXITextFiel.text,self.DizhiTextField.text,self.PhoneTextFiel.text,self.EmailTextFiel.text,self.QQtextFiel.text];
    NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
           NSLog(@"%@",dic);
           [manager POST:LoginStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"%@",responseObject);
        NSString * tureStr =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        NSLog(@"%@",tureStr);
        if([tureStr isEqualToString:@"1"]){
            UIAlertView * al =[[UIAlertView alloc ]initWithTitle:@"提示" message:@"信息提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            al.tag =98;
            [al show];
        }
        else{
            UIAlertView * al =[[UIAlertView alloc ]initWithTitle:@"提示" message:@"信息提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
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
@end
