//
//  HHContentTableView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ZYMViewController;
//
//@protocol ZYMViewControllerDelegate <NSObject>
//
//-(void)webViewLoadRequest;

//@end

@interface HHContentTableView : UITableView


+ (HHContentTableView *)contentTableView;
//
@property(strong,nonatomic)UIWebView *webView;
//
//@property(weak,nonatomic)id <ZYMViewControllerDelegate> zydelegate;

@end
