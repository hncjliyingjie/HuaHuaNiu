//
//  QiuZhiDeatilViewController.h
//  HuaHuaNiu
//
//  Created by alex on 15/10/24.
//  Copyright © 2015年 张燕. All rights reserved.
//
@protocol QiuzhiDeatilDelegate <NSObject>

-(void)refreshTV;

@end
#import <UIKit/UIKit.h>
#import "QiuZhiModel.h"
@interface QiuZhiDeatilViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)QiuZhiModel * currentModel;
@property (nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)NSString *count1;
@end
