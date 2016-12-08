//
//  YHSheQuSendView.h
//  HuaHuaNiu
//
//  Created by YongHeng on 16/8/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSheQuSendViewDelegate <NSObject>

-(void)sendButtonDidClicWithTextField:(UITextField *)textField;

@end

@interface YHSheQuSendView : UIView
@property (nonatomic,weak) id<YHSheQuSendViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
