//
//  HelpWebView.h
//  HuaHuaNiu
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpWebView : UIWebView
@property (nonatomic,strong) NSString *data;
- (instancetype)initWithFrame:(CGRect)frame with:(NSString *)data;
@end
