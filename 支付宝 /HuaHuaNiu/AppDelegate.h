//
//  AppDelegate.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-2-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//com.daiyancheng.HuaHuaNiu1

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate>{
    BMKMapManager* _mapManager;
    Reachability * hostReach;
    
    
}

@property (strong, nonatomic) UIWindow *window;


@end

