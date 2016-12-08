//
//  ZYDetailViewController.h
//  HuaHuaNiu
//
//  Created by mac on 16/12/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDetailViewController : UIViewController
@property (nonatomic, strong) NSString *idStr;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
//发表评论的view
@property (weak, nonatomic) IBOutlet UIView *discussView;
//发表评论的输入框
@property (weak, nonatomic) IBOutlet UITextField *discussTextField;
//发表评论的按钮
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discussViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discussViewBottom;

@end
