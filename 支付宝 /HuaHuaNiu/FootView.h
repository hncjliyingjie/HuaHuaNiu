//
//  FootView.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootView : UIView
@property (weak, nonatomic) IBOutlet UIButton *zdyBtn;//自定义按钮
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
//立即开始按钮
@property (weak, nonatomic) IBOutlet UITableView *footTableView;//自定义时间
+(FootView*)creatView;
@end
