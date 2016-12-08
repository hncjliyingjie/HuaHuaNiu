//
//  share_linkCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface share_linkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *shiliLbl;
@property (weak, nonatomic) IBOutlet UIButton *yulanBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuzhiBtn;
@property (weak, nonatomic) IBOutlet UILabel *share_linkText;//链接地址
@property (weak, nonatomic) IBOutlet UILabel *share_Text;//分享语
@property (weak, nonatomic) IBOutlet UIView *bordView;


@end
