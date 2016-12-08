//
//  KFView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/9.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "KFView.h"

@implementation KFView
+(KFView *)creatKFView{
    
    KFView *kfView=[[[NSBundle mainBundle]loadNibNamed:@"KFView" owner:self options:nil]firstObject];
    return kfView;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
