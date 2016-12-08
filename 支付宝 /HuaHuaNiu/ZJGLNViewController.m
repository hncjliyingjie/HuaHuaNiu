//
//  ZJGLNViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZJGLNViewController.h"

@interface ZJGLNViewController ()

@end

@implementation ZJGLNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"资金管理";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    [self makeZJdata];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)makeZJdata{
    
    NSUserDefaults * userdefault =[NSUserDefaults standardUserDefaults];
    NSString * userID =[NSString stringWithFormat:@"%@",[userdefault objectForKey:@"Useid"]];
    
    NSString * ShouY = [NSString stringWithFormat:@"%@%@%@",DYUrl,ZJURL,userID];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"资金管理页面返回数据%@",responseObject);
//        //(@"xxxxxxxx%@",responseObject);
//        float number =[[responseObject objectForKey:@"total_integral"] floatValue];
//        number/=100;
//        self.zongJInerLabel.text=[NSString stringWithFormat:@"￥ %.2f",number];
//        NSUserDefaults * userDefault =[NSUserDefaults standardUserDefaults];
//        [userDefault setObject:self.zongJInerLabel.text forKey:@"account"];
//        [userDefault setObject:responseObject  forKey:@"gerenxinxi"];
//        [userDefault synchronize];
        
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


@end
