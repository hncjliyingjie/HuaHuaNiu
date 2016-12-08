//
//  WZMTTableViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "WZMTTableViewController.h"
#import "RZCell.h"
#import "SjptViewController.h"
#import "Toast+UIView.h"
#import "AddZMTView.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "DLRZViewController.h"
@interface WZMTTableViewController ()
@property(strong,nonatomic)UIView *loginView;
@end

@implementation WZMTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的自媒体";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    [self makeData];
    [self makeUI];
    
}
//隐藏导航栏
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)makeUI{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(0, 0,15,15);
    [btn addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
    // [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"add_new"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
  
    
    self.navigationItem.rightBarButtonItem = RightItem;
    
}
//添加自媒体
-(void)BtnAction{
    
    [self.tableView.window addSubview:self.loginView];
    //移除浮层view,给透明部分添加点击收回
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSingleTap)];
    [self.loginView addGestureRecognizer:tap];

}
//移除绑定资源页面
-(void)handleSingleTap
{
    [self.loginView removeFromSuperview];

}
#pragma mark actions

//微信登录
-(void)wxDone:(id)sender{
    [self.loginView removeFromSuperview];
   
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
           
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            NSLog(@"微信登录返回的数据%@",snsAccount);
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
           
            NSDictionary *dic=@{
                               @"userName":snsAccount.userName,
                                @"usid" :snsAccount.usid,
                                @"iconURL":snsAccount.iconURL,
                               @"type":@"0",
                               };
             DLRZViewController *vc=[[DLRZViewController alloc]initWithNibName:@"DLRZViewController" bundle:nil];
            [vc initWithLoginXinxi:dic];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    });
}

//微博登录
-(void)wbDone:(id)sender{
     [self.loginView removeFromSuperview];
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
}
//QQ登录
-(void)qqDone:(id)sender{
     [self.loginView removeFromSuperview];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取QQ用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   RZCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RZCELL"];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"RZCell" owner:self options:nil]firstObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SjptViewController *vc=[[SjptViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(UIView *)loginView{
    if (_loginView==nil) {
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+64)];
    views.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    UIView *linkView=[[UIView alloc]initWithFrame:CGRectMake(25, self.view.frame.size.height/2+32, ConentViewWidth-50, 100)];
    linkView.backgroundColor=[UIColor whiteColor];
    linkView.layer.cornerRadius=5;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, linkView.frame.size.width, 30)];
    label.text=@"自动绑定";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:13];
    
    //微信
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(linkView.frame.size.width/5/3, 30, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"wx_new"] forState:UIControlStateNormal];
    //微博
    UIButton *centerBtn=[[UIButton alloc]initWithFrame:CGRectMake(linkView.frame.size.width/5/3+linkView.frame.size.width/3, 30, 30, 30)];
    [centerBtn setImage:[UIImage imageNamed:@"wb_new"] forState:UIControlStateNormal];
    //qq
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(linkView.frame.size.width/5/3+linkView.frame.size.width/3+linkView.frame.size.width/3, 30, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"qq_new"] forState:UIControlStateNormal];
    
    
    [leftBtn addTarget:self action:@selector(wxDone:) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn addTarget:self action:@selector(wbDone:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(qqDone:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *textLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, linkView.frame.size.width, 30)];
    textLbl.text=@"绑定社交资源：马上开始接单";
    textLbl.textAlignment=NSTextAlignmentCenter;
    textLbl.font=[UIFont systemFontOfSize:13];
    textLbl.textColor=[UIColor grayColor];
    
    [views addSubview:linkView];
    [linkView addSubview:label];
    [linkView addSubview:leftBtn];
    [linkView addSubview:centerBtn];
    [linkView addSubview:rightBtn];
    [linkView addSubview:textLbl];
        _loginView=views;
    }
//    [self.tableView.window addSubview:views];
    return _loginView;

}
//认证中心
-(void)makeData{
    
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    NSString * UserIDs =[UserDefault objectForKey:@"Useid"];
    [self.view makeToastActivity];
    NSString * ShouY = [NSString stringWithFormat:MAINMEITIURL,UserIDs];
    NSString *urlStringUTF8 = [ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStringUTF8 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.view hideToastActivity];
        NSLog(@"我的自媒体页面返回的数据%@",responseObject);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.view hideToastActivity];
        UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [failAlView show];
        
    }];


}
@end
