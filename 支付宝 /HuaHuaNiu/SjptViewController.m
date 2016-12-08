//
//  SjptViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SjptViewController.h"
#import "GjrzViewController.h"
#import "ZLViewController.h"
@interface SjptViewController ()
@property (weak, nonatomic) IBOutlet UIButton *wsBtn;//完善基本资料按钮
@property (weak, nonatomic) IBOutlet UILabel *gjLbl;//改价标准
@property (weak, nonatomic) IBOutlet UIButton *delBtn;//删除资源
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确认删除
@property (weak, nonatomic) IBOutlet UIButton *rzBtn;//认证

@end

@implementation SjptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手机平台";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    //设置xib中的圆角等
    [self viewWithStyle];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWithStyle{
    self.gjLbl.layer.cornerRadius=5;
    self.gjLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.gjLbl.layer.borderWidth=1;
    
    self.delBtn.layer.cornerRadius=15;
    self.delBtn.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.delBtn.layer.borderWidth=1;
    
    self.okBtn.layer.cornerRadius=15;
    
    self.rzBtn.layer.cornerRadius=15;
    self.rzBtn.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1]CGColor];
    self.rzBtn.layer.borderWidth=1;
    [self.rzBtn addTarget:self action:@selector(rzDo:) forControlEvents:UIControlEventTouchUpInside];
     [self.wsBtn addTarget:self action:@selector(wsDo:) forControlEvents:UIControlEventTouchUpInside];
    
}
//点击认证
-(void)rzDo:(id)sender{
    
    GjrzViewController *vc=[[GjrzViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
//点击晚上基本资料
-(void)wsDo:(id)sender{
    
    ZLViewController *vc=[[ZLViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
