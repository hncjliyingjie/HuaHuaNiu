//
//  UIImage+CH.m
//  新闻
//
//  Created by Think_lion on 15/5/4.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "UIImage+CH.h"

@implementation UIImage (CH)


+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+(UIImage *)resizedImage:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image=[UIImage imageNamed:name];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*left topCapHeight:image.size.height*top];
    return image;
}








@end
