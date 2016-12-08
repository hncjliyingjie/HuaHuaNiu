//
//  HoMFJLViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoMFJLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *_tv;
    NSMutableArray *dataArr;
    NSMutableArray* deleArr;
    
    BOOL HIddle;
    // 底部 删除 的Btn 和背景
    UIButton *deletBtn;
    UIView *diBView ;
}


@end
