//
//  WanShangViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WanShangViewControllerDelegate <NSObject>

-(void)WanShangViewController:(UIViewController *)con isComeFromCity:(BOOL)isComeFromCity;

@end

@interface WanShangViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    UIScrollView *BackScroll;
    // 判断是不是 城市选择进入的
    BOOL iscomefromcity;
    UIView * headerView;
    UITableView * _Tv ;
    NSMutableArray *DataArr;
    NSArray * FenleiArry;
    UIView * CityTopView ;
    NSMutableArray *CityAreaDataArr;
    UIScrollView * ScrollVi;
    UITextField * TopTextField; 
    UIView * TitleView;
    NSTimer * _Timer;
    NSString *ShouY ;
    NSString *  ll ;
    NSString *  memberId ;
    UIPageControl *_pageControl;
    UIScrollView *TopScrllView;
    NSMutableArray *ScrollDataArr;
    UIView *middleView ;
   int numberpage;
    BOOL isZuoB;
    NSString * DingWeistr;
    UILabel * zanwushuju;
}
@property (nonatomic, weak) id<WanShangViewControllerDelegate> delegate;
-(void)makeDataWithIs_ll:(NSString *)Str andzuoBiao:(BOOL )zuo;
@end
