//
//  MyLaysViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLaysViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>{
  
    
    UITableView *_Tv;
    NSArray *DataArr ;
}

@end
