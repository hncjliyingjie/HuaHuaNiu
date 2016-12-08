//
//  DIngDanceTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIngDanceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;


@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PricecLabel;


@property (weak, nonatomic) IBOutlet UILabel *NumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *StatuLabel;

-(void)cellMakeWIthDic:(NSDictionary *)dic;
-(void)cellmakeDingdanStr:(NSString *)str;







@end
