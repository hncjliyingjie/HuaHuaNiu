//
//  DingDanDeatilViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//
@protocol DetailDelegate <NSObject>

-(void)reloadTabelView;
@end
#import <UIKit/UIKit.h>

@interface DingDanDeatilViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView * _tv ;
    // 多少个组
    NSMutableArray * GroupDataArr;
    // 每个组的内容
    NSMutableArray * DataArr;
    // 订单的ID
    NSString * orderStr;
    NSString *order_type;
    // 订单的金额
    NSString * acount;
    
    
    
    
    
}
@property (nonatomic,assign) id<DetailDelegate> delegate;
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@property(nonatomic,strong)NSString * currentStatas ;
@property (nonatomic,strong)NSString * currentOrdId;
@property (nonatomic,strong)NSString *order_type;//商品类型
-(id)initWithStats:(NSString *)statas andOrdId:(NSString *)ordId;

@end
