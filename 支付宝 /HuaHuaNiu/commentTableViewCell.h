//
//  commentTableViewCell.h
//  MeiPinJie
//
//  Created by mac on 15/11/20.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentModel.h"
@interface commentTableViewCell : UITableViewCell
{
    CGFloat replyheight;
}

@property (nonatomic, strong)UIImageView *UserImage;
@property (nonatomic, strong)UILabel *UserLabel;
@property (nonatomic, strong)UIView *fengeView;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *content;
@property (nonatomic, strong)UILabel *replyContent;
@property (nonatomic, strong)UIView *ReplyView;
@property (nonatomic, strong)UIImageView *jianView;
- (void)configerWithModel:(commentModel *)model;

+ (CGFloat)cellHeightWithModel:(commentModel *)model;
@end
