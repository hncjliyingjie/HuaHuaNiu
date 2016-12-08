//
//  RightView.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "RightView.h"

@implementation RightView
- (instancetype)initWithFrame:(CGRect)frame withData:(NSMutableArray *)dataArr withTitle:(NSString *) title {
    if(self = [super initWithFrame:frame]){
        self.dataArr = [NSMutableArray arrayWithArray:dataArr];
        UILabel * titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        titleLbl.text = title;
        titleLbl.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLbl];
        
        //        UIView *lineView = [[UIView alloc]init];
        //        [self addSubview:lineView];
        //        lineView.backgroundColor = [UIColor colorWithWhite:0.969 alpha:1.000];
        //        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        //            make.height.mas_equalTo(1);
        //            make.left.mas_equalTo(self.mas_left).offset(15);
        //            make.right.mas_equalTo(self.mas_right).offset(-15);
        //        }];
    }
    return self;
}

-(void)setColumns:(NSInteger)columns{
    CGFloat maxHeight = self.frame.size.height;
    for(NSInteger i = 1 ; i<=self.dataArr.count; i++){
        //当前button 所在行数
        NSInteger row = (i % columns >0)?i / columns + 1:i / columns;
        //所在列
        NSInteger rank = i % columns ==0 ? columns : i %columns;
        NSLog(@"行 ----%ld,列 ----%ld",(long)row,(long)rank);
        //左右间隙
        CGFloat outLeftGap = 10.0f;
        //button左右之间的间隙
        CGFloat insideLeftGap = 5.0f;
        //顶部间隙
        CGFloat outTopGap =  5;
        //button上下之间的间隙
        CGFloat insideTopGap = 5;
        CGFloat itemWidth=(ScreenWidth-60)/3;
        //按钮的长度
        CGFloat length  = (itemWidth - 2 * outLeftGap - insideLeftGap * (columns-1))/columns;
        // 按钮的高度
        CGFloat height = 30;
        //计算button的frame
        CGRect btnFrame = CGRectMake(outLeftGap + (rank-1) * (length + insideLeftGap), outTopGap + (row-1) * (height+ insideTopGap), length, height);
        
        SXButton * button = [[SXButton alloc]initWithFrame:btnFrame withTitle:[self.dataArr objectAtIndex:i-1]];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(itemSelect:) forControlEvents:UIControlEventTouchUpInside];
        if(maxHeight < CGRectGetMaxY(btnFrame)){
            maxHeight =CGRectGetMaxY(btnFrame);
        }
    }
    CGRect frame = self.frame;
    frame.size.height = maxHeight+10;
    self.frame = frame;
}
- (void)itemSelect:(SXButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        sender.layer.borderColor = BorderColor.CGColor;
        //设置单选特性
        for (int i = 0 ; i <self.subviews.count ; i ++){
            id view = self.subviews[i];
            if([view isKindOfClass:[SXButton class]]){
                SXButton *button = (SXButton *)view;
                if(button.selected){
                    if([button isEqual:sender]){
                        self.selectBtn = sender;
                        continue;
                    }
                    else{
                        button.selected = NO;
                        button.layer.borderColor = GrayColor.CGColor;
                    }
                }
            }
        }
    }else{
        sender.layer.borderColor = GrayColor.CGColor;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
