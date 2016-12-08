//
//  TGCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *jsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *xzBtn;//发布下载任务
@property (weak, nonatomic) IBOutlet UIButton *smBtn;//发布扫码任务
@property (weak, nonatomic) IBOutlet UIButton *bkBtn;//发布绑卡任务
@property (weak, nonatomic) IBOutlet UIButton *qtBtn;//发布其他任务



@end
