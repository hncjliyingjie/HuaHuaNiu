//
//  DaiJinQTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiJinQTableViewCell : UITableViewCell{
    // 卡券 ID
    NSString * voucherID;
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabe;

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UILabel *Timerlabel;
@property (weak, nonatomic) IBOutlet UILabel *tianshuLabel;


@property (weak, nonatomic) IBOutlet UILabel *MianZhiLabel;


-(void)dajincellmakeWithDic:(NSDictionary *)dic;










@end
