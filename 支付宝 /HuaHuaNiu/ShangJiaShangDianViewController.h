//
//  ShangJiaShangDianViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-20.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShangJiaShangDianViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSString *StoreID ;
    
    UITableView *_tv;
    NSMutableArray *DataArr;
}
-initWithStoreID:(NSString *)stre;
@end
