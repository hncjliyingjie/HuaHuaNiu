//
//  DaiJinQuanViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaiJinQuanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tv;
    int page;
}


@end
