//
//  ComeHomeViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgencyUIView.h"
@interface ComeHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>{

    UIScrollView  * topscrollView ;
    NSMutableArray * ScrolldataArr;
    
   
    NSTimer *MTimer;
    CGFloat j ;

    
    AgencyUIView *AGView;
    UITableView *_tv;
 
  
    NSDictionary * StoreDic ;
 
    NSMutableArray  *ProductDic;
    
    
    

    UIView * CityTopView ;

    NSMutableArray *CityAreaDataArr;
    UIScrollView * ScrollVi;
 

    NSMutableArray  * CityPlistArr;

    UIScrollView * BackView;

    

   UILabel *ADdressLabel;
    


    
    NSString * DingWeistr;
    
    UIView * headerView;
    
}



@end
