//
//  DaijianquanXQViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaijianquanXQViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>{
    UIScrollView *BackView;
 
    // 数据源
    NSDictionary * dic ;
    // 代金券ID
    NSString * VIdStr;
    // 是领取的还是看详情的
    
    BOOL  LingQu;
}
// yes  为领取
-(id)initVidWIthStr:(NSString *)Str andLIingqu:(BOOL) linqu;

@end
