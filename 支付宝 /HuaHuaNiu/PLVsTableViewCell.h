//
//  PLVsTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLVsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *UserNameLaebl;
@property (weak, nonatomic) IBOutlet UILabel *TImeLabel;

@property (weak, nonatomic) IBOutlet UILabel *PingLunLabel;

@property (weak, nonatomic) IBOutlet UILabel *HuiFuLabel;



-(void)PLCellMakeWithDic:(NSDictionary *)dic;






































































@end
