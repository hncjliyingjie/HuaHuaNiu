//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define Log(...) NSLog(__VA_ARGS__)
#else
#define Log(...)
#endif

#import <UIKit/UIKit.h>
// 文字颜色
#define RefreshLabelTextColor [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]

extern const CGFloat RefreshViewHeight;
extern const CGFloat RefreshAnimationDuration;

extern NSString *const RefreshBundleName;
#define kSrcName(file) [RefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const RefreshFooterPullToRefresh;
extern NSString *const RefreshFooterReleaseToRefresh;
extern NSString *const RefreshFooterRefreshing;

extern NSString *const RefreshHeaderPullToRefresh;
extern NSString *const RefreshHeaderReleaseToRefresh;
extern NSString *const RefreshHeaderRefreshing;
extern NSString *const RefreshHeaderTimeKey;

extern NSString *const RefreshContentOffset;
extern NSString *const RefreshContentSize;