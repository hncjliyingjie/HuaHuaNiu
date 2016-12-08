//
//  ShouHuoDiZViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-3.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShouHuoDiZViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView *_tv;
    NSMutableArray *dataArr;

    // 是不是 有添加地址返回的   YES 是
    BOOL  isTJBack;
    

    BOOL Dingdan;
    void(^DicBlocks)(NSDictionary * dic);
    
    NSString * wodeset;
}
-(void)makedataWithBlocks:(void(^)(NSDictionary * dic))Blocks;
// yes 订单过来
-(id)initWithDingDan:(BOOL )Ding;
@end
