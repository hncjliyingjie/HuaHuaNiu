//
//  HoMFJLTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoMFJLTableViewCell : UITableViewCell{
  // 删除的Arr；
    NSMutableArray * MUArr;
    // 领取的ID
    NSString *strId ;
// 返回 要删除的元素的数组
  //  void(^DeleBlocks)(NSString  * free_id);
}

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLae;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabe;
@property (weak, nonatomic) IBOutlet UILabel *concenetL;
@property (weak, nonatomic) IBOutlet UIButton *UserBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)BtnSelesecACtion:(id)sender;
// 删除的元素
//-(void)DeleBlocks:(void(^)(NSString  * free_id))Blocks;

- (IBAction)deleBtnActionss:(id)sender;


-(void)honcellMakeWIthDIc:(NSDictionary *)dic;




@end
