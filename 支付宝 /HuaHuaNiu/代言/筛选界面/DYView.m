//
//  DYView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DYView.h"

@implementation DYView
+(DYView*)allocDyView
{
    DYView *dyView=[[[NSBundle mainBundle]loadNibNamed:@"DYView" owner:self options:nil]firstObject];
    return dyView;
}


@end
