//
//  WoDeTableViewCell.h
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *lableTitle;
@property(nonatomic,strong)IBOutlet UILabel *lableTime;
@property(nonatomic,strong)IBOutlet UILabel *lableCount;
@property (weak, nonatomic) IBOutlet UIView *readView;

@end
