//
//  ITemViews.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXButton.h"
@interface ITemViews : UIView

/**
 *  一行有多少个item
 */
@property (nonatomic ,assign)NSInteger columns;
/**
 *  数据源
 */
@property (nonatomic ,strong)NSMutableArray * dataArr;
/**
 *  当前选中的按钮
 */
@property (nonatomic ,strong)SXButton * selectBtn;

- (instancetype)initWithFrame:(CGRect)frame withData:(NSMutableArray *)dataArr withTitle:(NSString *) title;
@end
