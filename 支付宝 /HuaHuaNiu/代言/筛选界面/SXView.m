//
//  SXView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SXView.h"

@implementation SXView
+(SXView*)allocSxView
{
    SXView *sxView=[[[NSBundle mainBundle]loadNibNamed:@"SXView" owner:self options:nil]firstObject];
    return sxView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
