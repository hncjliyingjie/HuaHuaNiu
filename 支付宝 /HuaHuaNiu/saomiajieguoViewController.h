//
//  saomiajieguoViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15/5/26.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface saomiajieguoViewController : UIViewController<UIWebViewDelegate>{
    UIWebView *MYView;
    NSString * urlStr;
}
-(id)initWithSte:(NSString *)str;
@end
