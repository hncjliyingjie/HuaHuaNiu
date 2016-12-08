//
//  DatePickerView.m
//  EnterpriseAPP
//
//  Created by 肖燊亮 on 15/8/3.
//  Copyright (c) 2015年 肖燊亮. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()
@property (nonatomic,strong)UIDatePicker* datePicker;
@end

@implementation DatePickerView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        view.backgroundColor = [UIColor colorWithRed:240 green:240 blue:240 alpha:1];
        [self addSubview:view];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, view.frame.size.height);
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(frame.size.width - 60, 0, 60, view.frame.size.height);
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, frame.size.height - 216,frame.size.width, 216)];
        // 设置区域为中国简体中文
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        // 设置picker的显示模式：只显示日期
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.datePicker = datePicker;
        [self addSubview:datePicker];
    }
    return  self;
}

-(void)setDatePickerMode:(UIDatePickerMode)model
{
    self.datePicker.datePickerMode = model;
}


-(void)cancel
{
    if(_delegate && [_delegate respondsToSelector:@selector(hitCancelCallBack)])
    {
        [_delegate hitCancelCallBack];
    }
}

-(void)sure
{
    if(_delegate && [_delegate respondsToSelector:@selector(hitSureCallBack:)])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date = [dateFormatter stringFromDate:_datePicker.date];
        [_delegate hitSureCallBack:date];
    }
}

+(CGFloat)getHeight
{
    return 260;
}
@end
