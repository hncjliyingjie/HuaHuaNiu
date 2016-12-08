//
//  BiglogView.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiglogView : UIView{
  
    void(^ChangePhotoBlocks)(UIImage * IconIma);
    void(^EnterXiangqingBlocks)(NSString *Str);

}
@property (weak, nonatomic) IBOutlet UIImageView *IconImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *YestadayLabel;

@property (weak, nonatomic) IBOutlet UILabel *AllLabel;

@property (weak, nonatomic) IBOutlet UILabel *BalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *DengJiLabel;// 等级
@property (weak, nonatomic) IBOutlet UILabel *JFLabel;// 积分
@property (weak, nonatomic) IBOutlet UILabel *SignLabel;
@property (weak, nonatomic) IBOutlet UILabel *YesAddfensiLabel;
@property (weak, nonatomic) IBOutlet UILabel *ZhijieFenSiLabel;
@property (weak, nonatomic) IBOutlet UILabel *GuanLianFenSILabel;
- (IBAction)JinRuXiangQingAction:(id)sender;

-(void)makeBlocksAboutXiangQing:(void(^)(NSString *Str))Blocks;
-(void)setWithDic:(NSDictionary *)dic;

















@end
