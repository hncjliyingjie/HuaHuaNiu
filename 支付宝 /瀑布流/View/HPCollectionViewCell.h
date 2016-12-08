//
//  HPCollectionViewCell.h
//  mokoo
//
//  Created by Mac on 15/9/20.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"


@interface HPCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)HomeModel * shop;
@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingNameLableConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationNameConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationIconConstraint;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com