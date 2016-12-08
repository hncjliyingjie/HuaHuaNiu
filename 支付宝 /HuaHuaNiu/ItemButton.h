//
//  ItemButton.h
//  MVVMTest
//
//  Created by baokuanxun on 16/11/18.
//  Copyright © 2016年 biubiubiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BorderColor  [UIColor colorWithRed:0.320 green:0.644 blue:1.000 alpha:1.000]
#define TitleColor [UIColor colorWithRed:0.320 green:0.644 blue:1.000 alpha:1.000]
#define GrayColor [UIColor colorWithWhite:0.686 alpha:1.000]
@interface ItemButton : UIButton


-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;
@end
