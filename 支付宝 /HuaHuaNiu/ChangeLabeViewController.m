//
//  ChangeLabeViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-27.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ChangeLabeViewController.h"
#import "AFNetworking.h"
@interface ChangeLabeViewController ()

@end

@implementation ChangeLabeViewController
-(id)initWithTitle:(NSString *)TiTleStr{
    self = [super init];
    if (self) {
        MtitleStr =TiTleStr;
    }
    return self;

}
- (void)viewDidLoad {
    CanTiJiao = YES;
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
    [self makeUI];
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
 
    
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)makeUI{
    self.changeTextFiel.delegate =self;
    NSUserDefaults *UserDefaulet =[NSUserDefaults standardUserDefaults];
    
    NSString * LStr =[[NSString alloc]initWithFormat:@""];
  
    if ([MtitleStr isEqualToString:@"nicheng"]) {
        self.navigationItem.title=@"修改昵称";
        LStr =[UserDefaulet objectForKey:@"UserName"];
        if ([LStr isEqualToString:@""]) {
            self.changeTextFiel.text =[[UserDefaulet objectForKey:@"gerenxinxi"]objectForKey:@"member_name"];
        }else{
            self.changeTextFiel.text =LStr;
        }
    }

   else if([MtitleStr isEqualToString:@"signature"]){
       self.navigationItem.title=@"修改签名";
       
       LStr =[UserDefaulet objectForKey:@"qianming"];

       if (LStr ==nil) {
           self.changeTextFiel.text =[NSString stringWithFormat:@"%@",[[UserDefaulet objectForKey:@"gerenxinxi"]objectForKey:@"signature"]];
       }else{
           self.changeTextFiel.text =LStr;
       }
    }
    else if([MtitleStr isEqualToString:@"nianling"]){
        self.navigationItem.title=@"修改年龄";
       
        LStr =[UserDefaulet objectForKey:@"age"];
        if (LStr ==nil) {
            self.changeTextFiel.text =[NSString stringWithFormat:@"%@",[[UserDefaulet objectForKey:@"gerenxinxi"]objectForKey:@"age"]];
        }else{
            self.changeTextFiel.text =LStr;
        }
    }
    else if([MtitleStr isEqualToString:@"Phone"]){
        self.navigationItem.title=@"修改电话";

        LStr =[UserDefaulet objectForKey:@"Phone"];

        if (LStr ==nil) {
            self.changeTextFiel.text =[NSString stringWithFormat:@"%@",[[UserDefaulet objectForKey:@"mobile"]objectForKey:@"age"]];
        }else{
            self.changeTextFiel.text =LStr;
        }
    }

    

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.changeTextFiel resignFirstResponder];

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

- (IBAction)XiuGaiActions:(id)sender {
    // 修改的类型
    NSString *type ;
   // 修改的内容
    NSString * concent =[NSString  stringWithFormat:@"%@",self.changeTextFiel.text];
    //  保存   等到 请求数据成功以后再保存
  NSUserDefaults *UserDefaulet =[NSUserDefaults standardUserDefaults];

      if([MtitleStr isEqualToString:@"signature"]){
    type =[NSString  stringWithFormat:@"signature"];
      [UserDefaulet setObject:self.changeTextFiel.text forKey:@"qianming"];
      
  }
  else if([MtitleStr isEqualToString:@"nianling"]){
     type =[NSString  stringWithFormat:@"age"];
      [UserDefaulet setObject:self.changeTextFiel.text forKey:@"age"];
      
  }
  else if([MtitleStr isEqualToString:@"Phone"]){
  type =[NSString  stringWithFormat:@"phone_mob"];
      [UserDefaulet setObject:self.changeTextFiel.text forKey:@"Phone"];
      NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
      NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
      BOOL ret = [phoneTest evaluateWithObject:self.changeTextFiel.text];
      if ( !ret) {
          if (self.changeTextFiel.text >0){
              UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号码格式不正确！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
              [alew  show];
              CanTiJiao = NO;
          }
      }
      else{
       
          
          
          
      }

      
      
  }
    if (CanTiJiao) {
        
    

   [UserDefaulet synchronize];
    
    
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
  
    
    concent =[concent stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 暂时没有用到 userid
    NSString * ShouY = [NSString stringWithFormat:CHANGMESSAGE, userID,type,concent];
        //(@"%@",ShouY);
    ShouY =[[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //(@"%@",[responseObject objectForKey:@"msg"]);
        UIAlertView * alew =[[UIAlertView alloc]initWithTitle:@"提示" message:@"信息修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alew  show];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    }
    else{
    
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];

}
@end
