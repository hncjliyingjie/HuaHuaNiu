//
//  SZTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TImeLabel;

@property (weak, nonatomic) IBOutlet UILabel *SZlabel;

-(void)SZCellMakeWithDIc:(NSDictionary *)dic;


@end
