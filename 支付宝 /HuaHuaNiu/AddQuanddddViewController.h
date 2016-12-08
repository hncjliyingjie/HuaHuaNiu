//
//  AddQuanddddViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-26.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddQuanddddViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tv ;
    NSMutableArray *DataArr;
    int page;
    NSString * DingWeistr ;

}



@end
