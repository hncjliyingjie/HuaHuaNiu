//
//  ReleaseTaskfourthCell.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "ReleaseTaskfourthCell.h"

@interface ReleaseTaskfourthCell()<UITextViewDelegate>
@property(nonatomic,strong)UILabel* numberLabel;
@property(nonatomic,strong)UILabel* tipLabel;
@end

@implementation ReleaseTaskfourthCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField_phone = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        self.textField_phone.font = [UIFont systemFontOfSize:12];
        self.textField_phone.backgroundColor = [UIColor whiteColor];
        self.textField_phone.layer.cornerRadius = 5;
        self.textField_phone.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        self.textField_phone.keyboardType = UIKeyboardTypePhonePad;
        self.textField_phone.layer.borderWidth = 0.5;
        self.textField_phone.leftViewMode = UITextFieldViewModeAlways;
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 30)];
        label.text = @"联系号码:";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        self.textField_phone.leftView = label;
        [self.contentView addSubview:_textField_phone];
        
        float y = 40 + 10;
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 140)];
        view.layer.cornerRadius = 5;
        view.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        view.layer.borderWidth = 0.5;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 15)];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];

        label.text = @"任务要求:";
        [view addSubview:label];
        
        self.textView_taskRequest = [[UITextView alloc]initWithFrame:CGRectMake(5, 25, view.frame.size.width - 10, 90)];
        self.textView_taskRequest.font = [UIFont systemFontOfSize:12];
        self.textView_taskRequest.delegate = self;
        self.textView_taskRequest.text= @"1、请仔细阅读分享规则及任务要求，确保任务准确分享。\r\n2、成功分享2小时后上传分享截图。\r\n3、至少手机一条非发布者的赞和评论。\r\n ";
        [view addSubview:_textView_taskRequest];
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 115, 200, 25)];
        label.text = @"可以输入更多要求...";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        self.tipLabel = label;
        
        label = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width - 50, 115, 50, 25)];
        label.text = @"0/500";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        self.numberLabel = label;
        
        y += view.frame.size.height + 10;
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 25);
        [button.layer setCornerRadius:12.5];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setBackgroundColor:[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1]];

        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        y += button.frame.size.height + 20;
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width - 20, 200)];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"友情提示：\n1.任务要求仅限分享图文或链接、以及投票、关注、扫码、点击、注册、下载等简单要求，要求过多一律审核不通过；\n2.要求上传截图时间不得超过4小时；\n3.如果对接单红人粉丝数有要求请发指定任务；\n4.该订单投放模式只允许发展示曝光，扫描关注，下载注册类任务，如需发布其它类型订单请咨询电话400-1818-878转订单。";
        [label sizeToFit];
        [self.contentView addSubview:label];
    }
    return self;
}

-(void)next
{
    if (self.nextBlock) {
        self.nextBlock();
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length >= 500) {
        textView.text = [textView.text substringToIndex:500];
        self.tipLabel.hidden = YES;
    }
    else{
        self.tipLabel.hidden = NO;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/500",textView.text.length];
}

+(CGFloat)getHeight
{
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20, 400)];
    label.textColor = [UIColor grayColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"友情提示：\n1.任务要求仅限分享图文或链接、以及投票、关注、扫码、点击、注册、下载等简单要求，要求过多一律审核不通过；\n2.要求上传截图时间不得超过4小时；\n3.如果对接单红人粉丝数有要求请发指定任务；\n4.该订单投放模式只允许发展示曝光，扫描关注，下载注册类任务，如需发布其它类型订单请咨询电话400-1818-878转订单。";
    [label sizeToFit];
    return label.frame.size.height + 260;
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
