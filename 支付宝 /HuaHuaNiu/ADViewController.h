//
//  ADViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIScrollView *BackView;
  // 顶部的Image
    UIImageView *topImage ;
// 滚动的Scroller
    UIScrollView *TuPianScroller;
    
// 相关产品的TV
    UITableView *_TV;
    NSMutableArray *TVdataArr;
    
//数据
    
    NSDictionary * DataDic;
    
// 产品或者商家ID
    NSString *XianqingID ;
    NSString *typeStr;
    
    BOOL  isShare;
}
-(id)initWithADStr:(NSString *)Str andType:(NSString * )type;
@end
