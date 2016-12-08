//
//  CollectionViewCell.m
//  FastDoctor--Five
//
//  Created by 王明 on 16/3/12.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CollectionViewCell.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width

@implementation CollectionViewCell

//模型
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        self.imageView = imageView;
        
        imageView.image = self.image;
        
        [self.contentView addSubview:imageView];
        
    }
    
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;

}


@end
