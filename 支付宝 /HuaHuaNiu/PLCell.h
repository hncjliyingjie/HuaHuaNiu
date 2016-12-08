//
//  PLCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/18.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLbl;//评价内容
@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *nick_name;//昵称
@property (weak, nonatomic) IBOutlet UILabel *time;//时间
@property (weak, nonatomic) IBOutlet UILabel *content;//内容

@end
