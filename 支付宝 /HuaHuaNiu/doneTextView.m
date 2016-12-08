//
//  doneTextView.m
//  MeiPinJie
//
//  Created by mac on 15/11/23.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "doneTextView.h"

@implementation doneTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        
    }
    return self;
}

- (void)keyboardDidHide:(NSNotification *)note{
    if (self.doneButton) {
        self.doneButton.hidden = YES;
    }
}

- (void)keyboardDidShow:(NSNotification *)note{
    UIWindow *tempWindow = nil;
    UIView *keyboard = nil;
    tempWindow = [[[UIApplication sharedApplication] windows]objectAtIndex:1];
    if (tempWindow == nil) {
        return;
    }
    NSInteger viewCount = [tempWindow.subviews count];
    
    for (int i = 0; i < viewCount; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
        {
            if(([[keyboard description] hasPrefix:@"<UIPeripheralHostView"] == YES) ||(([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)))
            {
                NSLog(@"find UIKeyboard or UIPeripheralHostView");
                [self creatDoneButton];
                [keyboard addSubview:_doneButton];
                break;
            }
        }
        else
        {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
            {
                NSLog(@"find UIKeyboard");
                break;
            }
        }
    }
    
}


-(void)creatDoneButton
{
    // 在键盘第1次弹出时，创建按钮
    
    if (self.doneButton == nil) {
        
        self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        self.doneButton.hidden=YES;
        
        //定制按钮上面要显示的文字，也可以在创建该对象时自定义，本文只自定义了按钮上面的显示文字为：buttonTitle
        
        [self.doneButton setTitle:@"发送" forState:UIControlStateNormal];   // 设置按钮的位置在恰当的地方
        
        [self.doneButton setFrame:CGRectMake(773/2.0, 250/2.0, 180/2.0, 68/2.0)];
        
        [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.doneButton setTitle:@"hello" forState:UIControlStateNormal];
        
        // 设置按钮背景图片
        
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"music_starHead_1.png"] forState:UIControlStateNormal];
        
        // 当按钮按下时，触发doneButton方法
        
        [self.doneButton addTarget:self action:@selector(doneButton:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    
//    if (self.editing) {  // 只有当前输入框会显示done按钮
//        
//        self.doneButton.hidden = NO;
//        
//    } else {
//        
//        self.doneButton.hidden = YES;
//        
//    }
}

//定制按钮的点击事件

- (void)doneButton:(id)sender {
    
    
    
    self.doneButton.hidden=YES;
    
    [self resignFirstResponder];
    
    if (_doneEven!=nil) {  // block 回调
        
        _doneEven(sender);
        
    }
    
}


@end
