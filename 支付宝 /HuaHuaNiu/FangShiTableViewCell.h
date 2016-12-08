//
//  FangShiTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-16.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FangShiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *DianImageview;
@property (weak, nonatomic) IBOutlet UIImageView *TuPianImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ShuomingLabel;



-(void)cellMakeWithDicss:(NSDictionary *)dic;

@end
