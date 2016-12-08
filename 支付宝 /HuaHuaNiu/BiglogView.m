//
//  BiglogView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "BiglogView.h"

@implementation BiglogView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)makeBlocksAboutXiangQing:(void (^)(NSString *))Blocks{
    EnterXiangqingBlocks =[Blocks copy];
}
- (IBAction)JinRuXiangQingAction:(id)sender {
    NSString *str ;
    EnterXiangqingBlocks(str);
}

-(void)setWithDic:(NSDictionary *)dic{
  // 获取登陆后的信息


// 在此处给 iconimage添加手势
    
//    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction)];
//    [self.IconImage addGestureRecognizer:tap];
//
//}
//-(void)TapAction{
//
//    //(@"点击了 头像" );
}

@end
