//
//  TFModel.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFModel : NSObject
@property  (strong,nonatomic)UIImage *img;//图标
@property int  str;//区分哪一个按钮
@property(strong,nonatomic)UITextField *textField;
@end
