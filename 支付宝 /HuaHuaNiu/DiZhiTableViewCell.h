//
//  DiZhiTableViewCell.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiZhiTableViewCell : UITableViewCell{
    
    NSString *  adressID ;
    
    NSDictionary * XiuGaidic;
    
    void (^ChangeMessAgeBlocks)(NSDictionary *dic);
    void(^deleMessageBlocks)(NSDictionary *dic);
  // 重新刷新数据
    void(^qiuqiuBlocks)(NSDictionary * Dic);
}
-(void)ChangeBlocks:(void (^)(NSDictionary *dic))Blocks;
-(void)deleBlocks:( void(^)(NSDictionary *dic))Blocks;

-(void)qingqiushuuBlocks:(void(^)(NSDictionary * Dic))Blocks;


@property (weak, nonatomic) IBOutlet UIImageView *BJimag;
@property (weak, nonatomic) IBOutlet UIButton *Bjbtn;

@property (weak, nonatomic) IBOutlet UIImageView *scimag;

@property (weak, nonatomic) IBOutlet UIButton *scBtn;




- (IBAction)MorenAction:(id)sender;

- (IBAction)DeletAction:(id)sender;
- (IBAction)BianJiAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *PhoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *DiQuLabel;

@property (weak, nonatomic) IBOutlet UILabel *YOuBian;
@property (weak, nonatomic) IBOutlet UILabel *AddresssLabel;

-(void)dizhiCellWithDic:(NSDictionary *)Dic;














@end
