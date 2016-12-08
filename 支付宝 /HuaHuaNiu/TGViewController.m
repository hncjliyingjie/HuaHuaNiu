//
//  TGViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "TGViewController.h"
#import "JDTableViewController.h"
#import "FBMainViewController.h"
#import "Masonry.h"
@interface TGViewController ()
@property(strong,nonatomic)JDTableViewController *jdVc;
@property(strong,nonatomic)FBMainViewController *fbVc;
@property(strong,nonatomic)UIButton *leftBtn;
@property(strong,nonatomic)UIButton *rightBtn;

@end

@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIView *textView1=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 120, 30)];
    textView1.backgroundColor=[UIColor clearColor];
    [self.navigationItem setTitleView:textView1];
    textView1.layer.cornerRadius=8;
    
    _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    _leftBtn.tag=1;
    [_leftBtn setTitle:@"接 单" forState:UIControlStateNormal];
    [_leftBtn setBackgroundImage: [UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [textView1 addSubview:_leftBtn];
    
    _rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 0, 60, 30)];
    _rightBtn.tag=2;
    [_rightBtn setBackgroundImage: [UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
    [_rightBtn setTitle:@"发 布" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [textView1 addSubview:_rightBtn];
    
    //  一开始显示接单页面
    _jdVc=[[JDTableViewController alloc]init];
    _fbVc=[[FBMainViewController alloc]initWithNibName:@"FBMainViewController" bundle:nil];
    [self.view addSubview:_jdVc.view];
     [self addChildViewController:_jdVc];
    
    //添加跟view的约束
    [self addViewConstraints:_jdVc];
//    [self addViewConstraints:_fbVc];


}
-(void)selected:(UIButton *)sender{
    UIButton *btn=sender;
    if (btn.tag==1) {
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"white.png"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
       
        [_fbVc.view removeFromSuperview ];
        [self addChildViewController:_jdVc];
        [self.view addSubview:_jdVc.view];
        [self addViewConstraints:_jdVc];
    }
    if (btn.tag==2) {
        
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"leftWhite.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"rightBlue.png"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_jdVc.view removeFromSuperview];
        [self addChildViewController:_fbVc];
        [self.view addSubview:_fbVc.view];
        [self addViewConstraints:_fbVc];
    }
   
}
-(void)viewWillAppear:(BOOL)animated{
//    _jdVc=[[JDTableViewController alloc]init];
//    _fbVc=[[TGTableViewController alloc]init];
//    [self.view addSubview:_jdVc.view];
//    [self addViewConstraints:_jdVc];
//    [self addViewConstraints:_fbVc];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark 添加的view的约束
-(void)addViewConstraints:(UIViewController *)vc{
    
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(ConentViewWidth);
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-50);
    }];
}

@end
