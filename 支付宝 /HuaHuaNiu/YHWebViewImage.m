//
//  YHselfViewImage.m
//  测试 selfVIew
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "YHWebViewImage.h"

@interface YHWebViewImage ()<UIWebViewDelegate>
@end

@implementation YHWebViewImage

- (instancetype)initWithFrame:(CGRect)frame urlStr:(NSString *)urlString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollEnabled = NO;
        [self sizeToFit];

        NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"selfview_content_wrapper\">%@</div>", urlString];
//        [self loadHTMLString:htmlcontent baseURL:nil];
        
        [self loadHTMLString:[self reSizeImageWithHTML:htmlcontent] baseURL:[NSURL URLWithString:@"http://daiyancheng.cn/"]];

    }
    return self;
}

- (NSString *)reSizeImageWithHTML:(NSString *)html {
    //<head><style>img{max-width:320px !important;}</style></head>
    return [NSString stringWithFormat:@"<head><style>img{max-width:%dpx !important;}</style></head>%@",(int)self.frame.size.width- 15, html];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到selfView上
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, clientheight);
    //获取selfView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('selfview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    //再次设置selfView高度（点）
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    [self.frameDelegate upDateFrame:self.frame];
}

@end
