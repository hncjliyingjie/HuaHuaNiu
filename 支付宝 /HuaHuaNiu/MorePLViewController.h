//
//  MorePLViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MorePLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_Tv;
    NSArray *DataArr;
    NSString * StoreID ;

}
-(id)initWithStr:(NSString *)Str;
@end
