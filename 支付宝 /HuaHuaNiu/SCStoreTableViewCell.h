//
//  SCStoreTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCStoreTableViewCell : UITableViewCell{
 
    void(^deleBlocks)();
  
}

@property (weak, nonatomic) IBOutlet UIButton *DeleBtn;

@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *FenleiLabel;

@property (weak, nonatomic) IBOutlet UIImageView *QuanView;

-(void)makeWithDic:(NSDictionary *)Dic;

-(void)deleBee:( void(^)())Blocks;

- (IBAction)DeleAction:(id)sender;


@end
