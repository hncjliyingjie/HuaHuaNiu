//
//  NearlySTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearlySTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


@property (weak, nonatomic) IBOutlet UILabel *DaiYanlabel;


-(void)makeCellWithModel:(AlexModel *)model;
@end
