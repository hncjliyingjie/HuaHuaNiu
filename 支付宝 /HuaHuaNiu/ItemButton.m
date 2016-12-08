//
//  ItemButton.m
//  MVVMTest
//
//  Created by baokuanxun on 16/11/18.
//  Copyright © 2016年 biubiubiu. All rights reserved.
//

#import "ItemButton.h"



@implementation ItemButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title{
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
