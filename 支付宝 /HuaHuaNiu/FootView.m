//
//  FootView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/15.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FootView.h"

@implementation FootView
+(FootView*)creatView{
    FootView *footView=[[[NSBundle mainBundle]loadNibNamed:@"FootView" owner:self options:nil]firstObject];
    footView.startBtn.tag=1;
    footView.zdyBtn.tag=2;
    return footView;

}

@end
