//
//  DLRZViewController.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLRZViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *img;//头像
@property (weak, nonatomic) IBOutlet UILabel *name;//昵称
@property (weak, nonatomic) IBOutlet UITextField *friend_textField;//好友数
@property (weak, nonatomic) IBOutlet UITextField *guanggao_textField;//广告价
@property (weak, nonatomic) IBOutlet UIButton *renzheng_Btn;//认证按钮
-(void)initWithLoginXinxi:(NSDictionary *)dict;
@end
