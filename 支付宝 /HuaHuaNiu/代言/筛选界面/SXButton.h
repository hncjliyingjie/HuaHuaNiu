//
//  SXButton.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/19.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BorderColor  [UIColor colorWithRed:0.320 green:0.644 blue:1.000 alpha:1.000]
#define TitleColor [UIColor colorWithRed:0.320 green:0.644 blue:1.000 alpha:1.000]
#define GrayColor [UIColor colorWithWhite:0.686 alpha:1.000]

//@protocol ButtonSelectedDeleagte;

@interface SXButton : UIButton

//@property(assign,nonatomic)id <ButtonSelectedDeleagte>ButtonSelectedDeleagte;

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title ;
@end
