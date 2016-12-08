//
//  TFCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
//微信，微博，qq图标
@property (weak, nonatomic) IBOutlet UIButton *jiahaoBtn;//加号
@property (weak, nonatomic) IBOutlet UIButton *jianhaoBtn;//减号
@property (weak, nonatomic) IBOutlet UITextField *tfTextField;//投放数量

@end
