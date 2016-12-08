//
//  SearchReaultViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-8.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchReaultViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *DataArr;
    UITableView *MyTableView;
    
    // 搜索的内容
    NSString *SearchStr;

}
-(id)initWithStr:(NSString *)Str;

@end
