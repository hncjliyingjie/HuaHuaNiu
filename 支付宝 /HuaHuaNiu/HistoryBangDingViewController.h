//
//  HistoryBangDingViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryBangDingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tv;
    NSMutableArray *dataArr;
    
// 判断是否 隐藏删除键
    BOOL HIDDLE;
    UIButton *deletBtn;
    // 记录 删除的 商家ID
    NSMutableArray *bsidArr;
    
    
    
    
}

@end
