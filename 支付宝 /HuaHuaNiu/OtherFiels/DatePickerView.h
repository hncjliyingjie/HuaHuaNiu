//
//  DatePickerView.h
//  EnterpriseAPP
//
//  Created by 肖燊亮 on 15/8/3.
//  Copyright (c) 2015年 肖燊亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerViewDelegate<NSObject>
-(void)hitSureCallBack:(NSString*)string;
-(void)hitCancelCallBack;
@end

@interface DatePickerView : UIView
@property(nonatomic,weak)id<DatePickerViewDelegate> delegate;
-(void)setDatePickerMode:(UIDatePickerMode)model;
+(CGFloat)getHeight;
@end
