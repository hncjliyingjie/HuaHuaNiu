//
//  ShouZhiViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouZhiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _Tv ;
    NSArray * dataArr;
    
    /// 收入
    NSArray * ShouRuData;
    // 支出
    NSArray * ZhichuData;
  //提示label
    UILabel * tttlabel ;
}

@end
