//
//  WebViewController.m
//  HuaHuaNiu
//
//  Created by yuanzhi on 16/3/14.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:@"news-detail" ofType:@"html"];
    NSURL *url=[NSURL fileURLWithPath:readmePath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

    // Do any additional setup after loading the view from its nib.
}
- (void)webViewDidFinishLoad:(UIWebView *)aWebView{
    NSURL *url=[[NSURL alloc]init];
    NSString *str=[NSString stringWithFormat:@"http://city.hntv.tv/e/api/getNewsContent.php?id=%@&classid=2&appkey=e7627f53d4712552f8d82c30267d9bb4",_strId];
    url = [NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //    request.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding
            NSLog(@"%@",dict);
            NSString *str= [[[dict objectForKey:@"data"] objectForKey:@"content"] objectForKey:@"newstext"];
            NSString *str1=[NSString stringWithFormat:@"<h2 style=\"padding-bottom: 0px; margin: 0px 0px 6px; padding-left: 0px; padding-right: 0px; color: rgb(34,34,34); font-size: 18px; font-weight: normal; padding-top: 0px\">%@</h2><p class=\"grey\" style=\"padding-bottom: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; color: rgb(126,126,126); padding-top: 0px\">%@  来源：大象网</p>%@",_strTitle,_strTime,str];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
            str1 = [str1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
            NSLog(@"%@",str1);
            NSString*strCount=[NSString stringWithFormat:@"document.getElementById('content').innerHTML='%@'",str1];
            NSString*strAuthor=[NSString stringWithFormat:@"document.getElementById('article-title').innerHTML='（记者王迎节）'"];
            NSString*strUsername=[NSString stringWithFormat:@"document.getElementById('username').innerHTML='大象编辑忘'"];
            NSString*strNewstime=[NSString stringWithFormat:@"document.getElementById('newstime').innerHTML='2016-3'"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [_webView stringByEvaluatingJavaScriptFromString:strCount];
                    [_webView stringByEvaluatingJavaScriptFromString:strAuthor];
                    [_webView stringByEvaluatingJavaScriptFromString:strUsername];
                    [_webView stringByEvaluatingJavaScriptFromString:strNewstime];
                });
            });
            //           NSLog(@"%@",[[array objectAtIndex:0] objectForKey:@"caption"]) ;
            
        }else{
            //出现错误；
            NSLog(@"错误信息：%@",error);
        }
    }];
    
    
    [dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
