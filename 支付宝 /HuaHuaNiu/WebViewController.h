//
//  WebViewController.h
//  HuaHuaNiu
//
//  Created by yuanzhi on 16/3/14.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property(nonatomic,strong)IBOutlet UIWebView *webView;
@property(nonatomic,strong)NSString *strId;
@property(nonatomic,strong)NSString *strTitle;
@property(nonatomic,strong)NSString *strTime;
@end
