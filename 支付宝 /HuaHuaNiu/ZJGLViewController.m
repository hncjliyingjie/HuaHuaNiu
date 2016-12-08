//
//  ZJGLViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ZJGLViewController.h"
#import "ShouZhiViewController.h"
#import "TXianViewController.h"
#import "AFNetworking.h"
@interface ZJGLViewController ()

@end

@implementation ZJGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BackColor;
        [self makeZJdata];
    
    // Do any additional setup after loading the view from its nib.
    UIButton *BackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    BackBtn.frame =CGRectMake(0, 0, 64, 27);
    [BackBtn  setBackgroundImage:[UIImage imageNamed:@"app_fanhui"] forState:UIControlStateNormal];
    // [BackBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.navigationItem.title=@"资金管理";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    [BackBtn addTarget:self action:@selector(BackAction)  forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithCustomView:BackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)makeZJdata{
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    
    NSString * ShouY = [NSString stringWithFormat:YONGHUMessage, userID];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //(@"xxxxxxxx%@",responseObject);
        float number =[[responseObject objectForKey:@"total_integral"] floatValue];
        number/=100;
        self.zongJInerLabel.text=[NSString stringWithFormat:@"￥ %.2f",number];
        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
        [userDefault setObject:self.zongJInerLabel.text forKey:@"account"];
        [userDefault setObject:responseObject  forKey:@"gerenxinxi"];
        [userDefault synchronize];
        
    /*
       "user_id": "413",
       "parent_id": "0",
       "user_name": "987654321@126.com",
       "user_type": "0",
       "member_grade": "0",
       "user_money": "-596.00",
       "spended_money": "0.00",
       "frozen_money": "0.00",
       "user_flower": "0",
       "user_flower_basket": "0",
       "email": "987654321@126.com",
       "password": "b4b04f592796cff68253da190f3efca1",
       "paypassword": "",
       "real_name": "",
       "gender": "0",
       "birthday": null,
       "phone_tel": null,
       "phone_mob": null,
       "im_qq": "",
       "im_msn": "",
       "im_skype": null,
       "im_yahoo": null,
       "im_aliww": null,
       "reg_time": "1401085420",
       "last_login": "1429557296",
       "last_ip": "125.41.153.92",
       "logins": "35",
       "ugrade": "0",
       "portrait": "",
       "outer_id": "0",
       "activation": null,
       "feed_config": ""
       */
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];

        //(@"cook load failed ,%@",error);
    }];
    
    

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

- (IBAction)ShouzhiMIngXiAction:(id)sender {
    ShouZhiViewController *Svc =[[ShouZhiViewController alloc]init];
//    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Svc animated:YES];
}

- (IBAction)TiXianAction:(id)sender {
    
    TXianViewController * TX =[[TXianViewController alloc]init];
    
    [self.navigationController pushViewController:TX animated:YES];
    
}
@end
