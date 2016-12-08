//
//  GWTJViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddresslView.h"
#import "WXApi.h"
@interface Product : NSObject{
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


@interface GWTJViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,WXApiDelegate>{
    NSDictionary * DataDic;
    //支付方式的tableView
    int a;  // 默认 20 支付宝 1 微信呢 2
    UITableView *ZhiTv;
    NSMutableArray * ZhiFDataArr;
    
    
 // 个人信息
    AddresslView * TopAddView;
    // 数据
    NSDictionary *AddressDic;

    UITableView * _tv;
    NSMutableArray *GroupArr;
    //订单的字符串
    NSString *StoreIdstr ;
    // 配送的字符串
    NSString * PeiSongStr;
    // 运费的字符串
    NSString * YunFeiStr;
    //  付款金额
    UILabel * AllPricelabel;
    
    // 提交订单返回 订单ID
    NSString  * dingStr;
    
    //微信  是否选择支付方式
    BOOL  mmmm;
}
-(id)initWithDic:(NSDictionary *)dic;
@end
