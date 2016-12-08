//
//  LooKInComeViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LooKInComeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tv;
    NSMutableArray *dataArr;
    int page ;
    
    
    NSString * DingWeistr;
    }


@end
