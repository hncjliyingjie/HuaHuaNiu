//
//  CollectionViewCell.m
//  FastDoctor--Five
//
//  Created by 王明 on 16/3/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CZCollectionViewCell.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width

@implementation CZCollectionViewCell

//模型
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        self.imageView = imageView;
        
        [self.contentView addSubview:imageView];
        
    }
    
    return self;
}

- (void)setUrl:(NSString *)url{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}


@end
