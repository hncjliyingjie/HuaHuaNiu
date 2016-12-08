//
//  CollectionViewCell.m
//  瀑布流自己的
//
//  Created by dllo on 15/10/28.
//  Copyright © 2015年 zhaoqingwen. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Model.h"
#import "HMFileManager.h"
@implementation CollectionViewCell

- (UILabel *)prefer{
    if (!_prefer) {
        _prefer = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 25, 5, 30, 13)];
        _prefer.font = [UIFont systemFontOfSize:12];
        _prefer.textAlignment = UITextAlignmentLeft;
        _prefer.textColor = [UIColor grayColor];
        
    }
    return _prefer;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prefer];
        _picImageView = [[UIImageView alloc]init];
        UIColor *color1 = UIColorFromRGB(0x898992);
        UIColor *color2 = UIColorFromRGB(0x6b5b5c);
        UIColor *color3 = UIColorFromRGB(0x67695c);
        UIColor *color4 = UIColorFromRGB(0x676a5a);
        UIColor *color5 = UIColorFromRGB(0x655a6d);
        UIColor *color6 = UIColorFromRGB(0x52616e);
        NSArray *array = [NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6, nil];
        int i =  arc4random() % 6;
        //  NSLog(@"imageurl == %@",imageurl);
        _picImageView.backgroundColor = array[i];
        
        _view = [[UIView alloc] init];
      //  _view.backgroundColor = [UIColor whiteColor];
        _userImage = [[UIImageView alloc] init];
        _userImage.layer.masksToBounds = YES;
        _userImage.layer.cornerRadius = 15;
        _userImageView = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 32, 32)];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 16;
        _userImageView.backgroundColor = [UIColor whiteColor];
        
        _hairshowLike = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 40, 3, 15, 15)];
    //    _hairshowLike.image = [UIImage imageNamed:@"hairshowlike"];
        _hairshowLike.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 16, self.frame.size.width, 24)];
        backView.backgroundColor = [UIColor whiteColor];
        [_view addSubview:backView];
        
        _isPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 25, 10, 15, 15)];
        
        [self.contentView addSubview:_picImageView];
        [_picImageView addSubview:_isPhoto];
        [_userImageView addSubview:_userImage];
        [backView addSubview:_hairshowLike];
        [backView addSubview:_prefer];
        [_view addSubview:_userImageView];
        [self.contentView addSubview:_view];
        
        
        
        
        
    }
    return self;
}

-(void)setModel:(Model *)model
{
    _model = model;
    if (model.VideoAddr.length == 0) {
        [_isPhoto setImage:[UIImage imageNamed:@"icon_image"]];
    }else{
        [_isPhoto setImage:[UIImage imageNamed:@"touming"]];
    }
    NSString *string = [NSString stringWithFormat:@"%@",model.PointCount];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [_prefer setFrame:CGRectMake(self.frame.size.width - textSize.width - 10, 5, textSize.width + 10, 13)];
    [_hairshowLike setFrame:CGRectMake(self.frame.size.width - textSize.width - 30, 3, 20, 20)];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _picImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height- 20);
    [_view setFrame:CGRectMake(0, layoutAttributes.frame.size.height-40, layoutAttributes.frame.size.width, 40)];
    [_userImage setFrame:CGRectMake(1, 1, 30, 30)];
  
   
}

@end
