//
//  JDFirstCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *secoundLayerView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;//标题
@property (weak, nonatomic) IBOutlet UILabel *isAccpect;//认领状态
@property (weak, nonatomic) IBOutlet UILabel *end_time;//剩余时间
@property (weak, nonatomic) IBOutlet UILabel *share_pingtai;//分享平台
@property (weak, nonatomic) IBOutlet UILabel *phone;//电话号码

@property (weak, nonatomic) IBOutlet UILabel *jd_number;//接单人次

@end
