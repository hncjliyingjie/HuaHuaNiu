//
//  RecommendViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *_tv;
    NSMutableArray *dataArr;
    // 绑定后的 背景和文字
    UIView * LabelView;
    UIView  *tishiBakViw;
    int pagenumber;
}


@end
