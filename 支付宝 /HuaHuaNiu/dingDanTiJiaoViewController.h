//
//  dingDanTiJiaoViewController.h
//  HuaHuaNiu
//
//  Created by 洪慧康 on 16/3/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dingDanTiJiaoViewController : UIViewController
{
    
}
@property(nonatomic,strong)IBOutlet UILabel*lableName;
@property(nonatomic,strong)IBOutlet UILabel*lableTell;
@property(nonatomic,strong)IBOutlet UILabel*lableAdress;
@property(nonatomic,strong)IBOutlet UILabel*lableTitle;
@property(nonatomic,strong)IBOutlet UILabel*lableYinYuan;
@property(nonatomic,strong)IBOutlet UILabel*lableYunFei;
@property(nonatomic,strong)IBOutlet UILabel*lableJinE;
@property(nonatomic,strong)IBOutlet UIButton*butFirst;
@property(nonatomic,strong)IBOutlet UIView*zhiFuView;
@property(nonatomic,strong)IBOutlet UILabel*lableZongJinE;
@property(nonatomic,strong)IBOutlet UILabel*lableZongJinEShu;
@property(nonatomic,strong)IBOutlet UIButton*butZhiFu;
@property(nonatomic,strong)IBOutlet UIImageView*zhiFuBaoImg;
@property(nonatomic,strong)IBOutlet UIImageView*weiXinImg;
@property(nonatomic,strong) NSString *titleStr;
@property(nonatomic,strong) NSString *yinYuanStr;
@property(nonatomic,strong) NSString *yunFeiStr;
@property(nonatomic,strong) NSString *storeIdStr;
@property(nonatomic,strong) NSString *goodsIdStr;
@property (strong, nonatomic) IBOutlet UIButton *youjiButton;
@property (strong, nonatomic) IBOutlet UIButton *duihuanButton;

@property (nonatomic,strong) NSString * change_type;
@end
