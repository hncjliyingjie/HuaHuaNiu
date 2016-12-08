//
//  WDYTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDYTableViewCell : UITableViewCell{
    
    void(^ShareBlockss)(NSString * Str);


}

@property (weak, nonatomic) IBOutlet UIImageView *IcinnnImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


@property (weak, nonatomic) IBOutlet UIButton *sharBtns;

@property (weak, nonatomic) IBOutlet UILabel *BDTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *SYtime;
@property (weak, nonatomic) IBOutlet UILabel *momeylabel;

- (IBAction)sharactionssss:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *shareImage;

-(void)MaekShaeWithBlocks:( void(^)(NSString * Str))Blocks;

-(void)makeCellWithModel:(AlexModel *)model;













@end
