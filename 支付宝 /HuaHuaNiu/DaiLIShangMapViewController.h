//
//  DaiLIShangMapViewController.h
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface DaiLIShangMapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKMapView* _mapView;
    //大头针 
   // BMKPointAnnotation *annotation;
// 定位
    // BMKLocationService  * _locService ;
// 编译
   // BMKGeoCodeSearch* _geocodesearch;
    // 穿的参数
    NSMutableArray *DataArr ;
    
    // 坐标
    NSArray * LLarr;
    
}
-(id)initWithArr:(NSMutableArray *)Arr;
@end
