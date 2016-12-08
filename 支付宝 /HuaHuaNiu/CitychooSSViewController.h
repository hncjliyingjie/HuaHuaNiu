//
//  CitychooSSViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15/6/28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitychooSSViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    // 标示启动后第一次进入的  请求新的数据   否则 就用原来的数据
    
    BOOL  isStart;
    UILabel * cityLabel;

    // 分组的标题
    NSMutableArray * titleArr;
    NSMutableArray * titleArr2;


    UITableView *_TV;
    
    NSMutableArray * DataArr;

    // 接受返回的城市数据
    NSDictionary * dic ;

}

@end
