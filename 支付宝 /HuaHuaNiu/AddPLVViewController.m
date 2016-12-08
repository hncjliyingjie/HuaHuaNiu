//
//  AddPLVViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-9.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AddPLVViewController.h"
#import "AFNetworking.h"
@interface AddPLVViewController ()

@end

@implementation AddPLVViewController
-(id)initWithDicFoSelf:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        PLDic =[[NSDictionary alloc]initWithDictionary:dic];
    }

    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self makeseleIO];
  
UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
BackBtn.frame =CGRectMake(0, 0, 64, 27);
[BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];


[BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeseleIO{
    self.MYtextView.delegate =self;
    self.ProductName.text=[PLDic objectForKey:@"goods_name"];
/*
 {
 comment = "";
 "credit_value" = 1;
 evaluation = 3;
 "goods_id" = 0;
 "goods_image" = "data/files/store_413/goods_143/small_201504011532232656.jpg";
 "goods_name" = "\U6001\U7684GIF\U683c\U5f0f\U56fe\U7247\Uff0c\U4e0d\U652f";
 "is_valid" = 1;
 "min_amount" = 0;
 "order_id" = 3;
 price = "0.00";
 quantity = 31;
 "rec_id" = 563;
 reply = "";
 "spec_id" = 0;
 specification = "";
 }
 
*/






}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.MYtextView resignFirstResponder];
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
self.MYtextView.text =[self.MYtextView.text  stringByReplacingOccurrencesOfString:@" " withString:@"" ];
    return  YES;
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

- (IBAction)PlAddAction:(id)sender {
    /*
     comment 评论内容
     evaluation 星级  1
     rec_id  订单商品id  rec_id
     order_id 订单id    order_id
     */
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString * rec_id =[PLDic objectForKey:@"rec_id"];
    NSString * order_id =[PLDic objectForKey:@"order_id"];
    self.MYtextView.text =[self.MYtextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * ShouY= [NSString stringWithFormat:AddPL];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    NSArray *KeyArr =@[@"token",@"goods_id",@"content",@"member_id"];
    //    NSArray *ValueArr =@[NameTextField.text,PassTextField.text];
    NSArray *ValueArr =@[@"test",rec_id,self.MYtextView.text,userID];
    NSDictionary *dic =[[NSDictionary alloc]initWithObjects:ValueArr forKeys:KeyArr];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:ShouY parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString * str =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"result"]];
        if ([str isEqualToString:@"1"]) {
            UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加评论成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al  show];
        }
        else{
            NSString * constr =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
            UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"提示" message:constr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al  show];
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
    }];
    //(@"%@",self.MYtextView.text);
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];
}
@end
