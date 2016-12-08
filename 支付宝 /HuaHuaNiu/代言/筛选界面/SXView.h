//
//  SXView.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXView : UIView
@property (weak, nonatomic) IBOutlet UILabel *dyLbl;//地区
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dyViewHegiht;
@property (weak, nonatomic) IBOutlet UILabel *hyLabel;//行业
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UILabel *friendLabel;//好友数
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendViewHeight;

@property (weak, nonatomic) IBOutlet UIView *transView;//半透明view
@property (weak, nonatomic) IBOutlet UIButton *dqBtn;//地域按钮
@property (weak, nonatomic) IBOutlet UIButton *hyBtn;//行业按钮
@property (weak, nonatomic) IBOutlet UIButton *jgBtn;//价格按钮
@property (weak, nonatomic) IBOutlet UIButton *hysBtn;//好友数按钮
@property (weak, nonatomic) IBOutlet UIButton *ackDoneButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
+(SXView*)allocSxView;
@end
