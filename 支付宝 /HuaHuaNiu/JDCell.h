//
//  JDCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *secoundView;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIView *bigLineView;
-(void)cellWithStyle;
@property (weak, nonatomic) IBOutlet UILabel *link_text;//分享链接还是图文
@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *titleName;//标题
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;//个数100/100个
@property (weak, nonatomic) IBOutlet UILabel *lingquLbl;//已领完

@end
