//
//  ReleaseTaskThirdCell.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "ReleaseTaskThirdCell.h"

@interface ReleaseTaskThirdCell()
@property(nonatomic,strong)UIView* view_beginTime;
@property(nonatomic,strong)UIView* view_endTime;
@property(nonatomic,strong)UILabel* label_beginTime;
@property(nonatomic,strong)UILabel* label_endTime;
@property(nonatomic,strong)UIButton* button_instantly;
@property(nonatomic,strong)UIButton* button_custom;
@end

@implementation ReleaseTaskThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        float y = 10;
        
        //立即开始选项
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        view.backgroundColor = [UIColor whiteColor];
        view.layer.borderWidth = 0.5;
        [self.contentView addSubview:view];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 30);
        [view addSubview:button];
        self.button_instantly = button;
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 200, 30)];
        label.text = @"立即开始，两天后结束";
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 2000;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(view.frame.size.width - 70 - 30, 0, 30, 30);
        [view addSubview:button];
        self.button_custom = button;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width - 70, 0, 70, 30)];
        label.text = @"时间自定义";
        label.font = [UIFont systemFontOfSize:12];
        [view addSubview:label];
        
        //开始时间
        y += view.frame.size.height + 10;
        view = [[UIView alloc]initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        view.layer.borderWidth = 0.5;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.view_beginTime = view;
        
        //开始时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *date = [dateFormatter stringFromDate:[NSDate date]];

        NSString* d =[dateFormatter stringFromDate: [NSDate dateWithTimeIntervalSinceNow:86400 * 2]];
       ;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.frame.size.width - 20, 30)];
        label.font = [UIFont systemFontOfSize:12];
//        label.text = @"开始时间：";
         label.text = [NSString stringWithFormat:@"开始时间：%@",date];
        [view addSubview:label];
        self.label_beginTime = label;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 3000;
        button.frame = view.bounds;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        //结束时间
        y += view.frame.size.height + 10;
        view = [[UIView alloc]initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        view.layer.borderWidth = 0.5;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        self.view_endTime = view;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.frame.size.width - 20, 30)];
        label.font = [UIFont systemFontOfSize:12];
//        label.text = @"结束时间：";
        label.text = [NSString stringWithFormat:@"结束时间：%@",d];
        [view addSubview:label];
        self.label_endTime = label;
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 4000;
        button.frame = view.bounds;
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return self;
}

-(void)onClick:(UIButton*)button
{
    if(button.tag == 1000){//立即开始
        [self.button_instantly setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        [self.button_custom setImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
        if(self.instantlyBlock){
            self.instantlyBlock();
        }
    }
    else if (button.tag == 2000){//自定义时间
        [self.button_custom setImage:[UIImage imageNamed:@"selected.png"] forState:UIControlStateNormal];
        [self.button_instantly setImage:[UIImage imageNamed:@"normal.png"] forState:UIControlStateNormal];
        if (self.customBlock) {
            self.customBlock();
        }
    }
    else if (button.tag == 3000){//开始时间
        if(self.beginTimeBlock){
            self.beginTimeBlock();
        }
    }
    else{
        if (self.endTimeBlock) {
            self.endTimeBlock();
        }
    }
}

-(void)setBeginTime:(NSString *)beginTime
{
    _beginTime = beginTime;
    self.label_beginTime.text = [@"开始时间: "  stringByAppendingString:beginTime ];
}

-(void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    self.label_endTime.text = [@"结束时间: "  stringByAppendingString:endTime];
}

-(void)setIsCustom:(BOOL)isCustom
{
    _isCustom = isCustom;
    self.view_endTime.hidden = !isCustom;
    self.view_beginTime.hidden = !isCustom;
    isCustom ? [self onClick:self.button_custom] : [self onClick:self.button_instantly];
}

+(CGFloat)getHeight:(BOOL)isCustom
{
    return isCustom ? 120 : 40;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
