

//
//  PostProgressView.m
//  lvpai
//
//  Created by MaShuai on 15/9/29.
//  Copyright © 2015年 司马帅帅. All rights reserved.
//

#import "PostProgressView.h"
#import "ProgressView.h"

@interface PostProgressView ()
{
    ProgressView *_progressView;
}
@end

@implementation PostProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *progressImage = [UIImage imageNamed:@"lp_progressBackImage"];
        //初始化_progressView
        _progressView = [[ProgressView alloc] initWithImage:progressImage lineWidth:13 bgColor:[UIColor greenColor] fgColor:[UIColor redColor]];
        _progressView.center = self.center;
        [self addSubview:_progressView];
    }
    return self;
}

//显示
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [self setBackgroundColor:[UIColor clearColor]];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.4f]];
                     } completion:nil];
    
}

//隐藏
- (void)hide
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self setBackgroundColor:[UIColor clearColor]];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

//更新进度
- (void)updateWithProgress:(CGFloat)progress
{
    NSLog(@"%s %f",__func__, progress);
    _progressView.progress = progress;
}


@end
