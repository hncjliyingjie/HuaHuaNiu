//
//  ZhiGongViewController.m
//  HuaHuaNiu
//
//  Created by yuanzhi on 16/3/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZhiGongViewController.h"
#import "SearchReaultViewController.h"
@interface ZhiGongViewController ()
@property (strong, nonatomic) IBOutlet UIButton *duihuanButton;
@property (strong, nonatomic) IBOutlet UIButton *pinpaiButton;

@end

@implementation ZhiGongViewController
-(void)viewWillAppear:(BOOL)animated{

}
-(IBAction)duihuan:(id)sender{
    self.duihuanButton.titleLabel.textColor = [UIColor redColor];
    self.pinpaiButton.titleLabel.textColor = [UIColor blackColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
       // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
