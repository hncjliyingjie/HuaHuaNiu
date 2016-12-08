//
//  MianFeiTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TrueModel;
@interface MianFeiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ImageVeiw;





@property (weak, nonatomic) IBOutlet UILabel *ConcentLabel;

- (IBAction)qianggouAction:(id)sender;

-(void)makeCellWithModel:(TrueModel *)model;



@end
