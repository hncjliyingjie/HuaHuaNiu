//
//  XunZhaoViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "XunZhaoViewController.h"
#import "AFNetworking.h"
@interface XunZhaoViewController ()

@end

@implementation XunZhaoViewController

-(id)initWithStoreId:(NSString *)Str{
    self =[super init];
    if (self) {
      
        storeID  = Str;
    
    }
    return self;
   }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [self makeUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)makeUI{
    self.WDMSTextView.delegate=self;
    self.WDMSTextView.backgroundColor =BackColor;
    
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.WDMSTextView resignFirstResponder];
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

- (IBAction)TijaioAction:(id)sender {
    self.WDMSTextView.text =[self.WDMSTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    NSString *ShouY =FindDaiRen ;
//    [NSString stringWithFormat:FindDaiRen,UserIDs,storeID,self.WDMSTextView.text]
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",UserIDs,@"member_id",nil];
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            
        }
    }];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //(@"%@",responseObject);
        NSString *ser =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"done"]];
        if ([ser isEqualToString:@"1"]) {
            UIAlertView  * uial =[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [uial show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

        //(@"cook load failed ,%@",error);
    }];
    

   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
