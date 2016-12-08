//
//  DLRZViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DLRZViewController.h"
#import "Toast+UIView.h"
@interface DLRZViewController ()
- (IBAction)renzhengAction:(id)sender;
@property(strong,nonatomic)NSDictionary *dic;

@end

@implementation DLRZViewController
{
    NSString *userId;//微信登录返回的uesrId
    NSString *type;//类型/微信？微博？QQ
    NSString *name;//昵称
    NSString *headImg;//头像
}

-(void)initWithLoginXinxi:(NSDictionary *)dict {
    _dic=dict;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewWithStyle];
    self.title=@"手机平台";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    [self readData];
   
}
//读取微信登录返回的数据显示
-(void)readData{
    //昵称
    self.name.text=[_dic objectForKey:@"userName"];
    name=[_dic objectForKey:@"userName"];
    //头像
    NSString *str=[_dic objectForKey:@"iconURL"];
    headImg=str;

    UIImage *imgs=[self getImageFromURL:str];
    self.img.image=imgs;
    //微信登录返回的usid
    userId=[_dic objectForKey:@"usid"];
    //类型/微信？微博？QQ
    type=[_dic objectForKey:@"type"];

}
-(void)viewWithStyle{
    
    self.renzheng_Btn.layer.cornerRadius=5;
    self.renzheng_Btn.layer.borderWidth=1;
    self.renzheng_Btn.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]CGColor];

}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
//去认证
-(void)makeRenZhengData{
    
    NSString *price=self.guanggao_textField.text;
    NSString *friend=self.friend_textField.text;
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:ADDZMTURL,type,name,UserIDs,friend,price,headImg,userId];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        NSLog(@"认证返回的数据%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];
    
}

- (IBAction)renzhengAction:(id)sender {
    
    [self makeRenZhengData];
}
@end
