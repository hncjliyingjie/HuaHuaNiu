//
//  ProgressView.h
//  lvpai
//
//  Created by MaShuai on 15/9/29.
//  Copyright © 2015年 司马帅帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

//初始化方法
- (id)initWithImage:(UIImage *)image
          lineWidth:(CGFloat)lineWidth
            bgColor:(UIColor *)backgroundColor
            fgColor:(UIColor *)foregroundColor;

@end
