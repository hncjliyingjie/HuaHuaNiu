//
//  RootTbaarViewController.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15/6/2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "RootTbaarViewController.h"
#import "FirstViewController.h"
#import "WanShangViewController.h"
#import "YHZhiGongViewController.h"
#import "HGHomeController.h"
#import "LastViewController.h"
#import "ZhiGongViewController.h"
#import "MoreViewController1.h"

#import "DYMainViewController.h"
#import "TGViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"
//#import "DYViewController.h"

@interface RootTbaarViewController ()

@end

@implementation RootTbaarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    NSString * firstcome =  [[NSUserDefaults standardUserDefaults]objectForKey:@"isfirstcome"];
    if ([firstcome isEqualToString:@"yes"]) {
        
        [self makejiemian];
}
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isfirstcome"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        scv=[[UIScrollView alloc]initWithFrame:self.view.frame];
        scv.contentSize =CGSizeMake(ConentViewWidth * 4, ConentViewHeight);
        scv.pagingEnabled = YES;
        scv.showsVerticalScrollIndicator = NO;
        scv.bounces = NO;
        scv.showsHorizontalScrollIndicator = NO;
        NSArray * imaArr =@[@"come_first",@"come_two",@"come_third",@"come_four"];
        for (int i = 0 ; i< 4; i++) {
            UIImageView * iam =[[UIImageView alloc]initWithFrame:CGRectMake(ConentViewWidth * i, 0, ConentViewWidth, self.view.frame.size.height)];
            iam.tag =41+i;
            iam.image =[UIImage imageNamed:imaArr[i]];
            [scv addSubview:iam];
            
        
        }
        scv.delegate=self;
        
        [self.view addSubview:scv];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == ConentViewWidth *3) {
        // 添加点击事件
        NSLog(@"%f",scrollView.contentOffset.x);
        NSLog(@"%f",ConentViewWidth *3);
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MakeMYui)];
        UIImageView *imaView =(UIImageView *)[self.view viewWithTag:44];
        [imaView addGestureRecognizer:tap];
        imaView.userInteractionEnabled = YES;
    }


}
-(void)MakeMYui{

    [scv removeFromSuperview];

[self makejiemian];

}
/*** changed by zhangjinjing   ***/

-(void)makejiemian{

    //代言
    DYMainViewController *fvc =[[DYMainViewController alloc]initWithNibName:@"DYMainViewController" bundle:nil];
    UINavigationController *Fnvc =[[UINavigationController alloc]initWithRootViewController:fvc];
    [Fnvc.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self addChildViewControllerWith:Fnvc Title:@"代言" imageName:@"dy"];
    // 推广
    TGViewController *tvc =[[TGViewController alloc]init];
    UINavigationController *tnvc =[[UINavigationController alloc]initWithRootViewController:tvc];
    [self addChildViewControllerWith:tnvc Title:@"推广" imageName:@"tg"];
    tnvc.title=@"推广";
    
    //发现
    FindViewController *Cvc= [[FindViewController alloc]initWithNibName:@"FindViewController" bundle:nil];
    UINavigationController *Cnvc =[[UINavigationController alloc]initWithRootViewController:Cvc];
    [self addChildViewControllerWith:Cnvc Title:@"发现" imageName:@"faxian"];


    //    // 首页
    //   FirstViewController *fvc =[[FirstViewController alloc]init];
    //    UINavigationController *Fnvc =[[UINavigationController alloc]initWithRootViewController:fvc];
    //    [self addChildViewControllerWith:Fnvc Title:@"代言" imageName:@"icon_home"];
    
 
//    // 城堡
//    WanShangViewController *tvc =[[WanShangViewController alloc]init];
//    UINavigationController *tnvc =[[UINavigationController alloc]initWithRootViewController:tvc];
    
    //兑兑
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YHZhiGongViewController" bundle:[NSBundle mainBundle]];
    YHZhiGongViewController *svc = sb.instantiateInitialViewController;
    UINavigationController *snvc =[[UINavigationController alloc]initWithRootViewController:svc];
    [self addChildViewControllerWith:snvc Title:@"兑兑" imageName:@"duidui"];
    
    
//    HGHomeController *Cvc= [[HGHomeController alloc]init];
//    UINavigationController *Cnvc =[[UINavigationController alloc]initWithRootViewController:Cvc];
//    
//    [self addChildViewControllerWith:Cnvc Title:@"发现" imageName:@"faxian"];
//    
//    LastViewController *lavc =[[LastViewController alloc]init];
    
    //我的
     MineViewController *lavc =[[MineViewController alloc]init];
    UINavigationController *lnvc =[[UINavigationController alloc]initWithRootViewController:lavc];
    NSUserDefaults *UserDefault =[NSUserDefaults standardUserDefaults];
    
    NSString *ShouY = [NSString stringWithFormat:mainUrl];
    NSLog(@" shouYie =%@ ",ShouY);
    
    NSDictionary * dict =[NSDictionary dictionaryWithObjectsAndKeys:@"test",@"token",@"",@"adfloor",@"413",@"ll",[UserDefault objectForKey:@"Useid"],@"member_id",nil];
    NSLog(@"dict is =%@",dict);
    [[RequestManger share]requestDataByPostWithPath:ShouY dictionary:dict complete:^(NSDictionary * data) {
        NSLog(@"this is data = %@",data);
        if ([data objectForKey:@"error"]) {
//            [self.view hideToastActivity];
            UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [failAlView show];
        }else{
            lavc.str=[NSString stringWithFormat:@"%@",[data objectForKey:@"notReadMsg"]];
            if ([lavc.str isEqualToString:@"0"]) {
                return;
            }else {
                lnvc.tabBarItem.badgeValue = lavc.str;
            }
        }
    }];
    

    [self addChildViewControllerWith:lnvc Title:@"我的" imageName:@"mine"];
    
    //设置 UINavigationBar 字体，颜色，大小属性
    UIFont* font = [UIFont fontWithName:@"Arial-ItalicMT" size:18.0];
    
    /*** changed by zhangjinjing 修改底部导航栏被点击文字的颜色  ***/
    
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1]};
    // [[UINavigationBar appearance]setTitleTextAttributes:textAttributes];
    [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateSelected];
    NSArray *tabArr =@[Fnvc,tnvc,Cnvc,snvc,lnvc];
    self.viewControllers =tabArr;


}

//- (void)addChildViewControllerWith:(UINavigationController *)NavigationController Title:(NSString *)title imageName:(NSString *)imagename{
//    // 首页
//    NavigationController.title =title;
//    
//    NavigationController.tabBarItem.image =[[UIImage imageNamed: [NSString stringWithFormat:@"%@_normal",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    NavigationController.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_activate",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//}

/*** changed by zhangjinjing ***/

- (void)addChildViewControllerWith:(UINavigationController *)NavigationController Title:(NSString *)title imageName:(NSString *)imagename{
   
    NavigationController.title =title;
    
    NavigationController.tabBarItem.image =[[UIImage imageNamed: [NSString stringWithFormat:@"%@_normal",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    NavigationController.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_activate",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
