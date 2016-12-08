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
#import "YHZhiGongViewController.h"

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
-(void)makejiemian{

    // 首页
    FirstViewController *fvc =[[FirstViewController alloc]init];
    UINavigationController *Fnvc =[[UINavigationController alloc]initWithRootViewController:fvc];
    [self addChildViewControllerWith:Fnvc Title:@"首页" imageName:@"icon_home"];
    
    // 城堡
    WanShangViewController *tvc =[[WanShangViewController alloc]init];
    UINavigationController *tnvc =[[UINavigationController alloc]initWithRootViewController:tvc];
    [self addChildViewControllerWith:tnvc Title:@"城堡" imageName:@"icon_wanshang"];
    tnvc.title=@"城堡";
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"YHZhiGongViewController" bundle:[NSBundle mainBundle]];
    
    YHZhiGongViewController *svc = sb.instantiateInitialViewController;
    
    UINavigationController *snvc =[[UINavigationController alloc]initWithRootViewController:svc];

    [self addChildViewControllerWith:snvc Title:@"兑兑" imageName:@"icon_changgong"];
    HGHomeController *Cvc= [[HGHomeController alloc]init];
    UINavigationController *Cnvc =[[UINavigationController alloc]initWithRootViewController:Cvc];
    
    [self addChildViewControllerWith:Cnvc Title:@"视频" imageName:@"icon_shipin"];
    
    LastViewController *lavc =[[LastViewController alloc]init];
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
    

    [self addChildViewControllerWith:lnvc Title:@"我的" imageName:@"icon_my"];
    
    //设置 UINavigationBar 字体，颜色，大小属性
    UIFont* font = [UIFont fontWithName:@"Arial-ItalicMT" size:18.0];
    NSDictionary* textAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor redColor]};
    // [[UINavigationBar appearance]setTitleTextAttributes:textAttributes];
    [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateSelected];
    NSArray *tabArr =@[Fnvc,tnvc,Cnvc,snvc,lnvc];
    self.viewControllers =tabArr;



}

- (void)addChildViewControllerWith:(UINavigationController *)NavigationController Title:(NSString *)title imageName:(NSString *)imagename{
    // 首页
    NavigationController.title =title;
    
    NavigationController.tabBarItem.image =[[UIImage imageNamed: [NSString stringWithFormat:@"%@_normal",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    NavigationController.tabBarItem.selectedImage =[[UIImage imageNamed:[NSString stringWithFormat:@"%@_activate",imagename]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
