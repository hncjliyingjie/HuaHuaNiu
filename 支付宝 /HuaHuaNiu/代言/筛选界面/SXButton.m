//
//  SXButton.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SXButton.h"

@implementation SXButton
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    if(self = [super initWithFrame:frame]){
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.borderColor = GrayColor.CGColor;
        self.layer.borderWidth = 1.0f;
        [self setTitleColor:TitleColor forState:UIControlStateSelected];
        [self setTitleColor:GrayColor forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
       
        //        self.titleLabel.text = title;
    }
    return self;
}

@end
