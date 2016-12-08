//
//  StoressssssTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WanShangModel.h"
@interface StoressssssTableViewCell : UITableViewCell{
     // 判断绑定的 状态  0 未绑定 1 寻找代言人 2 已绑定
    NSString *str ;
}
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DaiYanLabel;
@property (weak, nonatomic) IBOutlet UILabel *FenleiLabel;
@property (weak, nonatomic) IBOutlet UILabel *DiZhiLabel;

@property (weak, nonatomic) IBOutlet UIImageView *QuanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *DuiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *MianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ZhaoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *KanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ShiImageView;


-(void)MadddWithDic:(NSDictionary *)dic;
-(void)makeCellWithModel:(WanShangModel *)model;

@end
