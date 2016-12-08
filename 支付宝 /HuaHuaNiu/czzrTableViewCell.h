//
//  czzrTableViewCell.h
//  HuaHuaNiu
//
//  Created by wcs on 16/1/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface czzrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@property (weak, nonatomic) IBOutlet UILabel *textsss;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;

@end
