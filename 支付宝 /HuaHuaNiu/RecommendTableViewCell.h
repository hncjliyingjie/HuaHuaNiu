//
//  RecommendTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bindStoreModel.h"
@interface RecommendTableViewCell : UITableViewCell{
    NSString * StoreID;
    //  传参 商家 名字
    void(^TishiBlocks)(NSString *Str);
}

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *StoreName;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *FlowerLabel;
- (IBAction)BangDingAction:(id)sender;
- (void)TishiBlocksShow:(void(^)(NSString *Str))Blocks;



-(void)coremmondcellmakeWithModel:(bindStoreModel *)model;
@end
