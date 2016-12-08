//
//  JDSecoundCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDSecoundCell.h"

@implementation JDSecoundCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *share_text=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, ConentViewWidth-10, 20)];
        share_text.text=@"分享图片";
        UILabel *shili=[[UILabel alloc]initWithFrame:CGRectMake(ConentViewWidth-40, 5, 20, 10)];
        shili.text=@"示例";
        shili.layer.cornerRadius=5;
        shili.layer.masksToBounds=YES;
        shili.backgroundColor=[UIColor grayColor];
        
        //设置图片的宽
        CGFloat imageW=ConentViewWidth/4;
        //设置图片的高
        CGFloat imageH=80;
        //设置图片的y
        CGFloat imageY=35;
        int imgCount=5;
        //添加图片
        for (int i=0; i <imgCount; i++)
        {
            UIImageView *imageView=[[UIImageView alloc]init];
            //每张图片的x
            CGFloat imageX=i *imageW;
            
            //设置imageview的frame
            imageView.frame=CGRectMake(15+imageX, imageY, imageW, imageH);
            
            //设置每张图片的名字
            //        imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            imageView.backgroundColor=[UIColor redColor];
            
            [self addSubview:imageView];
        }
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, imageH+30, ConentViewWidth, 20)];
        label.text=@"分享语";
        UILabel *share_moreText=[[UILabel alloc]initWithFrame:CGRectMake(5,  imageH+50, ConentViewWidth, 20)];
        share_moreText.text=@"只是分享的图片";
        UIButton *copy_btn=[[UIButton alloc]initWithFrame:CGRectMake(ConentViewWidth-100,imageH+60, 80, 20)];
        [copy_btn setTitle:@"复制内容" forState:UIControlStateNormal];
        copy_btn.layer.cornerRadius=5;
        copy_btn.layer.borderWidth=1;
        copy_btn.layer.borderColor=[UIColor grayColor].CGColor;
    
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
