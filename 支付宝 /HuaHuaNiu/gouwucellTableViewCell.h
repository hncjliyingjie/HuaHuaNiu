//
//  gouwucellTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gouwucellTableViewCell : UITableViewCell<UITextFieldDelegate>{
    
    // rec_id 购物车id
    NSString * rec_id;
    
//  计算 总金额 改变数量后调用
    void(^JieSuanBlocks)(NSString *Number , NSString *recl_id);
 // 删除
    void(^delesBllcks)(NSString *MYrec_id);
    
}
-(void)deleActionBlocks:( void(^)(NSString *MYrec_id))Blocks;
-(void)cellMakeDateWithDic:(NSDictionary *)dic;

-(void)MakeJieSuanBlocks:(void(^)(NSString *Number , NSString *recl_id))Blocks;


@property (weak, nonatomic) IBOutlet UIImageView *DeleImage;




@property (weak, nonatomic) IBOutlet UIImageView *IconImagg;



@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UITextField *NumberField;

@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;













@end
