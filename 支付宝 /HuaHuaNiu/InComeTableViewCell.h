//
//  InComeTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InComeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


-(void)INcellmakeWithDic:(NSDictionary *)dic;

@end
