//
//  commentTableViewCell.m
//  MeiPinJie
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "commentTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation commentTableViewCell
{
    int height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)UserImage{
    if (!_UserImage) {
        _UserImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 36, 36)];
        _UserImage.layer.masksToBounds = YES;
        _UserImage.layer.cornerRadius = 2.0f;
        [self.contentView addSubview:_UserImage];
    }
    return _UserImage;
}

- (UILabel *)UserLabel{
    if (!_UserLabel) {
    _UserLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 20)];
        _UserLabel.textColor = [UIColor lightGrayColor];
    _UserLabel.font = [UIFont systemFontOfSize:14];
        
    [self.contentView addSubview:_UserLabel];
    }
    return _UserLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDH - 105, 10, 100, 20)];
    _timeLabel.textAlignment = UITextAlignmentRight;
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
        
    }
    return _timeLabel;
}

- (UIView *)fengeView{
    if (!_fengeView) {
        _fengeView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 3, VIEW_WIDH, 1)];
        _fengeView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self.contentView addSubview:_fengeView];
    }
    return _fengeView;
}

- (UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc] initWithFrame:(CGRect){60, 35, VIEW_WIDH - 65, 0}];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:14];
       
        [self.contentView addSubview:_content];
            
    }
    return _content;
}

- (UILabel *)replyContent{
    if (!_replyContent) {
        _replyContent = [[UILabel alloc] initWithFrame:(CGRect){60,45+_content.frame.size.height,VIEW_WIDH - 65,30}];
        _replyContent.numberOfLines = 0;
      //  _replyContent.backgroundColor = [UIColor lightGrayColor];
        _replyContent.font = [UIFont systemFontOfSize:14];
        _replyContent.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_replyContent];
        
    }
    return _replyContent;
}

- (UIImageView *)jianView{
    if (!_jianView) {
        _jianView = [[UIImageView alloc] initWithFrame:CGRectMake(85, 50 +_content.frame.size.height, 20, 10)];
        _jianView.image = [UIImage imageNamed:@"showcell"];
    }
    return _jianView;
}


- (UIView *)ReplyView{
    if (!_ReplyView) {
        _ReplyView = [[UIView alloc] initWithFrame:CGRectMake(55, 45 +_content.frame.size.height, VIEW_WIDH - 60, 30)];
        _ReplyView.layer.masksToBounds = YES;
        _ReplyView.layer.cornerRadius = 3.0f;
        _ReplyView.backgroundColor = UIColorFromRGB(0xe5e5e5);
        [self.contentView addSubview:_ReplyView];
    }
    return _ReplyView;
}




- (void)configerWithModel:(commentModel *)model{
    self.content.text = model.Content;
    self.timeLabel.text = model.time;
    self.UserLabel.text = model.UserName;
    NSLog(@"model.replyContent == %@",model.replyContent);
    
    //self.replyContent.text = [NSString stringWithFormat:@"%@%@%@",model.replyUserName,@":",model.replyContent];
    
    
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    CGRect contentFrame = self.content.frame;
    contentFrame.size.height = [self contentHeight:self.content];
    self.content.frame = contentFrame;
    if (self.replyContent.text != NULL) {
        CGRect replyConcent = self.replyContent.frame;
        replyConcent.origin.y = contentFrame.size.height + 50;
        replyConcent.size.height = [self contentHeight:self.replyContent];
        height = replyConcent.size.height;
        self.replyContent.frame = replyConcent;
        
        [self.ReplyView setFrame:CGRectMake(50, 45 +_content.frame.size.height, VIEW_WIDH - 60, replyConcent.size.height + 10)];
        [self.jianView setFrame:CGRectMake(78, 35 +_content.frame.size.height, 20, 10)];
        
    }
    
    [self.fengeView setFrame:CGRectMake(0, self.frame.size.height -1, VIEW_WIDH, 0.5)];
    
    [super layoutSubviews];
}


- (CGFloat)contentHeight:(UILabel *)label {
    CGFloat height = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.height;
    return height;
}


+ (CGFloat)cellHeightWithModel:(commentModel *)model {
    CGFloat height = [model.Content boundingRectWithSize:CGSizeMake(VIEW_WIDH - 65, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
  
    CGFloat height1;
    if ([model.replyContent isKindOfClass:[NSNull class]]) {
  
        height1 = 0;
    }else{
        NSString *string = [NSString stringWithFormat:@"%@%@%@",model.UserName,@" : ",model.replyContent];
        height1 = [string boundingRectWithSize:CGSizeMake(VIEW_WIDH - 65, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + 20;
        
       
    }
    
    
    return height  +  height1 + 50;
}


@end
