//
//  ViewController.h
//  ZFChartView
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    kChartTypeBarChart = 0,
    kChartTypeLineChart = 1,
    kChartTypePieChart = 2
}kChartType;

@interface ViewControllerZhu : UIViewController

@property (nonatomic, assign) kChartType chartType;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com