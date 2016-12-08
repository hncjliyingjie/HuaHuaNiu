//
//  ZhaoPinCellTableViewCell.h
//  HuaHuaNiu
//
//  Created by alex on 15/10/27.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhaoPinModel.h"
@interface ZhaoPinCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *placeLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
-(void)makeCellWithModel:(ZhaoPinModel *)model;
@end
