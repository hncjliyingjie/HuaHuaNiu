//
//  PeisongTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-6.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeisongTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IcoImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *Sellabel;
@property (weak, nonatomic) IBOutlet UIImageView *IcoImage1;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *Sellabel1;
@property(weak,nonatomic)IBOutlet UIImageView *img;
@property(weak,nonatomic)IBOutlet UIButton *button1;
@property(weak,nonatomic)IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UILabel *StoreNameLabel;

-(void)cellMakeDataWithDic:(NSDictionary *)dic;
-(void)cellSearchWithDic:(NSDictionary *)dic;
-(void)cellMakeDataWithDic1:(NSDictionary *)dic;
@end
