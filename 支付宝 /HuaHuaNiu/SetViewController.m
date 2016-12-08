//
//  SetViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SetViewController.h"
#import "MineViewController.h"
#import "GRZLooViewController.h"
#import "CardViewController.h"
#import "ShouHuoDiZViewController.h"
#import "XiuGaiMMAViewController.h"
@interface SetViewController ()
{
    BOOL enters;

}
- (IBAction)tuichuAction:(id)sender;//退出登录
- (IBAction)genrenAction:(id)sender;//个人资料
- (IBAction)yinghangkaAction:(id)sender;//银行卡
- (IBAction)shouhuiAction:(id)sender;//收货地址
- (IBAction)changeAction:(id)sender;//修改密码
- (IBAction)wanshangAction:(id)sender;//晚上基本资料



@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设 置";
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    
   
}


-(SetViewController *)initWithEnter:(BOOL)enter{
    enters=enter;
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}

- (IBAction)tuichuAction:(id)sender {
    
    //(@"退出登录");
    enters = YES;
    UIButton   *btn =(UIButton *)[self.view viewWithTag:31];
    UIButton *  btnw =(UIButton *)[self.view viewWithTag:32];
    
    UILabel * labe =(UILabel *)[self.view viewWithTag:33];
    UILabel * labee =(UILabel *)[self.view viewWithTag:34];
    // userdefault 定义登录状态
    if (enters) {// 未登录
        btn.hidden = NO;
        btnw.hidden = NO;
        labe.hidden = YES;
        labee.hidden = YES;
    }
    // 登录
    else{
        btn.hidden = YES;
        btnw.hidden = YES;
        labee.hidden = NO;
        labe.hidden = NO;
        //  Lbe.hidden = YES;
    }
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSString *  DingWeistr =[NSString stringWithFormat:@"%@",[defs objectForKey:@"ZUOBIAO"]];
    
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isfirstcome"];
    [[NSUserDefaults standardUserDefaults]setObject:DingWeistr forKey:@"ZUOBIAO"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    MineViewController *Lvc =[[MineViewController alloc]init];
    Lvc.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:Lvc animated:YES];

}
//个人资料
- (IBAction)genrenAction:(id)sender {
    
    GRZLooViewController * Gvc =[[GRZLooViewController alloc]init];
    [self.navigationController pushViewController:Gvc animated:YES];
}
//银行卡
- (IBAction)yinghangkaAction:(id)sender {
    
    CardViewController *cvc =[[CardViewController alloc]init];
    [self.navigationController pushViewController: cvc animated:YES];
}
//收货地址
- (IBAction)shouhuiAction:(id)sender {
    
    ShouHuoDiZViewController *Svc =[[ShouHuoDiZViewController alloc]init];
    [self.navigationController pushViewController: Svc  animated:YES];
}
//修改密码
- (IBAction)changeAction:(id)sender {
    XiuGaiMMAViewController *Xvc =[[XiuGaiMMAViewController alloc]init];
    [self.navigationController pushViewController:Xvc animated:YES];
    
}
//晚上基本资料
- (IBAction)wanshangAction:(id)sender {
}
@end
