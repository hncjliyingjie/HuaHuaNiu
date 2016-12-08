//
//  CardViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    UITableView *_Tv;
    NSArray *DataArr;

    // 要删除的银行卡信息
    NSDictionary * deledic;
    
    void(^TXBlocks)(NSDictionary *dic );
    
    BOOL TIXian;
}

// TX yes  提现进入的
-(id)initWitHTXian:(BOOL )TX;
-(void)MakeWithBlocks:(void(^)(NSDictionary *dic ))Blocks;

@end
