
//
//  CZLoopViewCell.m
//
//  Created by Apple on 16/3/23.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZLoopViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation CZLoopViewCell {
    UIImageView *_imageView;
}

// collectionViewCell 的 frame 是根据之前的 layout 已经确定好的！
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"%@", NSStringFromCGRect(frame));
        
        // 添加图像视图
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
- (void)setImage:(UIImage *)image{
    _imageView.image = image;
}
- (void)setUrl:(NSString *)url{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
}

//- (void)setUrl:(NSString *)url{
//    _url = url;
//    // 1. 根据 URL 获取二进制数据
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    _imageView.image = [UIImage imageWithData:data];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
//
//    // 2. 将二进制数据转换成图像
//}


@end
