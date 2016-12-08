//
//  DYTableViewCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

/*** changed by zhangjinjing ***/

#import <UIKit/UIKit.h>
#import "ZYTModel.h"
@interface DYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *friendLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *collectLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
@property (nonatomic, copy) void(^collectBlock)();
-(void)setCellWithData:(ZYTModel *)model;
@end
