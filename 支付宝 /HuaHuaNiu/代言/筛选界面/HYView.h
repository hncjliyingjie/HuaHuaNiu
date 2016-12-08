//
//  HYView.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/25.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYView : UIView
+(HYView*)allochyView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *hyBtn;
@property (weak, nonatomic) IBOutlet UIButton *ackDoneButton;//确认按钮
@end
