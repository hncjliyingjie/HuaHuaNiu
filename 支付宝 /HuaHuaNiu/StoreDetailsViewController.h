//
//  StoreDetailsViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coinView.h"


@interface StoreDetailsViewController : UIViewController<UIAlertViewDelegate,UIApplicationDelegate,coinViewDelegate>{
    UIAlertView *AlView;
    
    // 回复数组
    NSArray * replyArr;
    
    // 商家Id
    NSString *StoreId ;
    NSDictionary *DicData;
    UIScrollView *backView;

    // 顶部的 iamgeView
    UIImageView *topImageView ;
    //  电话号码Label；
    UILabel *phoneLabel;
    NSString * PhoneStrrr;
    // 地址Label
    UILabel *AddressLabel;
    //代言人  Btn
    UIButton * laysBtn;

}
@property (strong, nonatomic) coinView *coinview;
-(id)initWithStr:(NSString *)str;
@end
