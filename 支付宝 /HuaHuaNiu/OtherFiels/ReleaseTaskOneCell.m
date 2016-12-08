//
//  ReleaseTaskOneCell.m
//  demo
//
//  Created by 肖燊亮 on 2016/11/26.
//  Copyright © 2016年 肖燊亮. All rights reserved.
//

#import "ReleaseTaskOneCell.h"

@interface ReleaseTaskOneCell()
@property(nonatomic,strong)UILabel* numberLabel;
@end

@implementation ReleaseTaskOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 30)];
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.font = [UIFont systemFontOfSize:12];
        self.textField.placeholder = @"任务名称，15字内最佳，将作为分享链接的标题";
        self.textField.layer.cornerRadius = 5;
        self.textField.layer.borderColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor;
        self.textField.layer.borderWidth = 0.5;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.textColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        self.numberLabel.font = [UIFont systemFontOfSize:12];
        self.numberLabel.text = @"0/50";
        self.textField.rightView = self.numberLabel;
        [self.textField addTarget:self action:@selector(limit:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_textField];
        
    }
    return self;
}

- (void)limit:(UITextField *)textField
{
    if (textField.text.length >= 50) {
        textField.text = [textField.text substringToIndex:50];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/50",textField.text.length];
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
