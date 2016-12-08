//
//  ShouCangViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouCangViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    //是否显示删除
    BOOL  HIddle;
    
    NSString * ttye;
    NSString  * ssstr;
    
    
  // 商户
    UITableView * StorTV ;
    NSMutableArray *StoreDataArr;
    UIButton *StoreBtn;
  // 商品
    UITableView * ProductTV;
    NSMutableArray *ProductDataArr;
    UIButton * ProductBtn;
    
    
    // 暂无 收藏商品
    UILabel * Storelabel ;
    // 暂无收藏 商家
    UILabel * productlabel;
// 是否是 删除商品
    BOOL   isproductdele;
}

@end
