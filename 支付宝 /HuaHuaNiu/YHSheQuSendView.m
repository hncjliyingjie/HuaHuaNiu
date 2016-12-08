//
//  YHSheQuSendView.m
//  HuaHuaNiu
//
//  Created by YongHeng on 16/8/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHSheQuSendView.h"


@interface YHSheQuSendView ()




@end
@implementation YHSheQuSendView

- (IBAction)sendButton:(id)sender {
    
    
    if ([self.delegate respondsToSelector:@selector(sendButtonDidClicWithTextField:)]) {
        [self.delegate sendButtonDidClicWithTextField:self.textField];
    }
    
    
    if (self.textField.text.length == 0)
    {
        
        return;
    }
    
    
}


@end
