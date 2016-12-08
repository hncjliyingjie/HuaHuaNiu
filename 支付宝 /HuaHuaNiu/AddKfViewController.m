//
//  AddKfViewController.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "AddKfViewController.h"

@interface AddKfViewController ()
@property (weak, nonatomic) IBOutlet UILabel *moreLbl;//复制客服微信等提示框

@end

@implementation AddKfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加客服";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.047 green:0.365 blue:0.663 alpha:1],NSForegroundColorAttributeName,nil]];
    //设置label换行
    [self viewWithStyle];
}

-(void)viewWithStyle{
    
    self.moreLbl.text=@"1、复制客服微信号，添加，将代言城的账号发送给客服;\r\n2、返回代言城，等待审核;";

}
@end
