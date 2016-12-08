//
//  MYFunViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15/5/26.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MYFunViewController.h"
#import "AFNetworking.h"
#import "Toast+UIView.h"
@interface MYFunViewController ()
@property(nonatomic,strong)AlexModel * model;
@end

@implementation MYFunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.navigationItem.title=@"我有粉丝";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self CreatData];
    // Do any additional setup after loading the view.
}
-(void)CreatData{
    
    
    [self.view makeToastActivity];
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString *  UserID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    NSString *ShouY = [NSString stringWithFormat:MYFENSI];
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",UserID,@"member_id",nil];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary *data) {
        [self.view hideToastActivity];
        if ([data objectForKey:@"error"]) {
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            //(@"%@",data);
            self.model =[AlexModel makeFunsModelWithDict:data];
            [self makeFunUI];
        }
    }];

}
-(void)makeFunUI{
    if (backView) {
        [backView removeFromSuperview];
    }
    
     backView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, ConentViewHeight)];
    backView.backgroundColor =BackColor;
    if(500>ConentViewHeight){
     backView.contentSize= CGSizeMake(ConentViewWidth, 500);
    
    }
    else{
     backView.contentSize= CGSizeMake(ConentViewWidth, ConentViewHeight);
    }
   
    backView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backView];
    
    UILabel * woyoufensiLeb =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ConentViewWidth, 30)];
    woyoufensiLeb.backgroundColor = [UIColor whiteColor];
    woyoufensiLeb.font = [UIFont systemFontOfSize:16];
    woyoufensiLeb.text= @"我有粉丝";
    woyoufensiLeb.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:woyoufensiLeb];
    
//昨日新增粉丝
    
    for (int i = 0 ; i< 3; i++) {
        
        UILabel * fensiLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 31+ 31*i, ConentViewWidth, 30)];
        fensiLabel.backgroundColor = [UIColor whiteColor];
        fensiLabel.font = [UIFont systemFontOfSize:16];
        UILabel * FennumberLbe =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-100, 31+ 31*i,75, 30)];
        FennumberLbe.font =[UIFont systemFontOfSize:16];
        FennumberLbe.textColor =[UIColor redColor];
        FennumberLbe.textAlignment = NSTextAlignmentRight;
        if (i==0) {
            NSString * str =self.model.y_addfuns;
           fensiLabel.text= @"    昨日新增粉丝数";
            FennumberLbe.text =str;
        }
        else if (i ==1){
             NSString * str =self.model.direct_funs;
        fensiLabel.text= @"    直接粉丝数";
            FennumberLbe.text =str;
        }
        else if(i==2){
             NSString * str =[NSString stringWithFormat:@"%@",self.model.indirect_funs ];
        fensiLabel.text= @"    关联粉丝总数";
            FennumberLbe.text =str;
        
        }
       
       [backView addSubview:fensiLabel];
        [backView addSubview:FennumberLbe];

    }
    
 //花朵
    
    UILabel * woyouhuaduoLeb =[[UILabel alloc]initWithFrame:CGRectMake(0, 134, ConentViewWidth, 30)];
    woyouhuaduoLeb.backgroundColor = [UIColor whiteColor];
    woyouhuaduoLeb.font = [UIFont systemFontOfSize:16];
    woyouhuaduoLeb.text= @"我有花朵";
    woyouhuaduoLeb.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:woyouhuaduoLeb];
    
    for (int i = 0 ; i< 1; i++) {
        
        UILabel * fensiLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 165+ 31*i, ConentViewWidth, 30)];
        fensiLabel.backgroundColor = [UIColor whiteColor];
        fensiLabel.font = [UIFont systemFontOfSize:16];
        UILabel * FennumberLbe =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-70, 165+ 31*i,55, 30)];
        FennumberLbe.font =[UIFont systemFontOfSize:16];
        FennumberLbe.textColor =[UIColor redColor];
        FennumberLbe.textAlignment = NSTextAlignmentRight;
        if (i==1) {
            NSString * str =self.model.y_addflower;
            fensiLabel.text= @"    昨日新增粉花朵数";
            FennumberLbe.text =str;
        }
        else if (i ==0){
            NSString * str =self.model.total_flower;
            fensiLabel.text= @"    现有花朵数";
            FennumberLbe.text =str;
        }
               [backView addSubview:fensiLabel];
        [backView addSubview:FennumberLbe];
        
    }
//收益
    
    UILabel * woyoushouyiLeb =[[UILabel alloc]initWithFrame:CGRectMake(0, 205, ConentViewWidth, 30)];
    woyoushouyiLeb.backgroundColor = [UIColor whiteColor];
    woyoushouyiLeb.font = [UIFont systemFontOfSize:16];
    woyoushouyiLeb.text= @"我的收益";
    woyoushouyiLeb.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:woyoushouyiLeb];
    
    for (int i = 0 ; i< 2; i++) {
        
        UILabel * fensiLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 236+ 31*i, ConentViewWidth, 30)];
        fensiLabel.backgroundColor = [UIColor whiteColor];
        fensiLabel.font = [UIFont systemFontOfSize:16];
        UILabel * FennumberLbe =[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-100, 236+ 31*i,75, 30)];
        FennumberLbe.font =[UIFont systemFontOfSize:16];
        FennumberLbe.textColor =[UIColor redColor];
        FennumberLbe.textAlignment= NSTextAlignmentRight;
        if (i==0) {
             NSString * str =[NSString stringWithFormat:@"%@ 积分",self.model.y_addmoney];
            fensiLabel.text= @"    昨日收益";
            FennumberLbe.text =str;
        }
        else if (i ==1){
             NSString * str =[NSString stringWithFormat:@"%@ 积分",self.model.total_money];
            fensiLabel.text= @"    现有余额";
            FennumberLbe.text =str;
        }
        [backView addSubview:fensiLabel];
        [backView addSubview:FennumberLbe];
        
    }
    

}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(void)ChangeActioss{
//    //实现
//    
//    //  换蓝换鲜花以后 是不是要提示
//    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
//    NSString *  UserID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
//    NSString *ShouY = [NSString stringWithFormat:ChangHL,UserID];
//    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    
//    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        UIAlertView * allview =[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的花蓝已经转换为鲜花" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil  ];
//        [ allview show];
//        //  换花篮   之后刷新数据
//        [self  CreatData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [failAlView show];
//        
//    }];
//
//
//}

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

@end
