//
//  leftCollectionViewCell.m
//  MeiPinJie
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "leftCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Model.h"
#import "HMFileManager.h"
@implementation leftCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _picImageView = [[UIImageView alloc]init];
        _view = [[UIView alloc] init];
        //   _view.backgroundColor = [UIColor redColor];
        _userImage = [[UIImageView alloc] init];
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.cornerRadius = 15;
        [self.contentView addSubview:_picImageView];
        [_view addSubview:_userImage];
        [self.contentView addSubview:_view];
        
        
        
        
        
    }
    return self;
}

-(void)setModel:(Model *)model
{
    _model = model;
    
    //    _picImageView.frame = self.contentView.frame;
    
    //   [_userImage sd_setImageWithURL:[NSURL URLWithString:_model.mimgfile]];
    NSString *imageurl = [NSString stringWithFormat:@"%@%@",@"http://test.cdn2.p.meilianbao.net",model.ThumbUrl];
    NSLog(@"imageurl == %@",imageurl);
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"1"]];
    
}
//layoutAttributes = Itme
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _picImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height- 20);
    [_view setFrame:CGRectMake(0, layoutAttributes.frame.size.height-40, layoutAttributes.frame.size.width, 40)];
    [_userImage setFrame:CGRectMake(5, 0, 30, 30)];
    
    
}


@end
