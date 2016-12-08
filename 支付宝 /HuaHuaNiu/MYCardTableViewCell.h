//
//  MYCardTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCardTableViewCell : UITableViewCell{
    NSString * CardStr ;

//  删除以后刷新
    void(^DeleBlack)();
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *CardLabel;

@property (weak, nonatomic) IBOutlet UIButton *DeleActionActions;

- (IBAction)ChangeCardAction:(id)sender;
-(void)deleBlockss:(void(^)())Blocks;
-(void)MYcellMakeWithDic:(NSDictionary * )dic;

@end
