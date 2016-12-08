//
//  ItemView.h
//  MVVMTest
//
//  Created by baokuanxun on 16/11/18.
//  Copyright © 2016年 biubiubiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemButton.h"
@interface ItemView : UIView


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
@property (nonatomic ,strong)ItemButton * selectBtn;

- (instancetype)initWithFrame:(CGRect)frame withData:(NSMutableArray *)dataArr withTitle:(NSString *) title;
@end
