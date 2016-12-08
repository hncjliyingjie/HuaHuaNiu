//
//  TureViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    // 关于倒计时倒计时的描述
    int daojimiaoshu;
    // 定时器
    NSTimer * _timer;
    NSString * DingWeistr;
    
    int shi;
    int fen;
    int miao;
    // 倒计时效果label
    
    
    
    UITableView *_tv;
    NSMutableArray *dataArr;
    
    UILabel *TimerLabel ;
    
    // 省份列表
    NSArray * ProlistArr;
    // 当前城市
    NSString * CityStr ;
    
    // 免费时间
    NSString *  FirstTime;
    NSString *  secondTIme;
    
    int page ;
    
}

@end
