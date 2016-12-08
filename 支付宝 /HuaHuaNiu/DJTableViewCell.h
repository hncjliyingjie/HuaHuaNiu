//
//  DJTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageIma;
@property (weak, nonatomic) IBOutlet UILabel *NameLaebl;
@property (weak, nonatomic) IBOutlet UILabel *PeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *FenLeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *JuLiLabel;

-(void)DJcellMakeWithDic:(NSDictionary *)dic;
@end
