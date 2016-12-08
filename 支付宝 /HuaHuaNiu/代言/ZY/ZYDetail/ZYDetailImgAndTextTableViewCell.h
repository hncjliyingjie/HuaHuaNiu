//
//  ZYDetailImgAndTextTableViewCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/12/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYDetailImgAndTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (nonatomic, strong) NSString *imgURLStr;//图片网址
//展示数据
- (void)showData;

@end
