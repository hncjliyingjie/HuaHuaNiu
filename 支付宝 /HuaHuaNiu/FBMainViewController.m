//
//  FBMainViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FBMainViewController.h"
#import "XZViewController.h"
#import "DYMainViewController.h"
#import "JDViewController.h"
#import "ARSViewController.h"
@interface FBMainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *zsBtn;//安展示点击按钮
@property (weak, nonatomic) IBOutlet UIButton *fgBtn;//按覆盖人数ann
@property (weak, nonatomic) IBOutlet UIButton *jdBtn;//按接单人数按钮
@property (weak, nonatomic) IBOutlet UIButton *dyBtn;//指定代言人按钮
@property (weak, nonatomic) IBOutlet UIButton *xzBtn;//发布APP下载任务

@end

@implementation FBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.dyBtn addTarget:self action:@selector(dyDone:) forControlEvents:UIControlEventTouchUpInside];
     [self.jdBtn addTarget:self action:@selector(jdDone:) forControlEvents:UIControlEventTouchUpInside];
//     [self.fgBtn addTarget:self action:@selector(fgDone:) forControlEvents:UIControlEventTouchUpInside];
//     [self.zsBtn addTarget:self action:@selector(zsDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.xzBtn addTarget:self action:@selector(xzDone:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
//指定代言人
-(void)dyDone:(id)sender{
    
    DYMainViewController *mainVC=[[DYMainViewController alloc]init];
    mainVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mainVC animated:YES];

}
//按接单人数
-(void)jdDone:(id)sender{
    
    ARSViewController *ajdVC=[[ARSViewController alloc]init];
    ajdVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ajdVC animated:YES];
}
-(void)fgDone:(id)sender{
    ARSViewController *ajdVC=[[ARSViewController alloc]init];
    ajdVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ajdVC animated:YES];
}
-(void)zsDone:(id)sender{
    ARSViewController *ajdVC=[[ARSViewController alloc]init];
    ajdVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:ajdVC animated:YES];
}
//发布APP下载任务
-(void)xzDone:(id)sender{
    XZViewController *vc=[[XZViewController alloc]initWithNibName:@"XZViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
