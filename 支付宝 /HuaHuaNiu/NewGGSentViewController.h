//
//  NewGGSentViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGGSentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tv;
    NSMutableArray *dataArr;
    int page ;
    
    
    NSString * DingWeistr;
}


@end
