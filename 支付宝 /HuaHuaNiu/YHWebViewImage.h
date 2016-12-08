//
//  YHWebViewImage.h
//  测试 WebVIew
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YHWebViewImageDelegate <NSObject>

- (void)upDateFrame:(CGRect)frame;

@end
@interface YHWebViewImage : UIWebView

@property (nonatomic,weak) id<YHWebViewImageDelegate> frameDelegate;
- (instancetype)initWithFrame:(CGRect)frame urlStr:(NSString *)urlString;
@end
