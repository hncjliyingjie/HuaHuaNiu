//
//  TableViewCell.m
//  HuaHuaNiu
//
//  Created by alex on 16/1/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview];
    }
    return self;
}

-(void)addSubview
{
//    self.image_smalla = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 180)];
//    [self addSubview:self.image_smalla];
    
    
    self.newsName = [[UILabel alloc]initWithFrame:CGRectMake(10, 0 ,ConentViewWidth-20, 40)];
    self.newsName.textAlignment = UITextAlignmentLeft;
    self.newsName.numberOfLines = 2;
    self.newsName.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.newsName];
    self.newsLeibie = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.newsName.frame)+2 ,60, 20)];
    self.newsLeibie.font = [UIFont systemFontOfSize:12];
    self.newsLeibie.textColor = [UIColor blueColor];
    [self addSubview:self.newsLeibie];
    self.newsTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.newsLeibie.frame), self.newsLeibie.frame.origin.y,100, 20)];
    self.newsTime.font = [UIFont systemFontOfSize:10];
    self.newsTime.textColor = [UIColor grayColor];
    [self addSubview:self.newsTime];
    self.newsmain = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.newsTime.frame)+2 ,ConentViewWidth-20, 40)];
    self.newsmain.textAlignment = UITextAlignmentLeft;
    self.newsmain.numberOfLines = 2;
    self.newsmain.font = [UIFont systemFontOfSize:12];
    self.newsmain.textColor = [UIColor grayColor];
    [self addSubview:self.newsmain];
    
}

//-(void)setTitleCellWithModel:(ZHModel *)gameModel
//{
//    [self.image_smalla sd_setImageWithURL:[NSURL URLWithString:gameModel.imgsrc]];
//    self.titleLabela.text = gameModel.title;
//}





-(void)cellMakeDataWithDic:(NSDictionary *)dic{
    self.newsName.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
    [self addSubview:self.newsName];
    self.newsLeibie.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"classname"]];

    self.newsTime.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"newstime"]];
    self.newsmain.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"smalltext"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
