//
//  TJDDDTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJDDDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *XiaoJILabel;

@property (weak, nonatomic) IBOutlet UIImageView *ImaegICView;





-(void)cellMakeWithDicss:(NSDictionary *)dic;
@end
