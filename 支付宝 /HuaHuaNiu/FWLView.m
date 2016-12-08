//
//  FWLView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/13.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "FWLView.h"

@implementation FWLView

+(FWLView *)creatFWView{
    
    FWLView *fwView=[[[NSBundle mainBundle]loadNibNamed:@"FWLView" owner:self options:nil]firstObject];
    fwView.frame=CGRectMake(0,40.5, ConentViewWidth, ConentViewHeight);
    UIButton *btn=[fwView viewWithTag:1001];
    btn.layer.cornerRadius=5;
    btn.layer.borderWidth=0.5;
    btn.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1]CGColor];
    return fwView;
    
}


@end
