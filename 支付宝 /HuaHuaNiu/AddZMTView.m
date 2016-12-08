//
//  AddZMTView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/30.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "AddZMTView.h"

@implementation AddZMTView
+(AddZMTView *)initWithSelf{
    AddZMTView *addView=[[[NSBundle mainBundle]loadNibNamed:@"AddZMTView" owner:self options:nil]firstObject];
    
    return addView;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
