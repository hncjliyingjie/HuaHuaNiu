//
//  PingJiaViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/12/24.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingJiaViewController : UIViewController
@property (nonatomic,strong)NSString * currentOrdId;
-(id)initWithOrderId:(NSString *)orderid;
@end
