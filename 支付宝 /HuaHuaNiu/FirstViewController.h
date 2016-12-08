//
//  FirstViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "FindStoreView.h"
@interface FirstViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    
    // 判断是不是 城市选择进入的
    BOOL iscomefromcity;
    
    NSArray *morenArr;
    UIScrollView *ScrollVi;
    UIView * CityTopView;
    NSArray * CityAreaDataArr;
    NSMutableArray *JPData;
    NSMutableArray *nearData;
    NSMutableArray *MOKData;
    
    UIScrollView *BackScrollView;
    UIScrollView *TopView;
    UIPageControl *_pageControl;
    NSMutableArray *ScrollDataArr;
    NSMutableArray *CityData;
    UIView *MyView;
    NSTimer *MTimer;
    CGFloat j ;
    UIView *middleView;
    UITextField *TopTextField;
    UITableView *nearlyTv;
    UIView *FXLS ;
    UIView *JxView;
    BMKLocationService  * _locService ;
    BMKGeoCodeSearch* _geocodesearch;
    FindStoreView * Fvc;
    UIView *fenleiView;
    UIButton * FenleiBtn;
    UIButton *LeftBtn;
    NSString *typeStr;
    NSString * AddllStr;
    NSDictionary *DataDic;
}

@end
