//
//  HelpWebView.m
//  HuaHuaNiu
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "HelpWebView.h"

@implementation HelpWebView

- (instancetype)initWithFrame:(CGRect)frame with:(NSString *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];

        NSString *str = data;
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [self loadData:data MIMEType:nil textEncodingName:nil baseURL:nil];

    }
    return self;
}

- (void)setData:(NSData *)data{
    
}

@end
