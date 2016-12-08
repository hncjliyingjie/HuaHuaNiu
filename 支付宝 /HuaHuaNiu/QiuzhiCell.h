//
//  QiuzhiCell.h
//  HuaHuaNiu
//
//  Created by alex on 15/10/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiuZhiModel.h"
@interface QiuzhiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *placeLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *expLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (nonatomic,strong) NSString * currentId;
-(void)makeCellWith:(QiuZhiModel *)model;
@end
