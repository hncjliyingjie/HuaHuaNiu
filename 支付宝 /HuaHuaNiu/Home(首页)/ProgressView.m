//
//  ProgressView.m
//  lvpai
//
//  Created by MaShuai on 15/9/29.
//  Copyright © 2015年 司马帅帅. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()
{
    CGFloat _progress;
    CGFloat _lineWidth;//线宽
    UIColor *_backgroundColor;//背景色
    UIColor *_foregroundColor;//前景色
    UILabel *_progressLabel;//显示进度的标签
}
@end

@implementation ProgressView

- (id)initWithImage:(UIImage *)image
          lineWidth:(CGFloat)lineWidth
            bgColor:(UIColor *)backgroundColor
            fgColor:(UIColor *)foregroundColor
{
    self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    if (self) {
        //把图片转成颜色 设置背景颜色
        [self setBackgroundColor:[UIColor colorWithPatternImage:image]];
        
        _lineWidth = lineWidth;
        _backgroundColor = backgroundColor;
        _foregroundColor = foregroundColor;
        
        //初始化进度标签_progressLabel
        _progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_progressLabel setTextAlignment:NSTextAlignmentCenter];
        [_progressLabel setBackgroundColor:[UIColor clearColor]];
        [_progressLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [self addSubview:_progressLabel];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    //赋值
    _progress = progress;
    //设置_progressLabel的显示内容
    [_progressLabel setText:[NSString stringWithFormat:@"%.f%%",progress*100]];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //设置路径
    UIBezierPath *backPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2-_lineWidth/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //设置路径宽度
    [backPath setLineWidth:_lineWidth];
    //设置画笔颜色
    [_backgroundColor setStroke];
    //画路径
    [backPath stroke];
    
    if (_progress) {
        //设置路径
        UIBezierPath *forePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2-_lineWidth/2 startAngle:-M_PI/2 endAngle:-M_PI/2+ M_PI*2*_progress clockwise:YES];
        //设置路径宽度
        [forePath setLineWidth:_lineWidth];
        //设置画笔颜色
        [_foregroundColor setStroke];
        //画路径
        [forePath stroke];
    }
}

@end
