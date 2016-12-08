//
//  HYView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/25.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "HYView.h"

@implementation HYView
+(HYView*)allochyView
{
    HYView *dyView=[[[NSBundle mainBundle]loadNibNamed:@"HYView" owner:self options:nil]firstObject];
    return dyView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
