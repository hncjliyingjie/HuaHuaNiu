//
//  CollectionViewCell.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "CollectionViewCell1.h"
#import "UIImageView+WebCache.h"
#import "Model.h"
@implementation CollectionViewCell1

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    [self setOrigin:CGPointMake(frame.origin.x, frame.origin.y+160)];
    NSLog(@"%f",frame.origin.x);
    NSLog(@"%f",frame.origin.y);
    if (self) {
        _picImageView = [[UIImageView alloc]init];
        _picImageView1=[[UIImageView alloc]init];
        _picImageViewJ=[[UIImageView alloc]init];
        _picImageView2=[[UIImageView alloc]init];
        _lableJ=[[UILabel alloc]init];
        _lableS=[[UILabel alloc]init];
        _lableY=[[UILabel alloc]init];
        _picImageViewR=[[UIImageView alloc]init];
        _lable1=[[UILabel alloc]init];
        
        [_picImageView setBackgroundColor:[UIColor redColor]];
        _titleLable=[[UILabel alloc]init];
        _showLable=[[UILabel alloc]init];
        [_lableY setTextColor:[UIColor redColor]];
        [_lableS setFont:[UIFont systemFontOfSize:10]];
        [_lableY setFont:[UIFont systemFontOfSize:10]];
        [_lable1 setFont:[UIFont systemFontOfSize:10]];
        [_showLable setFont:[UIFont systemFontOfSize:10]];
        [_lableJ setFont:[UIFont systemFontOfSize:8]];
//        [_picImageViewR setBackgroundColor:[UIColor orangeColor]];
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
//        [_picImageView1 setBackgroundColor:[UIColor redColor]];
//        [_picImageView2 setBackgroundColor:[UIColor blueColor]];
//        [_picImageViewJ setBackgroundColor:[UIColor redColor]];
        [_lableJ setText:@"110km"];
        [_lableS setText:@"所需银元"];
        [_lableY setText:@"3000"];
        [_lable1 setText:@"174"];
        [self.contentView addSubview:_picImageView1];
        [self.contentView addSubview:_picImageView2];
        [self.contentView addSubview:_showLable];
        [self.contentView addSubview:_picImageView];
        [self.contentView addSubview:_picImageViewJ];
        [self.contentView addSubview:_lableJ];
        [self.contentView addSubview:_lableS];
        [self.contentView addSubview:_lableY];
        [self.contentView addSubview:_lable1];
        [self.contentView addSubview:_picImageViewR];
    }
    return self;
}
//-(void)butClick:(UIButton *)select{
//    NSLog(@"%li",select.tag);
//}
-(void)setModel:(Model *)model
{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:_model.simgfile]];
}
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _picImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height-60);
//    _button.frame=CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height-30);
    _showLable.frame=CGRectMake(0, layoutAttributes.frame.size.height-60, layoutAttributes.frame.size.width, 20);
    _picImageView1.frame=CGRectMake(0, layoutAttributes.frame.size.height-40, 20, 20);
    _picImageView2.frame=CGRectMake(30, layoutAttributes.frame.size.height-40, 20, 20);
    _picImageViewJ.frame=CGRectMake(layoutAttributes.frame.size.width-60, layoutAttributes.frame.size.height-40, 15, 15);
    _lableJ.frame=CGRectMake(layoutAttributes.frame.size.width-40,layoutAttributes.frame.size.height-40, 40, 20);
    _lableS.frame=CGRectMake(0, layoutAttributes.frame.size.height-20, 40, 20);
    _lableY.frame=CGRectMake(45, layoutAttributes.frame.size.height-20, 40, 20);
    _picImageViewR.frame=CGRectMake(layoutAttributes.frame.size.width-60, layoutAttributes.frame.size.height-20, 15, 10);
    _lable1.frame=CGRectMake(layoutAttributes.frame.size.width-40,layoutAttributes.frame.size.height-25, 40, 20);
}

@end
