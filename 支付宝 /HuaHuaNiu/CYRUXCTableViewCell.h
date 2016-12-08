//
//  CYRUXCTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRUXCTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CImaView;
@property (weak, nonatomic) IBOutlet UILabel *NmaeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ConcentLabel;



-(void)cellMakeWith:(NSString *)titleStr  andimaArr:(NSString *)imaStr andconcentArr:(NSString *)concentStr;
@end
