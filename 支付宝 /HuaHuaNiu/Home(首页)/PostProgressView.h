//
//  PostProgressView.h
//  lvpai
//
//  Created by MaShuai on 15/9/29.
//  Copyright © 2015年 司马帅帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostProgressView : UIView

//显示
- (void)showInView:(UIView*)view;
//隐藏
- (void)hide;
//接收进度
- (void)updateWithProgress:(CGFloat)progress;

@end
