//
//  ProductDetailViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coinView.h"

@class  GouWView;
@interface ProductDetailViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate,UIApplicationDelegate,coinViewDelegate>{
   // 界面的数据
    
    NSDictionary *DicDate;

    // 顶部的ScrollView 和pageController
//    UIScrollView *TopScroller;
//    NSMutableArray *TopScrollerArr;
//    UIPageControl *_pageControl;    //页面控制器
//    NSTimer *MYtimer;
//    CGFloat j;
    UIScrollView *backView;
     //产品名
     UILabel *ProductNameLabel;
     // 价格
     UIView  *PriceView;
    // 地址
    UIView * AddressView;
   // 优惠活动
    UIView * FavorableVIew;
    //产品介绍
    UIView *IntroduceView;
    // 图文详情
    UIView *Xiangqing;
    // 产品参数页面
    UIView *ChanPinCanShuView;
    UIImageView *secondRIma;//  箭头
     // 产品参数内容View‘
    UIView *ChanPinCanShuNeiRView;
    // 产品评论页面
    UIView *LeiJIpingLunView;
    UIView *LeiJiPingLunNeiRView;
    UIImageView *ThirdRIma;
    // 打电话
    UIView *PhoneView;
    //进入商家商店
    UIButton *ComeInStore;
// 进入商家详情
    UIButton * StoreXiangqing;
    
    // 用户ID
    NSString *UserID;
    //产品ID
    NSString *ProductId ;
    
    // 回复数组
    NSArray * replyArr;
    
    //分享
    UIImageView *shareView;
    
    // 购物车VIew；
    GouWView *gouView;
}
@property (strong, nonatomic) coinView *coinview;
-(id)initWithStr:(NSString *)str;

@end
