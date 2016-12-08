//
//  MFXQViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFXQViewController : UIViewController<UIAlertViewDelegate>{
    
    // 关于倒计时倒计时的描述
    int daojimiaoshu;
    // 定时器
    NSTimer * _timer;

    int shi;
    int fen;
    int miao;
    int tian;
    
    NSString * Mfstr;
    BOOL CanQiang;
    // 数据
    NSDictionary * dic;
}

@property (weak, nonatomic) IBOutlet UILabel *tianLB;
@property (nonatomic,strong) NSString * gf_id;

@property (weak, nonatomic) IBOutlet UIImageView *IconImage;

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *DaiYanLabel;

@property (weak, nonatomic) IBOutlet UILabel *PhoneLaebl;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;


- (IBAction)QiangDanAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *TimeView;
@property (weak, nonatomic) IBOutlet UILabel *ShiLabel;

@property (weak, nonatomic) IBOutlet UILabel *fenLabel;

@property (weak, nonatomic) IBOutlet UILabel *MiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *surplusLabel;
@property (weak, nonatomic) IBOutlet UIView *TImerBackView;

@property (weak, nonatomic) IBOutlet UILabel *ShengyuLabel;

@property (weak, nonatomic) IBOutlet UILabel *YIQiangLabel;

@property (weak, nonatomic) IBOutlet UILabel *concentLaebl;
//  详情View
@property (weak, nonatomic) IBOutlet UIView *XQDDVIew;



@property (nonatomic,assign)BOOL isJieShu;
// qiang  判断是抢购进入YES  还是查看领奖记录进入 NO
-(id)initWithStr:(NSString * )mianfID andqiang:(BOOL)qiang;


- (IBAction)DdianHauAction:(id)sender;

- (IBAction)MApViewAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *QiangGouBtn;











@end
