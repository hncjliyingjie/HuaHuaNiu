//
//  HistoryTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell{
    void(^ShareBlock)(NSString * Str);
    void(^DeleteBlocks)(NSDictionary *dic);
}
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *StoreName;

@property (weak, nonatomic) IBOutlet UILabel *TimerLabel;

@property (weak, nonatomic) IBOutlet UILabel *MoneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *XinImageView;

@property (weak, nonatomic) IBOutlet UIButton *shaeBtnss;



-(void)shareUserBlock:(void(^)(NSString * Str))Blocks;

-(void)CelldeleteBlocks:(void(^)(NSDictionary *dic))Blocks;

- (IBAction)SharAvtion:(id)sender;

- (IBAction)DelegateHostoryAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *deldegateBtn;

-(void)cellHistoryWithDic:(NSDictionary *)dic;


@end
