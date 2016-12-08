//
//  DingDanceViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Products : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end


@interface DingDanceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tv ;
// 多少个组
    NSMutableArray * GroupDataArr;
// 每个组的内容
    NSMutableArray * DataArr;
// 订单的ID
    NSString * orderStr;
// 订单的金额
    NSString * acount;
// 订单的类型;
    NSString *order_type;
    
  
    
  
}

@end
