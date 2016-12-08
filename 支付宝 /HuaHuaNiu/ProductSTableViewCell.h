//
//  ProductSTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSTableViewCell : UITableViewCell{
    void(^deleBlockss)();
}
@property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *HuodongImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *Numberlabel;

@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;

@property (weak, nonatomic) IBOutlet UIButton *DeleBtn;

-(void)makeProductDic:(NSDictionary *)Dic;

-(void)deleBee:( void(^)())Blocks;

- (IBAction)DeleActions:(id)sender;





@end
