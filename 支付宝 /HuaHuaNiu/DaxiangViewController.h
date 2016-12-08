//
//  DaxiangViewController.h
//  HuaHuaNiu
//
//  Created by alex on 16/1/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
@interface DaxiangViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    CGFloat _userContentOffsetX;
    BOOL _isLeftScroll;                             //是否左滑动
    BOOL _isRootScroll;                             //是否主视图滑动
    BOOL _isBuildUI;                                //是否建立了ui
    
    __weak id<SUNSlideSwitchViewDelegate> _slideSwitchViewDelegate;
    
    
    UITableView *MyTableView;
    NSArray *TableArr;
// 判断是不是 城市选择进入的
BOOL iscomefromcity;
NSString *Current_area ;
NSArray * AreaArr;
NSMutableArray *DataArr;

UILabel * tiishlable;

NSString *region_id;

NSString * allregion_id;


BOOL  isQuyu;
NSString * ll;
NSString * order  ;

NSString * PaiXu;
NSString * FenLeiStr ;

NSString * MYID;

int page;




int numbr;
NSArray * proviceArr;


UIView * BBViwe;

UIButton *YinPinBtn;

UIButton *JinPinBtn;

    
    
    UIView * CityTopView ;
    
    NSArray *CityAreaDataArr;
    UIScrollView * ScrollVi;
    
    
    NSMutableArray  * CityPlistArr;
    
    
    
    UITextField * TopTextField;
    UIView * TitleView;
    
    
    
    UIView * topFview;
    
    UITableView * FirstTv;
    NSArray *FirstTvDataArr;
    
    UITableView *SectionTv;
    NSArray *SectionTvDataArr;
    
    
    UITableView * MorenTv;
    NSArray *MorenTvDataArr;
    

}
@property (nonatomic, strong) SUNSlideSwitchView *slideSwitchView;
@property(nonatomic,strong)NSArray *mDataArray;
@property(nonatomic,retain)UITableView *datatableView;
@property(nonatomic,retain)NSMutableArray *tableViewData;


@end
