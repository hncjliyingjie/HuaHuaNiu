//
//  DingDanJSViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15/6/24.
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
//@property (nonatomic,strong) NSString *order_type;

@end

@interface DingDanJSViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,WXApiDelegate>{
    NSDictionary * DataDic;
    //支付方式的tableView
    int a;  // 默认 20 支付宝 1 微信呢 2
    UITableView *ZhiTv;
    NSMutableArray * ZhiFDataArr;
    
    
    // 个人信息
    AddresslView * TopAddView;
    // 数据
    NSDictionary *AddressDic;
    
   

    //  付款金额
    UILabel * AllPricelabel;
   // 总金额
    NSString *allprice;
    // 提交订单返回 订单ID
    NSString  * dingStr;
    NSString *order_type;
    //微信  是否选择支付方式
    BOOL  mmmm;
}
-(id)initWithDic:(NSDictionary *)dic;

@end
