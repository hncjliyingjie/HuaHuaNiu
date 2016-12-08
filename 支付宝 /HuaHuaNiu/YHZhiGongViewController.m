//
//  YHZhiGongViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHZhiGongViewController.h"
#import "YHGoodsCollectionCon.h"
#import "YHGoodsViewFlowLayout.h"
#import "ProductDetailViewController.h"
#import "SearchReaultViewController.h"

@interface YHZhiGongViewController ()<UITextFieldDelegate>

{
    __weak IBOutlet UIButton *PinPaiButton;
    __weak IBOutlet UIButton *DuiHuanButton;
    UIView      *TitleView;
    UITextField * TopTextField;
    // 判断是不是 城市选择进入的
    BOOL iscomefromcity;
}
@end

@implementation YHZhiGongViewController

#pragma mark - 兑换
- (IBAction)duihuanButton:(UIButton *)sender {
    NSLog(@"%@",sender);
    //修改参数发送请求
    if (DuiHuanButton.selected) {
        return;
    }else{
        if (PinPaiButton.selected) {
            PinPaiButton.selected = NO;
        }
        DuiHuanButton.selected = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"duihuanButton" object:nil userInfo:nil];
    }

}
#pragma mark - 品牌
- (IBAction)pinpaiButton:(UIButton *)sender {
    if (PinPaiButton.selected) {
        return;
    }else{
        if (DuiHuanButton.selected) {
            DuiHuanButton.selected = NO;
        }
        PinPaiButton.selected = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pinpaiButton" object:nil userInfo:nil];
    }
    
}

- (void)poushViewControllerWith:(NSNotification *)notificationn{

        UIViewController *pvc = notificationn.object;
    [self.navigationController pushViewController:pvc animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    //注册通知
    
    DuiHuanButton.backgroundColor = BackColor;
    PinPaiButton.backgroundColor = BackColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(poushViewControllerWith:) name:@"pushViewController" object:nil];

    [self makeTopView];
    
    [self makeTitleViews];
    
    [self duihuanButton:DuiHuanButton];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:264/255.0 green:125/255.0 blue:137/255.0 alpha:1];
}

-(void)makeTitleViews{
    // 搜索框
    CGFloat   beishu  = ConentViewWidth/320;
    
    TitleView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,150*beishu, 30)];
    TopTextField  =[[UITextField alloc]initWithFrame:CGRectMake(2, 3, 146,20)];
    TopTextField.delegate =self;
    TopTextField.placeholder =@"请输入搜索内容";
    TopTextField.font =[UIFont systemFontOfSize:13];
    [TopTextField setValue:[UIColor colorWithRed:243/255.0 green:182/255.0 blue:187/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIImageView *baima=[[UIImageView alloc]initWithFrame:CGRectMake(0, 3,180*beishu, 20)];
    baima.image =[UIImage imageNamed:@"sousuoxian"];
    
    [TitleView addSubview:TopTextField];
    [TitleView addSubview:baima];
    
    self.navigationItem.titleView =TitleView;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}
-(void)makeTopView{
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0, 0, 20, 20);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *RightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = RightItem;
}
-(void)RightAction{
    NSString *Str =TopTextField.text;
    if (Str.length == 0) {
        UIAlertView * sear =[[UIAlertView alloc]initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [sear show];
    }
    else{
        
        NSString * seastr =TopTextField.text;
        TopTextField.text =@"";
        SearchReaultViewController *svc =[[SearchReaultViewController alloc]initWithStr:seastr];
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
}
@end
