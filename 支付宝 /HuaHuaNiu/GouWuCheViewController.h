//
//  GouWuCheViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GouWuCheViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    //  删除 提示
    UIAlertView * delealerView;
    NSString * MYResc_id;
    // 是否删除后请求数据
    BOOL isdelegate;
    // 传给 结算的数据
    NSDictionary *JieSuandic ;
    
    
    UITableView *_tv ;
    NSMutableArray *DataArr;
    //  钱数
    UILabel *PriceTotalLabel;
    NSString * priceStr;
    float PriceTotal;
       //结算btn
    UIButton * acountBtn;
    // 结算的数量
    int acountNumber;
   //  是否全选
    BOOL  quanXuan;
    
    UIView * BottomView ;
   
    
    //判断 是否选中某一个产品 的  NSMutableArray
    NSMutableArray * BiaoJiArr;

}

@end
