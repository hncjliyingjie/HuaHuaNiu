//
//  SentTableViewCell.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
-(void)INcellmakeWithDic:(NSDictionary *)dic;
@property (weak, nonatomic) IBOutlet UILabel *contextLB;

@property (weak, nonatomic) IBOutlet UIButton *fuKuanButton;

@property (nonatomic, strong) NSDictionary *AdDict;

@end
