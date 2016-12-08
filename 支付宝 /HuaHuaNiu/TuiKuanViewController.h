//
//  TuiKuanViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TuiKuanViewController : UIViewController
-(id)initWithOrderId:(NSString *)orderid;
@property (nonatomic,strong)NSString * currentOrdId;
@end
